#!/usr/bin/env Rscript
# Read-only checks of the Neely source repair and retained non-Neely inputs.
suppressPackageStartupMessages({library(dplyr); library(readr)})
out <- "06_analysis/output"
before <- "temp/karen_integration_2026-10-21/before"
for (name in c("apal_surv_ind.csv", "apal_growth_ind.csv")) {
  old <- read_csv(file.path(before, "05_data/standardized", name), show_col_types = FALSE)
  new <- read_csv(file.path("05_data/standardized", name), show_col_types = FALSE)
  cols <- intersect(names(old), names(new))
  cols <- setdiff(cols, "...1")
  x <- old %>% filter(study != "neely_et_al_2022") %>% select(all_of(cols))
  y <- new %>% filter(study != "neely_et_al_2022") %>% select(all_of(cols))
  # Input rows may be deterministically sorted by the standardizer.
  stopifnot(nrow(x) == nrow(y), nrow(anti_join(x, y, by = cols)) == 0L,
            nrow(anti_join(y, x, by = cols)) == 0L)
  cat(name, ": non-Neely rows unchanged (", nrow(x), ")\n", sep = "")
}
s <- readRDS(file.path(out, "prepared_survival_data.rds"))
g <- readRDS(file.path(out, "prepared_growth_data.rds"))
a <- read_csv(file.path(out, "neely_interval_source_audit.csv"), show_col_types = FALSE)
n <- s %>% filter(study == "neely_et_al_2022")
stopifnot(!anyDuplicated(n$source_interval_id),
          all(n$size_cm2 > 0), all(n$survived %in% 0:1))
missing <- n %>% filter(is.na(time_interval_yr) | time_interval_yr <= 0) %>%
  left_join(a %>% mutate(source_interval_id = paste(coral_id,
    paste0("TP", start_timepoint, "-", end_timepoint), sep = ":")) %>%
    select(source_interval_id, source_row, start_timepoint, end_timepoint,
      missing_start_date, missing_end_date), by = "source_interval_id")
xlcol <- function(tp) LETTERS[3L + 2L * (tp - 1L)]
missing <- missing %>% mutate(
  source_sheet = "Sheet1",
  start_date_cell = paste0(xlcol(start_timepoint), source_row),
  end_date_cell = paste0(xlcol(end_timepoint), source_row),
  disposition = "Known fate retained; no defensible annualization without source date")
raw <- readxl::read_excel("05_data/original/Neely_et_al_2022_FKNMS_APAL.xlsx",
                         sheet = "Sheet1", skip = 1)
for (i in seq_len(nrow(missing))) {
  r <- missing$source_row[i] - 2L
  if (missing$missing_start_date[i])
    stopifnot(is.na(raw[[3L + 2L * (missing$start_timepoint[i] - 1L)]][r]))
  if (missing$missing_end_date[i])
    stopifnot(is.na(raw[[3L + 2L * (missing$end_timepoint[i] - 1L)]][r]))
}
write_csv(missing %>% select(coral_id, location, source_interval_id, source_row,
  source_sheet, start_date_cell, end_date_cell, survey_start_date, survey_end_date,
  missing_start_date, missing_end_date, survived, disposition),
  file.path(out, "neely_missing_duration_audit.csv"))
summary <- tibble(
  metric = c("prepared_survival", "prepared_growth", "prepared_neely_survival",
    "prepared_neely_growth", "neely_missing_duration", "known_live_missing_endpoint_lai",
    "known_live_missing_initial_lai", "neely_distinct_2012_intervals"),
  value = c(nrow(s), nrow(g), nrow(n), sum(g$study == "neely_et_al_2022"),
    nrow(missing), sum(a$endpoint_known_live_missing_lai), sum(a$initial_lai_missing),
    sum(n$survey_yr == 2012, na.rm = TRUE)))
write_csv(summary, file.path(out, "karen_source_revision_summary.csv"))
print(summary)
cat("Missing date fields in original worksheet require no inferred date repair.\n")
