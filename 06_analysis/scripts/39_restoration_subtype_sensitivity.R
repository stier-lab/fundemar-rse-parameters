#!/usr/bin/env Rscript
################################################################################
# 39_RESTORATION_SUBTYPE_SENSITIVITY.R
# Restoration subtype decomposition for Acropora palmata demography
################################################################################
#
# PURPOSE:
#   Replace the broad "restoration fragment" bucket with a reproducible subtype
#   mapping and subtype-level sensitivity summaries.
#
# INPUTS:
#   - 06_analysis/output/prepared_survival_data.rds (individual survival data)
#   - 06_analysis/output/prepared_growth_data.rds (individual growth data)
#
# OUTPUTS:
#   - 05_data/standardized/restoration_subtype_mapping.csv
#   - 06_analysis/output/restoration_subtype_study_summary.csv
#   - 06_analysis/output/restoration_subtype_survival_summary.csv
#   - 06_analysis/output/restoration_subtype_growth_summary.csv
#   - 06_analysis/output/restoration_subtype_sensitivity.csv
#   - 06_analysis/figures/supplementary/restoration_subtype_sensitivity.{png,pdf}
#
# Author: Codex
# Date: 2026-04-03
################################################################################

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
  library(patchwork)
  library(scales)
  library(tidyr)
})

if (file.exists("utils/shared_utilities.R")) {
  source("utils/shared_utilities.R")
} else if (file.exists("06_analysis/scripts/utils/shared_utilities.R")) {
  source("06_analysis/scripts/utils/shared_utilities.R")
}

project_root <- if (file.exists("05_data/standardized")) {
  "."
} else if (file.exists("../../05_data/standardized")) {
  "../.."
} else {
  stop("Cannot find project root. Run from project directory or 06_analysis/scripts/")
}

output_dir <- file.path(project_root, "06_analysis/output")
fig_dir <- file.path(project_root, "06_analysis/figures/supplementary")
std_dir <- file.path(project_root, "05_data/standardized")
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(fig_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(std_dir, showWarnings = FALSE, recursive = TRUE)

cat("\n")
cat("================================================================\n")
cat("  RESTORATION SUBTYPE SENSITIVITY\n")
cat("================================================================\n\n")

build_restoration_subtype_map <- function() {
  tibble::tribble(
    ~study, ~restoration_subtype, ~subtype_label, ~rule, ~evidence, ~confidence,
    "NOAA_survey", "natural_fragment", "Naturally occurring fragments",
    "NOAA survey records with fragment == 'Y' (current Colony.Type AF/SF); not restoration outplants",
    "Source integration assigns fragment status at interval end, so observed survival is conditioned on an AF/SF endpoint and is not prospective fragment-cohort survival.",
    "medium",

    "pausch_et_al_2018", "nursery_outplant", "Nursery outplants",
    "Nursery-cultured fragments outplanted to reef habitat",
    "Outplanted nursery-cultured fragments; size x genet and habitat x genet experiments.",
    "high",

    "USGS_USVI_exp", "outplanted_colony", "Outplanted colonies (source unspecified)",
    "Tagged outplanted colonies tracked in the USGS USVI experiment",
    "Tagged outplanted colonies; source material not described as nursery fragments in the metadata.",
    "medium",

    "kuffner_et_al_2020", "nursery_outplant_recemented", "Nursery outplants, re-cemented",
    "Nursery-raised fragments outplanted after fragmentation and re-cementation",
    "Nursery-raised fragments outplanted spring 2018; survival after fragmentation and re-cementation.",
    "high",

    "fundemar_fragments", "nursery_fragment", "Nursery-held fragments",
    "Nursery fragments on PVC tables in a restoration nursery",
    "Nursery fragments maintained on PVC tables; extraction_details.md and source integration identify nursery observations, not reef outplants.",
    "high",

    "mendoza_quiroz_et_al_2023", "sexual_recruit_outplant", "Sexually propagated outplants",
    "Sexually propagated reef cohorts; Puerto Morelos Nursery rows are assigned separately to sexual_recruit_nursery",
    "Mendoza-Quiroz et al. (2023) source workbook and location fields distinguish Puerto Morelos Nursery from Cuevones and Picudas reef cohorts; not asexual fragments.",
    "high"
  ) %>%
    arrange(match(study, c(
      "NOAA_survey",
      "pausch_et_al_2018",
      "USGS_USVI_exp",
      "kuffner_et_al_2020",
      "fundemar_fragments",
      "mendoza_quiroz_et_al_2023"
    )))
}

restore_mapping <- build_restoration_subtype_map()
write_csv(restore_mapping, file.path(std_dir, "restoration_subtype_mapping.csv"))

assign_restoration_subtype <- function(df, map_tbl) {
  df %>%
    left_join(map_tbl, by = "study") %>%
    mutate(
      # Source metadata distinguish nursery-held sexual juveniles from reef
      # outplants. Location is retained even in legacy prepared files whose
      # factor conversion lost data_type == 'nursery'.
      restoration_subtype = if_else(
        study == "mendoza_quiroz_et_al_2023" &
          grepl("nursery", location, ignore.case = TRUE),
        "sexual_recruit_nursery", restoration_subtype
      ),
      subtype_label = if_else(restoration_subtype == "sexual_recruit_nursery",
                              "Sexually propagated nursery juveniles", subtype_label),
      restoration_subtype = coalesce(restoration_subtype, "unknown"),
      subtype_label = coalesce(subtype_label, "Unknown"),
      rule = coalesce(rule, "Unmapped study"),
      evidence = coalesce(evidence, "No subtype mapping available"),
      confidence = coalesce(confidence, "low"),
      observation_context = case_when(
        restoration_subtype == "natural_fragment" ~ "naturally_occurring_fragment",
        restoration_subtype %in% c("nursery_fragment", "sexual_recruit_nursery") ~ "nursery_held",
        restoration_subtype %in% c("nursery_outplant", "nursery_outplant_recemented", "outplanted_colony", "sexual_recruit_outplant") ~ "post_outplant",
        TRUE ~ "unknown"
      )
    )
}

safe_weighted_mean <- function(x, w) {
  keep <- !is.na(x) & !is.na(w)
  if (!any(keep)) return(NA_real_)
  stats::weighted.mean(x[keep], w[keep])
}

bootstrap_weighted_mean <- function(df, value_col, weight_col = "n", B = 1000, seed = 39) {
  set.seed(seed)
  if (nrow(df) == 0) {
    return(tibble::tibble(mean = NA_real_, ci_lower = NA_real_, ci_upper = NA_real_))
  }
  vals <- df[[value_col]]
  w <- df[[weight_col]]
  if (nrow(df) == 1) {
    est <- safe_weighted_mean(vals, w)
    return(tibble::tibble(mean = est, ci_lower = NA_real_, ci_upper = NA_real_))
  }
  boot <- replicate(B, {
    idx <- sample(seq_len(nrow(df)), replace = TRUE)
    safe_weighted_mean(vals[idx], w[idx])
  })
  est <- safe_weighted_mean(vals, w)
  tibble::tibble(
    mean = est,
    ci_lower = stats::quantile(boot, 0.025, na.rm = TRUE, names = FALSE),
    ci_upper = stats::quantile(boot, 0.975, na.rm = TRUE, names = FALSE)
  )
}

load_survival_data <- function() {
  readRDS(file.path(output_dir, "prepared_survival_data.rds"))
}

load_growth_data <- function() {
  readRDS(file.path(output_dir, "prepared_growth_data.rds"))
}

surv_data <- load_survival_data()
growth_raw <- load_growth_data()
# Match the manuscript's measured live-area convention; no total-area fallback.
growth_data <- prepare_live_area_growth(growth_raw)

surv_rest <- surv_data %>%
  filter(fragment == "Y" | is_restoration_population(population_type) | study %in% restore_mapping$study) %>%
  # A study-level map must not turn NOAA's intact natural colonies into
  # naturally occurring fragments merely because NOAA is a mapped study.
  filter(study != "NOAA_survey" | fragment == "Y") %>%
  assign_restoration_subtype(restore_mapping)

growth_population_restoration <- if ("population_type" %in% names(growth_data)) {
  is_restoration_population(growth_data$population_type)
} else {
  rep(FALSE, nrow(growth_data))
}
growth_rest <- growth_data %>%
  filter(
    fragment == "Y" | study %in% restore_mapping$study |
      growth_population_restoration
  ) %>%
  filter(study != "NOAA_survey" | fragment == "Y") %>%
  assign_restoration_subtype(restore_mapping)

unknown_survival <- sum(surv_rest$restoration_subtype == "unknown", na.rm = TRUE)
unknown_growth <- sum(growth_rest$restoration_subtype == "unknown", na.rm = TRUE)

if (unknown_survival > 0 || unknown_growth > 0) {
  stop(sprintf("Unmapped restoration rows detected (survival=%d, growth=%d)",
               unknown_survival, unknown_growth))
}

if (any(surv_rest$study == "NOAA_survey" & surv_rest$fragment != "Y")) {
  stop("Natural NOAA colonies must not enter the natural-fragment subtype.")
}
known_mendoza_locations <- c("Puerto Morelos Nursery", "Cuevones Reef", "Picudas Reef")
if (any(surv_rest$study == "mendoza_quiroz_et_al_2023" &
        !surv_rest$location %in% known_mendoza_locations)) {
  stop("A Mendoza-Quiroz cohort has an unverified nursery/reef context.")
}

surv_study_summary <- surv_rest %>%
  group_by(restoration_subtype, subtype_label, study, region) %>%
  summarise(
    n = n(),
    mean_survival = mean(surv_annualized, na.rm = TRUE),
    mean_size_cm2 = mean(size_live_cm2, na.rm = TRUE),
    baseline_excluded = sum(exclude_from_baseline, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(restoration_subtype, study, region)

growth_study_summary <- growth_rest %>%
  group_by(restoration_subtype, subtype_label, study, region) %>%
  summarise(
    n = n(),
    mean_growth_cm2_yr = mean(growth_metric, na.rm = TRUE),
    mean_rgr = mean(rgr, na.rm = TRUE),
    pct_positive = mean(growth_metric > 0, na.rm = TRUE) * 100,
    mean_size_cm2 = mean(size_live_cm2, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(restoration_subtype, study, region)

surv_summary <- surv_study_summary %>%
  group_by(restoration_subtype, subtype_label) %>%
  group_modify(~{
    boot <- bootstrap_weighted_mean(.x, "mean_survival", "n")
    tibble::tibble(
      n_records = sum(.x$n),
      n_studies = n_distinct(.x$study),
      n_regions = n_distinct(.x$region),
      n_study_region_summaries = nrow(.x),
      weighted_survival = boot$mean,
      ci_lower = boot$ci_lower,
      ci_upper = boot$ci_upper,
      mean_of_study_means = mean(.x$mean_survival, na.rm = TRUE),
      median_of_study_means = median(.x$mean_survival, na.rm = TRUE),
      weighted_mean_size_cm2 = safe_weighted_mean(.x$mean_size_cm2, .x$n),
      baseline_excluded = sum(.x$baseline_excluded, na.rm = TRUE),
      interval_scope = if_else(nrow(.x) > 1,
        "legacy_descriptive_resampling_of_study_region_summaries_not_between_program_uncertainty",
        "not_estimable_from_one_study_region_summary"),
      displayed_interval = FALSE,
      cohort_survival_estimable = .y$restoration_subtype != "natural_fragment",
      survival_scope = if_else(.y$restoration_subtype == "natural_fragment",
        "endpoint_defined_fragment_observations_not_prospective_cohort_survival",
        "descriptive_mean_of_observed_interval_fates")
    )
  }) %>%
  ungroup() %>%
  arrange(desc(n_records))

growth_summary <- growth_study_summary %>%
  group_by(restoration_subtype, subtype_label) %>%
  summarise(
    n_records = sum(n),
    n_studies = n_distinct(study),
    n_regions = n_distinct(region),
    weighted_mean_growth_cm2_yr = safe_weighted_mean(mean_growth_cm2_yr, n),
    weighted_mean_rgr = safe_weighted_mean(mean_rgr, n),
    weighted_pct_positive = safe_weighted_mean(pct_positive, n),
    mean_of_study_means = mean(mean_growth_cm2_yr, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(n_records))

write_csv(surv_study_summary, file.path(output_dir, "restoration_subtype_study_summary.csv"))
write_csv(surv_summary, file.path(output_dir, "restoration_subtype_survival_summary.csv"))
write_csv(growth_summary, file.path(output_dir, "restoration_subtype_growth_summary.csv"))
write_csv(growth_study_summary, file.path(output_dir, "restoration_subtype_growth_study_summary.csv"))

# Record-level context counts preserve the provenance of nursery/reef splits.
assignment_audit <- bind_rows(
  surv_rest %>% mutate(outcome = "survival"),
  growth_rest %>% mutate(outcome = "measured_live_area_growth")
) %>%
  count(outcome, study, location, data_type, fragment, restoration_subtype,
        subtype_label, observation_context, name = "n_records") %>%
  mutate(source_context_basis = case_when(
    study == "NOAA_survey" ~ "APAL_data_integration.rmd: current Colony.Type AF/SF at endpoint",
    study == "fundemar_fragments" ~ "extraction_details.md Study5; APAL_data_integration.rmd FUNDEMAR nursery/PVC tables",
    study == "mendoza_quiroz_et_al_2023" ~ "extraction_details.md Study5b; source integration nursery/Cuevones/Picudas location",
    TRUE ~ "study-specific subtype mapping rules and extraction_details.md"
  ))
write_csv(assignment_audit, file.path(output_dir, "restoration_subtype_assignment_audit.csv"))

scenario_summary <- function(df, scenario_name) {
  study_level <- df %>%
    group_by(study, restoration_subtype, subtype_label) %>%
    summarise(
      n = n(),
      surv = mean(surv_annualized, na.rm = TRUE),
      .groups = "drop"
    )

  tibble::tibble(
    scenario = scenario_name,
    n_records = nrow(df),
    n_studies = n_distinct(df$study),
    n_natural_fragments = sum(df$observation_context == "naturally_occurring_fragment"),
    n_nursery_held = sum(df$observation_context == "nursery_held"),
    n_post_outplant = sum(df$observation_context == "post_outplant"),
    mean_survival = safe_weighted_mean(study_level$surv, study_level$n),
    cohort_survival_estimable = !any(df$observation_context == "naturally_occurring_fragment"),
    comparison_scope = if_else(any(df$observation_context == "naturally_occurring_fragment"),
      "legacy_inventory_summary_includes_live_endpoint_selected_fragments_not_practice_comparison",
      "descriptive_observational_survival_not_treatment_efficacy")
  )
}

surv_sensitivity <- bind_rows(
  # Preserve registry keys while explicit context counts prevent a legacy
  # 'restoration' label from silently being interpreted as post-outplant.
  scenario_summary(surv_rest, "All subtype-coded records"),
  scenario_summary(filter(surv_rest, restoration_subtype != "natural_fragment"), "Exclude natural fragments"),
  scenario_summary(filter(surv_rest, restoration_subtype != "natural_fragment"), "All restoration subtypes"),
  scenario_summary(filter(surv_rest, observation_context == "post_outplant"), "Post-outplant records only (excludes natural fragments and nursery-held)"),
  scenario_summary(filter(surv_rest, observation_context == "post_outplant" & restoration_subtype != "sexual_recruit_outplant"), "Asexual post-outplant records only"),
  scenario_summary(filter(surv_rest, restoration_subtype %in% c("nursery_outplant", "nursery_outplant_recemented")), "Nursery outplants only"),
  scenario_summary(filter(surv_rest, observation_context == "nursery_held"), "Nursery-held records only"),
  scenario_summary(filter(surv_rest, restoration_subtype == "outplanted_colony"), "Outplanted colonies only")
)

write_csv(surv_sensitivity, file.path(output_dir, "restoration_subtype_sensitivity.csv"))

# Shared factor ordering: descending n_records so largest bucket sits at top
subtype_order <- surv_summary %>% arrange(n_records) %>% pull(subtype_label)

plot_survival <- surv_summary %>%
  filter(cohort_survival_estimable) %>%
  mutate(subtype_label = factor(subtype_label, levels = subtype_order))

plot_growth <- growth_summary %>%
  mutate(subtype_label = factor(subtype_label, levels = subtype_order))

surv_points <- surv_study_summary %>%
  filter(restoration_subtype != "natural_fragment") %>%
  mutate(subtype_label = factor(subtype_label, levels = subtype_order))

growth_points <- growth_study_summary %>%
  mutate(subtype_label = factor(subtype_label, levels = subtype_order))

no_growth <- surv_summary %>%
  filter(!restoration_subtype %in% growth_summary$restoration_subtype) %>%
  mutate(subtype_label = factor(subtype_label, levels = subtype_order))

no_survival_estimate <- surv_summary %>%
  filter(!cohort_survival_estimable) %>%
  mutate(subtype_label = factor(subtype_label, levels = subtype_order))

# Unified size scale breaks so the two panels can share a single legend.
size_breaks <- c(20, 50, 200, 500)
size_limits <- c(
  min(c(surv_points$n, growth_points$n), na.rm = TRUE),
  max(c(surv_points$n, growth_points$n), na.rm = TRUE)
)

p_surv <- ggplot() +
  geom_text(
    data = no_survival_estimate,
    aes(x = 0.03, y = subtype_label,
        label = sprintf("Not estimable: live-endpoint selection\n(n = %d observations)", n_records)),
    hjust = 0, color = "grey45", size = 2.7,
    family = "Arial", fontface = "italic"
  ) +
  geom_point(
    data = plot_survival,
    aes(x = weighted_survival, y = subtype_label),
    shape = 18, size = 3.2, color = "#1F4E79",
    position = position_nudge(y = 0.24)
  ) +
  geom_point(
    data = surv_points,
    aes(x = mean_survival, y = subtype_label, size = n),
    shape = 21,
    fill = "white",
    color = "grey25",
    stroke = 0.6,
    alpha = 0.9,
    position = position_jitter(height = 0.04, width = 0, seed = 39)
  ) +
  scale_size_continuous(
    name = "Study–region records",
    range = c(1.2, 4.5),
    breaks = size_breaks,
    limits = size_limits
  ) +
  scale_y_discrete(limits = subtype_order, drop = FALSE,
                   labels = function(x) stringr::str_wrap(x, width = 25)) +
  scale_x_continuous(
    labels = scales::percent_format(accuracy = 1),
    limits = c(0, 1),
    breaks = seq(0, 1, 0.25),
    expand = expansion(mult = c(0.02, 0.02))
  ) +
  labs(x = "Observed interval survival", y = NULL, tag = "a") +
  theme_manuscript() +
  theme(
    legend.position = "bottom",
    plot.margin = margin(4, 6, 2, 2, "mm")
  )

p_growth <- ggplot() +
  geom_point(
    data = plot_growth,
    aes(x = weighted_mean_rgr, y = subtype_label),
    shape = 18, size = 3.2, color = "#2C7FB8",
    position = position_nudge(y = 0.24)
  ) +
  geom_point(
    data = growth_points,
    aes(x = mean_rgr, y = subtype_label, size = n),
    shape = 21,
    fill = "white",
    color = "grey25",
    stroke = 0.6,
    alpha = 0.9,
    position = position_jitter(height = 0.04, width = 0, seed = 39)
  ) +
  geom_text(
    data = no_growth,
    aes(x = 0.1, y = subtype_label),
    label = "No measured live-area data", hjust = 0,
    color = "grey45", size = 2.7, family = "Arial", fontface = "italic"
  ) +
  scale_size_continuous(
    name = "Study–region records",
    range = c(1.2, 4.5),
    breaks = size_breaks,
    limits = size_limits
  ) +
  scale_y_discrete(limits = subtype_order, drop = FALSE,
                   labels = function(x) stringr::str_wrap(x, width = 25)) +
  scale_x_continuous(
    limits = c(0, max(c(growth_points$mean_rgr, plot_growth$weighted_mean_rgr), na.rm = TRUE) * 1.1),
    expand = expansion(mult = c(0.02, 0.02))
  ) +
  labs(
    x = expression("Mean relative live-area growth (yr"^-1*")"),
    y = NULL,
    tag = "b"
  ) +
  theme_manuscript() +
  theme(
    legend.position = "bottom",
    plot.margin = margin(2, 6, 4, 2, "mm")
  )

p <- p_surv / p_growth +
  plot_layout(guides = "collect", heights = c(1, 1)) &
  theme(legend.position = "bottom")

save_manuscript_fig(
  p,
  "FigS19_restoration_subtype_sensitivity",
  width_mm = 174,
  height_mm = 190,
  fig_dir = fig_dir
)

legend_dir <- file.path(fig_dir, "legends")
dir.create(legend_dir, showWarnings = FALSE, recursive = TRUE)
writeLines(c(
  "# Fig. S5 (repository asset FigS19): population-source descriptions",
  "",
  "(a) Observed interval survival and (b) relative live-area growth rate (yr⁻¹). Open circles are study–region summaries, with point area scaled to record counts; filled diamonds, offset above each row for visibility, are record-weighted subtype means. Survival percentages average binary colony-interval fates. The legacy per-record power transformation leaves 0/1 fates unchanged and does not annualize a cohort survival proportion. Survey durations differ among records, so these percentages are not comparable annual survival rates. Empty growth rows are labeled when no measured live-area data are available. Both panels are descriptive and show no inferential intervals. Legacy resampling intervals are retained in the survival-summary CSV only and do not estimate between-program uncertainty.",
  sprintf("Naturally occurring fragments are only NOAA observations explicitly coded fragment = Y, not intact NOAA colonies. In the source integration this designation uses interval-end Colony.Type AF/SF; all such observations therefore have a live endpoint. Their survival estimate is withheld as not estimable from these endpoint-selected records; the %s observations remain in the inventory and growth summaries. FUNDEMAR fragments were nursery-held on PVC tables, not reef outplants. Pausch records are nursery outplants; Kuffner records are nursery outplants after fragmentation and re-cementation. The origin of USGS outplanted colonies is unspecified. Mendoza-Quiroz sexual cohorts are split between Puerto Morelos Nursery and Cuevones/Picudas reef outplants; they are not asexual fragments.",
          comma(sum(no_survival_estimate$n_records))),
  sprintf("The subtype inventory contains %s survival records from %d studies; descriptive survival estimates use %s records after withholding the endpoint-selected natural fragments. Live-area growth includes %s records from %d studies. Growth requires positive initial live area and observed live endpoints, available annual live-area change, and positive interval duration; this script makes no total-area substitution. Kuffner and Mendoza-Quiroz growth records lack the required live-area change field and do not enter panel b. The source integration treats surviving USGS colonies as having 100%% live cover based on the photographs.",
          comma(nrow(surv_rest)), n_distinct(surv_rest$study),
          comma(sum(plot_survival$n_records)),
          comma(nrow(growth_rest)), n_distinct(growth_rest$study)),
  "Subtype, study, site, handling, and sample size are not independently balanced; these summaries do not estimate treatment effects or rank restoration methods."
), file.path(legend_dir, "FigS19_restoration_subtype_sensitivity_legend.md"))

cat("\nSubtype mapping written to:\n")
cat(sprintf("  - %s\n", file.path(std_dir, "restoration_subtype_mapping.csv")))
cat("\nSurvival summary:\n")
print(surv_summary)
cat("\nGrowth summary:\n")
print(growth_summary)
cat("\nSensitivity table:\n")
print(surv_sensitivity)

cat("\nSaved outputs:\n")
cat("  - restoration_subtype_mapping.csv\n")
cat("  - restoration_subtype_study_summary.csv\n")
cat("  - restoration_subtype_survival_summary.csv\n")
cat("  - restoration_subtype_growth_summary.csv\n")
cat("  - restoration_subtype_sensitivity.csv\n")
cat("  - FigS19_restoration_subtype_sensitivity.png/pdf\n")
