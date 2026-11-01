#!/usr/bin/env Rscript
################################################################################
# 00_standardize_neely.R
# Convert Neely et al. 2022 FKNMS data from wide to long format
################################################################################
#
# PURPOSE:
#   Reads the Neely lab APAL monitoring data (878 colonies, 7 timepoints,
#   Florida Keys 2010-2016) and converts it to the standardized format used
#   by our analysis pipeline. Appends rows to apal_surv_ind.csv and
#   apal_growth_ind.csv.
#
# INPUT:
#   05_data/original/Neely_et_al_2022_FKNMS_APAL.xlsx
#
# OUTPUT:
#   Modifies (appends to):
#     05_data/standardized/apal_surv_ind.csv
#     05_data/standardized/apal_growth_ind.csv
#
# DISTURBANCE HANDLING:
#   The source explanation identifies 2014 bleaching and site dependence,
#   not a colony-level diagnosed disease cause. All intervals are retained:
#     - TP4->TP5: "bleaching_2014_context"
#     - TP5->TP6: "bleaching_2014_aftermath_context"
#     - Other intervals: NA (no source flag, not proof of no exposure)
#   The contextual timeline and acute-event exclusion flags are separate.
#
# NOAA OVERLAP: None. Neely monitors Middle/Lower Keys + Dry Tortugas;
#   NOAA monitors Upper Keys. Sites are fully independent.
#
# Author: Detmer & Stier Lab
# Date: 2026-04-01
################################################################################

library(readxl)
library(dplyr)
library(tidyr)
library(readr)
library(lubridate)

cat("\n")
cat("╔═══════════════════════════════════════════════════════════════╗\n")
cat("║  00: STANDARDIZE NEELY ET AL. 2022 FKNMS DATA               ║\n")
cat("╚═══════════════════════════════════════════════════════════════╝\n\n")

# Detect project root
if (file.exists("05_data/standardized")) {
  project_root <- "."
} else if (file.exists("../../05_data/standardized")) {
  project_root <- "../.."
} else {
  stop("Cannot find project root.")
}

input_file <- file.path(project_root, "05_data/original/Neely_et_al_2022_FKNMS_APAL.xlsx")
surv_file <- file.path(project_root, "05_data/standardized/apal_surv_ind.csv")
growth_file <- file.path(project_root, "05_data/standardized/apal_growth_ind.csv")

if (!file.exists(input_file)) {
  stop("Neely data file not found: ", input_file)
}

# Check if Neely data already appended
existing_surv <- read_csv(surv_file, show_col_types = FALSE)
if ("neely_et_al_2022" %in% existing_surv$study) {
  cat("Neely data already present in apal_surv_ind.csv — removing old rows first.\n")
  existing_surv <- existing_surv %>% filter(study != "neely_et_al_2022")
}

existing_growth <- read_csv(growth_file, show_col_types = FALSE)
if ("neely_et_al_2022" %in% existing_growth$study) {
  cat("Neely data already present in apal_growth_ind.csv — removing old rows first.\n")
  existing_growth <- existing_growth %>% filter(study != "neely_et_al_2022")
}

# ==============================================================================
# SECTION 1: READ AND PARSE RAW DATA
# ==============================================================================

cat("SECTION 1: Reading raw data\n")
cat(paste(rep("-", 60), collapse = ""), "\n\n")

# Read Sheet 1 (colony data) — skip the merged header row
raw <- read_excel(input_file, sheet = "Sheet1", skip = 1)
cat(sprintf("  Raw data: %d colonies x %d columns\n", nrow(raw), ncol(raw)))

# Read Sheet 2 (site locations)
locations <- read_excel(input_file, sheet = "Sheet2") %>%
  filter(!is.na(Site)) %>%
  mutate(
    lat = as.numeric(gsub("^N", "", Latitude)),
    lon = -abs(as.numeric(gsub("^W", "", gsub(" .*$", "", Longitude))))
  )

# Map site codes to location info
site_map <- data.frame(
  site_prefix = c("MR", "BB", "SR", "LK", "WS", "RK", "SK", "DT"),
  location = c("Marker 3 Reef", "Ball Buoy Reef", "Sombrero Reef",
               "Looe Key", "West Sambo Key", "Rock Key", "Sand Key",
               "Palmata Patch"),
  loc_group = c("Biscayne NP", "Biscayne NP", "Middle Keys",
                "Lower Keys", "Lower Keys", "Lower Keys", "Lower Keys",
                "Dry Tortugas NP"),
  lat = c(25.37328, 25.31618, 24.62592, 24.54593, 24.47987, 24.45449,
          24.45244, 24.62098),
  lon = c(-80.16062, -80.18725, -81.11045, -81.40731, -81.71284, -81.85842,
          -81.87706, -82.86745),
  stringsAsFactors = FALSE
)

# ==============================================================================
# SECTION 2: PIVOT WIDE TO LONG
# ==============================================================================

cat("\nSECTION 2: Pivoting to long format\n")
cat(paste(rep("-", 60), collapse = ""), "\n\n")

# Rename columns for easier handling
colnames(raw) <- c("site", "coral_id",
                    "date_1", "lai_1", "date_2", "lai_2",
                    "date_3", "lai_3", "date_4", "lai_4",
                    "date_5", "lai_5", "date_6", "lai_6",
                    "date_7", "lai_7")

# Source corrections are overlays; the received workbook remains immutable.
# Keep durable colony/worksheet locators and stop on stale or ambiguous joins.
raw$source_row <- seq_len(nrow(raw)) + 2L
source_colonies <- raw %>% select(coral_id, original_source_row = source_row)
correction_dir <- file.path(project_root, "05_data/corrections")
exclusions <- read_csv(file.path(correction_dir, "neely_species_exclusions.csv"),
                       show_col_types = FALSE)
stopifnot(!anyDuplicated(exclusions$coral_id),
          all(exclusions$coral_id %in% raw$coral_id))
excluded <- raw %>% inner_join(exclusions, by = c("coral_id", "source_row"))
stopifnot(nrow(excluded) == nrow(exclusions))
write_csv(excluded %>% select(coral_id, source_row, species_code, reason, source),
          file.path(project_root, "06_analysis/output/neely_species_exclusion_audit.csv"))
raw <- raw %>% filter(!coral_id %in% exclusions$coral_id)
date_overrides <- read_csv(file.path(correction_dir, "neely_date_overrides.csv"),
  col_types = cols(coral_id = col_character(), timepoint = col_integer(),
                   source_row = col_integer(), date = col_date(), source = col_character()))
stopifnot(!anyDuplicated(date_overrides[c("coral_id", "timepoint")]))
for (i in seq_len(nrow(date_overrides))) {
  x <- date_overrides[i, ]
  j <- which(raw$coral_id == x$coral_id & raw$source_row == x$source_row)
  stopifnot(length(j) == 1L, x$timepoint %in% 1:7, !is.na(x$date))
  column <- paste0("date_", x$timepoint)
  stopifnot(is.na(raw[[column]][j]) || as.Date(raw[[column]][j]) == x$date)
  raw[[column]][j] <- as.POSIXct(x$date, tz = "UTC")
}
write_csv(date_overrides, file.path(project_root, "06_analysis/output/neely_date_correction_audit.csv"))

# Preserve known fate separately from measurement availability. Karen's literal
# "live" records are alive with unmeasured LAI, not missing survival or zero area.
for (tp in 1:7) {
  lai_col <- paste0("lai_", tp)
  value <- trimws(tolower(as.character(raw[[lai_col]])))
  numeric_lai <- suppressWarnings(as.numeric(value))
  unknown <- !is.na(value) & value != "" & is.na(numeric_lai) & value != "live"
  if (any(unknown)) stop("Unrecognized Neely LAI code at timepoint ", tp)
  raw[[paste0("alive_", tp)]] <- ifelse(value == "live", 1L,
    ifelse(is.finite(numeric_lai), as.integer(numeric_lai > 0), NA_integer_))
  raw[[lai_col]] <- numeric_lai
}

# Create long format: one row per colony per timepoint
long <- raw %>%
  pivot_longer(
    cols = matches("^(date|lai|alive)_"),
    names_to = c(".value", "timepoint"),
    names_pattern = "(date|lai|alive)_(\\d+)"
  ) %>%
  mutate(
    timepoint = as.integer(timepoint),
    survey_date = as.Date(date),
    survey_yr = year(survey_date)
  ) %>%
  filter(!is.na(alive)) %>%
  select(site, coral_id, source_row, timepoint, survey_date, survey_yr, lai, alive)

# Collector metadata describe first-sighting categories, not changing morphology.
# AF defines a known naturally attached-fragment cohort from first sighting.
# BR/EN/remnant do not prove nonfragment origin. All Neely colonies are wild.
types <- read_csv(file.path(correction_dir, "neely_colony_types.csv"),
                  col_types = cols(.default = col_character()))
stopifnot(!anyDuplicated(types$coral_id),
          all(types$classification_basis == "first_sighting"),
          all(types$colony_type %in% c("AF", "BR", "EN", "REMNANT", "LOOSE_FRAG", "NO_ACER")),
          all(types$status == "verified"),
          all(types$fragment == ifelse(types$colony_type %in% c("AF", "LOOSE_FRAG"), "Y", "U")))
type_audit <- full_join(source_colonies, types %>% rename(metadata_source_row = source_row),
                       by = "coral_id") %>% mutate(disposition = case_when(
  coral_id %in% exclusions$coral_id ~ "different_species_excluded",
  is.na(original_source_row) ~ "metadata_only_no_demographic_record_added",
  is.na(colony_type) ~ "demographic_ID_without_metadata_retained_unknown",
  TRUE ~ "matched_by_durable_colony_ID"))
write_csv(type_audit, file.path(project_root, "06_analysis/output/neely_colony_type_source_audit.csv"))
long <- long %>% left_join(types %>% select(coral_id,
                                           neely_colony_type_first_sighting = colony_type,
                                           source_fragment = fragment),
                           by = "coral_id") %>%
  mutate(fragment = coalesce(source_fragment, "U"))

stopifnot(!anyDuplicated(long[c("site", "coral_id", "timepoint")]))

cat(sprintf("  Long format: %d rows (colony x timepoint)\n", nrow(long)))
cat(sprintf("  Colonies: %d unique\n", n_distinct(long$coral_id)))
cat(sprintf("  Date range: %s to %s\n",
            min(long$survey_date, na.rm = TRUE),
            max(long$survey_date, na.rm = TRUE)))

# ==============================================================================
# SECTION 3: COMPUTE INTERVAL-LEVEL SURVIVAL AND GROWTH
# ==============================================================================

cat("\nSECTION 3: Computing survival and growth per interval\n")
cat(paste(rep("-", 60), collapse = ""), "\n\n")

# Self-join consecutive timepoints
intervals <- long %>%
  inner_join(
    long %>% mutate(timepoint = timepoint - 1L),
    by = c("site", "coral_id", "timepoint"),
    suffix = c("_start", "_end")
  ) %>%
  # Only keep colonies alive at start
  filter(alive_start == 1L) %>%
  mutate(
    survived = alive_end,
    delta_days = as.numeric(survey_date_end - survey_date_start),
    time_interval_yr = delta_days / 365.25,
    # Growth (for survivors only)
    growth_cm2_yr = ifelse(survived == 1 & is.finite(lai_start) & is.finite(lai_end) &
      is.finite(time_interval_yr) & time_interval_yr > 0,
      (lai_end - lai_start) / time_interval_yr, NA_real_),
    # Extract site prefix for location mapping
    site_prefix = gsub("\\d+$", "", site)
  )

if (any(!is.na(intervals$time_interval_yr) & intervals$time_interval_yr <= 0)) {
  stop("Non-positive Neely interval: check source dates; do not silently annualize.")
}

cat(sprintf("  Intervals computed: %d\n", nrow(intervals)))
cat(sprintf("  Survived: %d (%.1f%%)\n",
            sum(intervals$survived), mean(intervals$survived) * 100))

# Tag disturbance intervals
# TP4->TP5 (Fall 2013 -> Winter 2014-15): catastrophic mortality event
# TP5->TP6 (Winter 2014-15 -> Fall 2015): continued elevated mortality
intervals <- intervals %>%
  mutate(
    disturbance = case_when(
      timepoint == 4 ~ "bleaching_2014_context",
      timepoint == 5 ~ "bleaching_2014_aftermath_context",
      TRUE ~ NA_character_
    )
  )

cat("\n  Per-interval survival:\n")
intervals %>%
  group_by(timepoint) %>%
  summarise(
    n = n(),
    surv = mean(survived),
    interval_yr = round(median(time_interval_yr), 2),
    disturbance = first(disturbance),
    .groups = "drop"
  ) %>%
  mutate(surv_pct = sprintf("%.1f%%", surv * 100)) %>%
  print()

# ==============================================================================
# SECTION 4: FORMAT FOR STANDARDIZED SCHEMA
# ==============================================================================

cat("\nSECTION 4: Formatting to standardized schema\n")
cat(paste(rep("-", 60), collapse = ""), "\n\n")

# Join location info
intervals <- intervals %>%
  left_join(site_map, by = "site_prefix")

study_n <- n_distinct(intervals$coral_id)

# --- Survival records ---
neely_surv <- intervals %>%
  mutate(
    source_interval_id = paste(coral_id, paste0("TP", timepoint, "-", timepoint + 1L), sep = ":"),
    survey_start_date = as.character(survey_date_start),
    survey_end_date = as.character(survey_date_end),
    study = "neely_et_al_2022",
    region = "Florida Keys",
    plot = site,
    treatment_1 = NA_character_,
    treatment_2 = NA_character_,
    latitude = lat,
    longitude = lon,
    depth_m = NA_real_,
    data_type = "field",
    size_cm2 = lai_start,
    size_live_cm2 = lai_start,  # Source live-area index; not literal planar area.
    fragment = fragment_start,
    neely_colony_type_first_sighting = neely_colony_type_first_sighting_start,
    study_notes = "Neely FKNMS; LAI=((L+W+H)/3)^2*live_fraction (cm2 index), not measured planar area; live=alive with LAI missing; 0=dead",
    study_N = study_n,
    group_N = NA_integer_
  ) %>%
  # Compute group_N per plot per interval
  group_by(plot, timepoint) %>%
  mutate(group_N = n()) %>%
  ungroup() %>%
  select(
    study, region, location, plot, treatment_1, treatment_2,
    latitude, longitude, depth_m, survey_yr = survey_yr_start,
    data_type, coral_id, size_cm2, size_live_cm2, survived,
    fragment, neely_colony_type_first_sighting, time_interval_yr, disturbance, study_notes, study_N, group_N,
    source_interval_id, survey_start_date, survey_end_date
  )

cat(sprintf("  Survival records: %d\n", nrow(neely_surv)))

# --- Growth records (survivors only, positive interval) ---
neely_growth <- intervals %>%
  filter(survived == 1, time_interval_yr > 0,
         is.finite(lai_start), is.finite(lai_end), is.finite(growth_cm2_yr)) %>%
  mutate(
    source_interval_id = paste(coral_id, paste0("TP", timepoint, "-", timepoint + 1L), sep = ":"),
    survey_start_date = as.character(survey_date_start),
    survey_end_date = as.character(survey_date_end),
    study = "neely_et_al_2022",
    region = "Florida Keys",
    plot = site,
    treatment_1 = NA_character_,
    treatment_2 = NA_character_,
    latitude = lat,
    longitude = lon,
    depth_m = NA_real_,
    data_type = "field",
    size_cm2 = lai_start,
    size_live_cm2 = lai_start,
    growth_live_cm2_yr = growth_cm2_yr,
    fragment = fragment_start,
    neely_colony_type_first_sighting = neely_colony_type_first_sighting_start,
    study_notes = "Neely FKNMS; LAI=((L+W+H)/3)^2*live_fraction (cm2 index); paired measured indices only; live code has no growth value",
    study_N = study_n,
    group_N = NA_integer_
  ) %>%
  group_by(plot, timepoint) %>%
  mutate(group_N = n()) %>%
  ungroup() %>%
  select(
    study, region, location, plot, treatment_1, treatment_2,
    latitude, longitude, depth_m, survey_yr = survey_yr_start,
    data_type, coral_id, size_cm2, size_live_cm2,
    growth_cm2_yr, growth_live_cm2_yr,
    fragment, neely_colony_type_first_sighting, time_interval_yr, disturbance, study_notes, study_N, group_N,
    source_interval_id, survey_start_date, survey_end_date
  )

cat(sprintf("  Growth records: %d\n", nrow(neely_growth)))

# ==============================================================================
# SECTION 5: APPEND TO STANDARDIZED FILES
# ==============================================================================

cat("\nSECTION 5: Appending to standardized data files\n")
cat(paste(rep("-", 60), collapse = ""), "\n\n")

# Other studies were retained above; write only after validation succeeds.
dir.create(file.path(project_root, "06_analysis/output"), recursive = TRUE, showWarnings = FALSE)
interval_audit <- intervals %>% transmute(
  study = "neely_et_al_2022", site, coral_id,
  source_file = basename(input_file), source_row = source_row_start,
  start_timepoint = timepoint, end_timepoint = timepoint + 1L,
  start_date = survey_date_start, end_date = survey_date_end,
  initial_lai = lai_start, endpoint_lai = lai_end, survived,
  endpoint_known_live_missing_lai = survived == 1 & is.na(lai_end),
  initial_lai_missing = is.na(lai_start),
  time_interval_yr,
  missing_start_date = is.na(survey_date_start),
  missing_end_date = is.na(survey_date_end))
write_csv(interval_audit, file.path(project_root, "06_analysis/output/neely_interval_source_audit.csv"))

cat(sprintf("  Existing survival: %d rows from %d studies\n",
            nrow(existing_surv), n_distinct(existing_surv$study)))
cat(sprintf("  Existing growth: %d rows from %d studies\n",
            nrow(existing_growth), n_distinct(existing_growth$study)))

# Ensure column alignment
for (column in c("source_interval_id", "survey_start_date", "survey_end_date", "neely_colony_type_first_sighting")) {
  if (!column %in% names(existing_surv)) existing_surv[[column]] <- NA_character_
  if (!column %in% names(existing_growth)) existing_growth[[column]] <- NA_character_
  existing_surv[[column]] <- as.character(existing_surv[[column]])
  existing_growth[[column]] <- as.character(existing_growth[[column]])
}
surv_cols <- names(existing_surv)
growth_cols <- names(existing_growth)

# Add missing columns as NA if needed, drop the row index column
if ("...1" %in% surv_cols) {
  existing_surv <- existing_surv %>% select(-...1)
  surv_cols <- names(existing_surv)
}
if ("...1" %in% growth_cols) {
  existing_growth <- existing_growth %>% select(-...1)
  growth_cols <- names(existing_growth)
}

# Align Neely columns
for (col in surv_cols) {
  if (!col %in% names(neely_surv)) neely_surv[[col]] <- NA
}
neely_surv <- neely_surv[, surv_cols]

for (col in growth_cols) {
  if (!col %in% names(neely_growth)) neely_growth[[col]] <- NA
}
neely_growth <- neely_growth[, growth_cols]

# Append and sort for deterministic row order
combined_surv <- bind_rows(existing_surv, neely_surv) %>%
  arrange(study, coral_id, survey_yr)
combined_growth <- bind_rows(existing_growth, neely_growth) %>%
  arrange(study, coral_id, survey_yr)

# Write back
write_csv(combined_surv, surv_file)
write_csv(combined_growth, growth_file)

cat(sprintf("  Updated survival: %d rows from %d studies (+%d Neely)\n",
            nrow(combined_surv), n_distinct(combined_surv$study), nrow(neely_surv)))
cat(sprintf("  Updated growth: %d rows from %d studies (+%d Neely)\n",
            nrow(combined_growth), n_distinct(combined_growth$study), nrow(neely_growth)))

# ==============================================================================
# SECTION 6: SUMMARY STATISTICS
# ==============================================================================

cat("\nSECTION 6: Neely data summary\n")
cat(paste(rep("-", 60), collapse = ""), "\n\n")

cat(sprintf("  Study: neely_et_al_2022\n"))
cat(sprintf("  Region: Florida Keys (Middle Keys, Lower Keys, Dry Tortugas, Biscayne NP)\n"))
cat(sprintf("  Colonies: %d unique\n", n_distinct(neely_surv$coral_id)))
cat(sprintf("  Survival records: %d\n", nrow(neely_surv)))
cat(sprintf("  Growth records: %d\n", nrow(neely_growth)))
cat(sprintf("  Overall survival: %.1f%%\n", mean(neely_surv$survived) * 100))
cat(sprintf("  Date range: 2010-11 to 2016-09\n"))
cat(sprintf("  Size range: %.0f - %.0f cm2\n",
            min(neely_surv$size_cm2), max(neely_surv$size_cm2)))

cat("\n  Disturbance-stratified survival:\n")
neely_surv %>%
  mutate(period = ifelse(is.na(disturbance), "Non-disturbance", disturbance)) %>%
  group_by(period) %>%
  summarise(n = n(), surv = round(mean(survived) * 100, 1), .groups = "drop") %>%
  print()

cat("\n  Per-site survival:\n")
neely_surv %>%
  group_by(location) %>%
  summarise(n = n(), surv = round(mean(survived) * 100, 1), .groups = "drop") %>%
  arrange(surv) %>%
  print()

cat("\n╔═══════════════════════════════════════════════════════════════╗\n")
cat("║  NEELY DATA STANDARDIZATION COMPLETE                         ║\n")
cat("╚═══════════════════════════════════════════════════════════════╝\n\n")
