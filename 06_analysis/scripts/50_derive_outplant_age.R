################################################################################
# 50_derive_outplant_age.R - Derive time-since-outplanting per colony
################################################################################
#
# PURPOSE:
#   Compute years_since_outplant per coral_id for restoration studies. Enables
#   the "outplant age decay" survival model (script 56) testing the Boisvert
#   et al. 2024 hypothesis that restoration outplants show temporal decay in
#   survival independent of size.
#
# HYPOTHESIS:
#   Restoration A. palmata outplants show temporal decay in survival
#   independent of size, consistent with Boisvert et al. 2024 (Coral Reefs)
#   showing A. cervicornis outplants rarely survive >2 years and sites
#   un-supplemented for ≥4 yr have near-zero coral cover.
#
# METHOD:
#   For each colony in a restoration study, compute:
#     years_since_outplant = survey_yr - min(survey_yr[coral_id])
#   where min(survey_yr) is assumed to be outplant year (first observation).
#   Caveats for studies where first-observation ≠ outplant date are flagged
#   in the output "derivation_note" column.
#
# INPUTS:
#   - 05_data/standardized/apal_surv_ind.csv
#
# OUTPUTS:
#   - 05_data/standardized/apal_outplant_age.csv
#       Columns: study, region, coral_id, survey_yr, years_since_outplant,
#                is_restoration, derivation_note
#
# CITATIONS:
#   Boisvert, K.A. et al. 2024. Restoration success in A. cervicornis limited
#     by poor long-term survival. Coral Reefs (notebook "Acropora Restoration
#     Success Limited by Poor Long-Term Survival").
#
# Author: Detmer & Stier Lab
# Date: 2026-04-18
################################################################################

source("06_analysis/scripts/utils/shared_utilities.R")

print_header("Script 50: Derive outplant age per colony")

# --- Load ---
surv_path <- "05_data/standardized/apal_surv_ind.csv"
surv <- read.csv(surv_path, stringsAsFactors = FALSE)
cat(sprintf("  Loaded %d survival observations from %d studies\n",
            nrow(surv), length(unique(surv$study))))

# --- Classify restoration vs natural ---
# Studies known to be restoration/outplant (from project documentation):
#   - pausch_et_al_2018 (CRF fragments)
#   - kuffner_et_al_2020 (USGS outplants in DRTO)
#   - USGS_USVI_exp (USGS experimental outplants)
#   - fundemar_fragments (FUNDEMAR nursery)
# Natural fragments are not outplants. Nursery-held restoration material also
# has no post-outplant age. Sexual propagation does not make a cohort natural.
surv$population_type <- classify_population_type(surv$study, surv$fragment)
surv$is_restoration <- is_restoration_population(surv$population_type)
surv$observation_context <- case_when(
  surv$study == "fundemar_fragments" ~ "nursery_held",
  surv$study == MENDOZA_QUIROZ_STUDY_ID & grepl("nursery", surv$location, ignore.case = TRUE) ~ "nursery_held",
  surv$study %in% c("pausch_et_al_2018", "kuffner_et_al_2020", "USGS_USVI_exp", MENDOZA_QUIROZ_STUDY_ID) ~ "post_outplant",
  surv$study %in% c("NOAA_survey", "neely_et_al_2022") ~ "natural_reef",
  TRUE ~ "unverified")
surv$is_outplant <- surv$observation_context == "post_outplant"
stopifnot(!any(surv$is_outplant & surv$study %in% c("NOAA_survey", "neely_et_al_2022", "fundemar_fragments")))

print_subheader("Restoration classification")
rest_tbl <- table(surv$study, surv$is_restoration)
print(rest_tbl)

# --- Compute years_since_outplant per coral_id ---
# For restoration studies only. For natural studies, report years_since_first_obs
# which is interpretable but not called "outplant age".
print_subheader("Computing years since first observation per coral_id")

surv_age <- surv %>%
  group_by(study, location, coral_id) %>%
  mutate(
    first_year = min(survey_yr, na.rm = TRUE),
    years_since_outplant = ifelse(is_outplant,
                                   survey_yr - first_year,
                                   NA_real_),
    years_since_first_obs = survey_yr - first_year
  ) %>%
  ungroup()

# --- Derivation note per study ---
surv_age <- surv_age %>%
  mutate(
    derivation_note = case_when(
      study == "pausch_et_al_2018" ~
        "Outplant date documented in Pausch 2018 methods; first-survey = outplant year",
      study == "kuffner_et_al_2020" ~
        "First-survey assumed = outplant year (Kuffner 2020 DRTO)",
      study == "USGS_USVI_exp" ~
        "USGS outplants, first-survey = outplant year",
      study == "fundemar_fragments" ~
        "Nursery-held fragments; no post-outplant age",
      observation_context == "nursery_held" ~ "Nursery-held sexual juveniles; no post-outplant age",
      is_outplant ~ "First observed reef year is an outplant-year proxy, not a documented planting date",
      TRUE ~ "Natural colony, years_since_first_obs tracks observation history"
    )
  )

# --- Summary ---
print_subheader("Summary by study")
summary_by_study <- surv_age %>%
  group_by(study, is_restoration) %>%
  summarise(
    n_colonies = n_distinct(coral_id),
    n_obs = n(),
    min_age = suppressWarnings(min(years_since_outplant, na.rm = TRUE)),
    max_age = suppressWarnings(max(years_since_outplant, na.rm = TRUE)),
    mean_age = round(mean(years_since_outplant, na.rm = TRUE), 2),
    .groups = "drop"
  )
print(as.data.frame(summary_by_study))

# --- Write output ---
output_cols <- c("study", "region", "location", "coral_id", "survey_yr",
                 "years_since_outplant", "years_since_first_obs",
                 "is_restoration", "is_outplant", "observation_context", "derivation_note")

# Annual age is one value per source colony/site/year. Joining repeated
# intervals on a nonunique annual key must not multiply survival observations.
surv_age <- surv_age %>% distinct(study, location, coral_id, survey_yr, .keep_all = TRUE)

out_path <- "05_data/standardized/apal_outplant_age.csv"
write.csv(surv_age[, output_cols], out_path, row.names = FALSE)

print_success(sprintf("Saved %s (%d rows)", out_path, nrow(surv_age)))
print_success(sprintf("Restoration colonies: %d; natural colonies: %d",
                      sum(surv_age$is_restoration[!duplicated(surv_age$coral_id)]),
                      sum(!surv_age$is_restoration[!duplicated(surv_age$coral_id)])))

cat("\nDone.\n")
