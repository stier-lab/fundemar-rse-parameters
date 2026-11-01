#!/usr/bin/env Rscript
# Source-to-model checks for origin, interval eligibility and collector repairs.
suppressPackageStartupMessages({library(dplyr); library(readr)})
source("06_analysis/scripts/utils/shared_utilities.R")
out <- "06_analysis/output"
s <- read_prepared_survival_data()
inventory <- read_prepared_survival_data(include_endpoint_selected = TRUE)
g <- readRDS(file.path(out, "prepared_growth_data.rds"))
raw_s <- read_csv("05_data/standardized/apal_surv_ind.csv", show_col_types = FALSE)
raw_g <- read_csv("05_data/standardized/apal_growth_ind.csv", show_col_types = FALSE)
excluded <- read_csv("05_data/corrections/neely_species_exclusions.csv", show_col_types = FALSE)$coral_id
for (x in list(s, inventory, g, raw_s, raw_g)) {
  stopifnot(!any(x$study == "neely_et_al_2022" & x$coral_id %in% excluded))
}
# Biological origin cannot be inferred from physical fragmentation.
stopifnot(all(classify_population_type(c("NOAA_survey", "neely_et_al_2022"),
  c("Y", "Y")) == "Natural colony"),
  classify_population_type("mendoza_quiroz_et_al_2023", "N") ==
    "Restoration outplant (sexual recruit)")
natural <- inventory %>% filter(study %in% c("NOAA_survey", "neely_et_al_2022"))
stopifnot(!any(is_restoration_population(natural$population_type)))
selected <- inventory %>% filter(study == "NOAA_survey", fragment == "Y")
stopifnot(nrow(selected) > 0L, all(selected$survived == 1),
  !any(selected$survival_cohort_eligible),
  !any(s$study == "NOAA_survey" & s$fragment == "Y"))
stopifnot(all(is.finite(s$time_interval_yr)), all(s$time_interval_yr > 0),
  nrow(s) == sum(inventory$survival_cohort_eligible),
  nrow(inventory) == nrow(s) + sum(!inventory$survival_cohort_eligible))
cells <- readRDS(file.path(out, "prepared_survival_cells.rds"))
stopifnot(!any(cells$study == "NOAA_survey" & cells$fragment == "Y"))
for (x in list(raw_s, raw_g)) {
  x <- x %>% filter(study == "neely_et_al_2022")
  stopifnot(!anyDuplicated(x$source_interval_id))
}
dt <- raw_s %>% filter(study == "neely_et_al_2022", source_interval_id == "DT1-4:TP1-2")
stopifnot(nrow(dt) == 1L, as.Date(dt$survey_start_date) == as.Date("2011-02-23"),
  as.Date(dt$survey_end_date) == as.Date("2012-02-15"), dt$survived == 1L)
# First-sighting forms cannot become claims of nonfragment origin.
types <- read_csv("05_data/corrections/neely_colony_types.csv",
                   col_types = cols(.default = col_character()))
n <- raw_s %>% filter(study == "neely_et_al_2022")
stopifnot(all(n$fragment[n$neely_colony_type_first_sighting == "AF" &
  !is.na(n$neely_colony_type_first_sighting)] == "Y"),
  !any(n$fragment == "N"), all(is.finite(n$time_interval_yr)),
  !any(s$study == "neely_et_al_2022" & s$coral_id %in% c("WS1-6", "WS1-21")))
loose <- inventory %>% filter(study == "neely_et_al_2022", coral_id %in% c("WS1-6", "WS1-21"))
stopifnot(nrow(loose) == 2L, all(loose$survived == 0), !any(loose$survival_cohort_eligible))
age <- read_csv("05_data/standardized/apal_outplant_age.csv", show_col_types = FALSE)
stopifnot(all(c("is_outplant", "observation_context", "location") %in% names(age)),
  !anyDuplicated(age[c("study", "location", "coral_id", "survey_yr")]),
  !any(age$is_outplant[age$study %in% c("NOAA_survey", "neely_et_al_2022")]),
  all(is.na(age$years_since_outplant[age$observation_context != "post_outplant"])),
  all(age$is_restoration[age$study == "mendoza_quiroz_et_al_2023"]))
cat(sprintf("PASS - origin/eligibility: %d inventory intervals, %d annual-survival inputs, %d endpoint-selected fragments withheld; species exclusions and source date verified.\n",
  nrow(inventory), nrow(s), nrow(selected)))
