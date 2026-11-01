#!/usr/bin/env Rscript
################################################################################
# 25_SUPP_S5_S6_S7_THRESHOLDS_GROWTH.R
# Supplementary Figures S5, S6, S7 for Coral Reefs manuscript
################################################################################
#
# PURPOSE: Generate journal-ready supplementary figures showing threshold
#          detection results, AGR vs RGR comparison, and allometric analysis.
#
# FIGURES:
#   FigS5_threshold_analysis.png  -- 3-panel: survival gate, P(+growth), RGR derivative
#   FigS6_agr_vs_rgr.png         -- 4-panel: AGR vs size, RGR vs size, P(+growth), heteroscedasticity
#   FigS7_allometry.png           -- 4-panel: overall, by study, nat/rest, size ranges
#
# INPUTS (pre-computed by scripts 02, 03, 04):
#   - 06_analysis/output/survival_threshold_models.rds
#   - 06_analysis/output/growth_threshold_models.rds
#   - 06_analysis/output/growth_rate_analysis.rds
#   - 06_analysis/output/prepared_survival_data.rds
#   - 06_analysis/output/prepared_growth_data.rds
#   - 06_analysis/output/survival_thresholds.csv
#   - 06_analysis/output/growth_thresholds.csv
#   - 06_analysis/output/allometry_by_study.csv
#
# OUTPUTS:
#   - 06_analysis/figures/supplementary/FigS5_threshold_analysis.{png,pdf}
#   - 06_analysis/figures/supplementary/FigS6_agr_vs_rgr.{png,pdf}
#   - 06_analysis/figures/supplementary/FigS7_allometry.{png,pdf}
#
# JOURNAL: Coral Reefs (Springer)
#   Width: 174 mm (double-column), max height 234 mm, 300 DPI
#   Font: Helvetica/sans, 8-12 pt
#   Panel labels: lowercase a, b, c, d via plot_annotation(tag_levels = "a")
#
# Author: Detmer & Stier Lab
# Date: 2026-02
################################################################################

suppressPackageStartupMessages({
  library(tidyverse)
  library(patchwork)
  library(mgcv)
  library(scales)
})

# Source shared utilities
if (file.exists("utils/shared_utilities.R")) {
  source("utils/shared_utilities.R")
} else if (file.exists("06_analysis/scripts/utils/shared_utilities.R")) {
  source("06_analysis/scripts/utils/shared_utilities.R")
}

pal <- MANUSCRIPT_PALETTE
project_root <- get_project_root()
output_dir   <- file.path(project_root, "06_analysis/output")
fig_dir      <- file.path(project_root, "06_analysis/figures/supplementary")
dir.create(fig_dir, showWarnings = FALSE, recursive = TRUE)

cat("\n")
cat("================================================================\n")
cat("  SUPPLEMENTARY FIGURES S5, S6, S7\n")
cat("  Threshold Detection, AGR vs RGR, Allometry\n")
cat("================================================================\n\n")

# =============================================================================
# STUDY NAME FORMATTING
# =============================================================================

# Clean study names for publication display
format_study_name <- function(x) {
  x <- gsub("_", " ", x)
  x <- gsub("NOAA survey", "NOAA Survey", x)
  x <- gsub("USGS USVI exp", "USGS USVI", x)
  x <- gsub("fundemar fragments", "FUNDEMAR", x)
  x <- gsub("pausch et al 2018", "Pausch et al. 2018", x)
  x <- gsub("kuffner et al 2020", "Kuffner et al. 2020", x)
  x <- gsub("mendoza quiroz et al 2023", "Mendoza-Quiroz et al. 2023", x)
  x
}

# =============================================================================
# LOAD DATA
# =============================================================================

cat("Loading pre-computed results...\n")

# Survival threshold models (from script 02)
surv_models <- readRDS(file.path(output_dir, "survival_threshold_models.rds"))
surv_thresh <- read_csv(file.path(output_dir, "survival_thresholds.csv"),
                         show_col_types = FALSE)

# Growth threshold models (from script 03)
growth_models <- readRDS(file.path(output_dir, "growth_threshold_models.rds"))
growth_thresh <- read_csv(file.path(output_dir, "growth_thresholds.csv"),
                           show_col_types = FALSE)

# Growth rate analysis (from script 04)
growth_analysis <- readRDS(file.path(output_dir, "growth_rate_analysis.rds"))

# Raw data
surv_data    <- readRDS(file.path(output_dir, "prepared_survival_data.rds"))
growth_data  <- readRDS(file.path(output_dir, "prepared_growth_data.rds"))

# Allometry results
allometry_by_study <- read_csv(file.path(output_dir, "allometry_by_study.csv"),
                                show_col_types = FALSE)

cat("  All data loaded successfully.\n\n")

# =============================================================================
# DATA PREPARATION (shared across figures)
# =============================================================================

# Exact analysis rows, including script 02's subannual-interval exclusions.
surv_natural <- as_tibble(model.frame(surv_models$gam_model))
stopifnot(nrow(surv_natural) == nobs(surv_models$gam_model))

# Clean growth data (matching script 04 filtering)
growth_clean <- growth_data %>%
  mutate(
    growth_total_cm2_yr = growth_cm2_yr,
    growth_cm2_yr = coalesce(growth_live_cm2_yr, growth_cm2_yr)
  ) %>%
  filter(!is.na(size_cm2), size_cm2 > 0, !is.na(growth_cm2_yr))

if ("impossible_growth" %in% names(growth_clean)) {
  growth_clean <- growth_clean %>% filter(!impossible_growth)
}

growth_clean <- growth_clean %>%
  mutate(
    log_size = log(size_cm2),
    agr = growth_cm2_yr,
    rgr = growth_cm2_yr / size_cm2,
    pct_change = (growth_cm2_yr / size_cm2) * 100,
    positive_growth = as.integer(growth_cm2_yr > 0),
    population_type = if ("population_type" %in% names(.)) population_type else
      classify_population_type(study, fragment)
  )

# RGR outlier trim (matching script 04)
rgr_bounds <- quantile(growth_clean$rgr, c(0.005, 0.995), na.rm = TRUE)
growth_clean <- growth_clean %>%
  filter(rgr >= rgr_bounds[1] & rgr <= rgr_bounds[2])

# Exclude high-variance regions (Navassa)
if ("high_variance_region" %in% names(growth_clean)) {
  growth_clean <- growth_clean %>% filter(!high_variance_region)
} else if (sum(growth_clean$region == "Navassa", na.rm = TRUE) > 0) {
  growth_clean <- growth_clean %>% filter(region != "Navassa")
}

# Add final_size for allometry
growth_clean <- growth_clean %>%
  mutate(
    final_size = pmax(size_cm2 + growth_cm2_yr, 1),
    log_final_size = log(final_size)
  )

cat(sprintf("  Survival (natural): n = %d\n", nrow(surv_natural)))
cat(sprintf("  Growth (clean):     n = %d\n", nrow(growth_clean)))

# =============================================================================
# SHARED AXIS HELPERS
# =============================================================================

# Dual x-axis: log_size with cm2 secondary
# Use well-spaced breaks that do not overlap at 174mm / 3 panels
log_size_axis <- function(sec_breaks = c(10, 1000, 100000),
                          sec_labels = c("10", "1 000", "100 000")) {
  scale_x_continuous(
    name = expression(paste("Log colony size (log cm"^2, ")")),
    sec.axis = sec_axis(
      ~ exp(.),
      name = expression(paste("Colony size (cm"^2, ")")),
      breaks = sec_breaks,
      labels = sec_labels
    )
  )
}

# =============================================================================
# FIGURE S5: THRESHOLD ANALYSIS (3-panel)
# =============================================================================

cat("Generating Figure S5: Threshold analysis...\n")

# --- Panel (a): Survival gate / GAM smooth with CI ---
# Show the saved survival GAM and its computed nonlinearity-gate result.

surv_gate_delta <- surv_thresh$gate_delta_aicc[1]
surv_gate_passed <- surv_thresh$gate_passed[1]
# nonlinearity_gate() uses AICc only below n = 40 (and with MuMIn present).
# Keep the legacy CSV field name, but label the criterion actually computed.
surv_gate_criterion <- if (surv_thresh$n_observations[1] < 40 &&
                            requireNamespace("MuMIn", quietly = TRUE)) "AICc" else "AIC"

# Extract survival GAM model & prediction grid
surv_gam <- surv_models$gam_model
surv_pred <- surv_models$prediction_grid

# Build prediction with SE if not already present
if (!"gam_lower" %in% names(surv_pred)) {
  pred_se <- predict(surv_gam, newdata = surv_pred, type = "link", se.fit = TRUE)
  surv_pred$gam_lower <- plogis(pred_se$fit - 1.96 * pred_se$se.fit)
  surv_pred$gam_upper <- plogis(pred_se$fit + 1.96 * pred_se$se.fit)
  surv_pred$gam <- plogis(pred_se$fit)
}

fig_s5a <- ggplot() +
  stat_summary_bin(
    data = surv_natural,
    aes(x = log_size, y = survived),
    fun = mean,
    fun.min = function(x) max(0, mean(x) - 1.96 * sqrt(mean(x) * (1 - mean(x)) / max(length(x), 1))),
    fun.max = function(x) min(1, mean(x) + 1.96 * sqrt(mean(x) * (1 - mean(x)) / max(length(x), 1))),
    geom = "pointrange",
    bins = 20,
    alpha = 0.6,
    size = 0.3,
    color = pal$slate_mid
  ) +
  geom_ribbon(
    data = surv_pred,
    aes(x = log_size, ymin = gam_lower, ymax = gam_upper),
    alpha = 0.2, fill = pal$surv_mid
  ) +
  geom_line(
    data = surv_pred,
    aes(x = log_size, y = gam),
    color = pal$surv_mid, linewidth = 0.9
  ) +
  # GLM (linear) line for comparison
  geom_line(
    data = surv_pred,
    aes(x = log_size, y = glm),
    color = pal$slate_mid, linewidth = 0.6, linetype = "dotted"
  ) +
  # Annotate gate result
  log_size_axis() +
  scale_y_continuous(
    name = "Interval survival probability",
    limits = c(0, 1),
    breaks = seq(0, 1, 0.2)
  ) +
  theme_manuscript(base_size = 9) +
  theme(
    axis.title.x.top = element_text(size = 7),
    plot.margin = margin(5, 8, 5, 5, "mm")
  )

# --- Panel (b): P(positive growth); display a location only if the gate passes ---

# Extract P(+growth) results from growth models
pos_thresh_row <- growth_thresh %>% filter(response == "positive_growth_prob")
pos_gate_passed <- isTRUE(pos_thresh_row$gate_passed[1])
pos_thresh_cm2 <- if (pos_gate_passed) pos_thresh_row$recommended_threshold_cm2[1] else NA_real_
pos_thresh_log <- if (pos_gate_passed) pos_thresh_row$recommended_threshold_log[1] else NA_real_
pos_gate_criterion <- if (pos_thresh_row$n_observations[1] < 40 &&
                           requireNamespace("MuMIn", quietly = TRUE)) "AICc" else "AIC"

# Get GAM model for P(+growth) from growth_models
pos_gam <- growth_models$model_pos_growth
pos_fit_data <- as_tibble(model.frame(pos_gam))
stopifnot(nrow(pos_fit_data) == nobs(pos_gam))
pos_pred_grid <- growth_models$prediction_grid

# Build prediction with SE if needed
if (!"prob_pos_lower" %in% names(pos_pred_grid)) {
  pos_se <- predict(pos_gam, newdata = pos_pred_grid, type = "link", se.fit = TRUE)
  pos_pred_grid$prob_pos_lower <- plogis(pos_se$fit - 1.96 * pos_se$se.fit)
  pos_pred_grid$prob_pos_upper <- plogis(pos_se$fit + 1.96 * pos_se$se.fit)
  if (!"prob_positive" %in% names(pos_pred_grid)) {
    pos_pred_grid$prob_positive <- plogis(pos_se$fit)
  }
}

fig_s5b <- ggplot() +
  stat_summary_bin(
    data = pos_fit_data,
    aes(x = log_size, y = positive_growth),
    fun = mean,
    fun.min = function(x) max(0, mean(x) - 1.96 * sqrt(mean(x) * (1 - mean(x)) / max(length(x), 1))),
    fun.max = function(x) min(1, mean(x) + 1.96 * sqrt(mean(x) * (1 - mean(x)) / max(length(x), 1))),
    geom = "pointrange",
    bins = 20,
    alpha = 0.6,
    size = 0.3,
    color = pal$slate_mid
  ) +
  geom_ribbon(
    data = pos_pred_grid,
    aes(x = log_size,
        ymin = prob_pos_lower,
        ymax = prob_pos_upper),
    alpha = 0.2, fill = pal$grow_mid
  ) +
  geom_line(
    data = pos_pred_grid,
    aes(x = log_size, y = prob_positive),
    color = pal$grow_mid, linewidth = 0.9
  ) +
  {
    if (!is.na(pos_thresh_log))
      geom_vline(xintercept = pos_thresh_log, linetype = "dashed",
                 color = pal$accent, linewidth = 0.6)
  } +
  {
    if (!is.na(pos_thresh_cm2))
      NULL
  } +
  {
    if (!pos_gate_passed)
      NULL
  } +
  log_size_axis() +
  scale_y_continuous(
    name = "P(positive growth)",
    limits = c(0, 1),
    breaks = seq(0, 1, 0.2)
  ) +
  theme_manuscript(base_size = 9) +
  theme(
    axis.title.x.top = element_text(size = 7),
    plot.margin = margin(5, 8, 5, 5, "mm")
  )

# --- Panel (c): RGR second derivative profile ---

rgr_thresh_row <- growth_thresh %>% filter(response == "relative_growth_rate")
rgr_thresh_log <- rgr_thresh_row$recommended_threshold_log[1]
rgr_thresh_cm2 <- rgr_thresh_row$recommended_threshold_cm2[1]

# Extract derivative data from growth_models
rgr_deriv_df <- growth_models$rgr_results$derivatives

fig_s5c <- if (!is.null(rgr_deriv_df)) {
  ggplot(rgr_deriv_df, aes(x = x)) +
    geom_ribbon(aes(ymin = d2_lower, ymax = d2_upper),
                alpha = 0.2, fill = pal$grow_mid) +
    geom_line(aes(y = d2), color = pal$grow_mid, linewidth = 0.9) +
    geom_hline(yintercept = 0, linetype = "dotted", color = "grey60", linewidth = 0.4) +
    {
      if (!is.na(rgr_thresh_log))
        geom_vline(xintercept = rgr_thresh_log, linetype = "dashed",
                   color = pal$accent, linewidth = 0.6)
    } +
    {
      if (!is.na(rgr_thresh_cm2))
        NULL
    } +
    log_size_axis() +
    scale_y_continuous(name = expression("Second derivative s''(x)")) +
    theme_manuscript(base_size = 9) +
    theme(
      axis.title.x.top = element_text(size = 7),
      plot.margin = margin(5, 8, 5, 5, "mm")
    )
} else {
  ggplot() +
    theme_void()
}

# Combine S5 with lowercase panel labels
fig_s5 <- fig_s5a + fig_s5b + fig_s5c +
  plot_layout(ncol = 3, widths = c(1, 1, 1)) +
  plot_annotation(tag_levels = "a") &
  theme(plot.tag = element_text(size = 11, face = "bold", family = "sans"))

save_manuscript_fig(fig_s5, "FigS5_threshold_analysis",
                    width_mm = 174, height_mm = 80,
                    fig_dir = fig_dir)
cat("  Done: FigS5_threshold_analysis\n")

# =============================================================================
# FIGURE S6: AGR vs RGR COMPARISON (2x2)
# =============================================================================

cat("Generating Figure S6: AGR vs RGR comparison...\n")

# Retain the lower-k positive-growth diagnostic on its explicitly filtered
# display population. AGR/RGR use the maintained threshold models and exact
# fitted rows, rather than refitting different curves to this population.
pred_grid_s6 <- data.frame(
  log_size = seq(min(growth_clean$log_size), max(growth_clean$log_size),
                 length.out = 200)
)

# AGR GAM and exact observed response
agr_gam <- growth_models$model_gam_abs
agr_fit_data <- as_tibble(model.frame(agr_gam)) %>%
  transmute(log_size, agr = growth_cm2_yr)
stopifnot(nrow(agr_fit_data) == nobs(agr_gam))
pred_agr_s6 <- data.frame(log_size = seq(min(agr_fit_data$log_size),
                                        max(agr_fit_data$log_size), length.out = 200))
agr_se <- predict(agr_gam, newdata = pred_agr_s6, se.fit = TRUE)
pred_agr_s6$agr_fit      <- agr_se$fit
pred_agr_s6$agr_ci_lower <- agr_se$fit - 1.96 * agr_se$se.fit
pred_agr_s6$agr_ci_upper <- agr_se$fit + 1.96 * agr_se$se.fit
agr_r2 <- summary(agr_gam)$r.sq

# RGR GAM and exact observed response
rgr_gam <- growth_models$model_gam_rgr
rgr_fit_data <- as_tibble(model.frame(rgr_gam))
stopifnot(nrow(rgr_fit_data) == nobs(rgr_gam))
pred_rgr_s6 <- data.frame(log_size = seq(min(rgr_fit_data$log_size),
                                        max(rgr_fit_data$log_size), length.out = 200))
rgr_se <- predict(rgr_gam, newdata = pred_rgr_s6, se.fit = TRUE)
pred_rgr_s6$rgr_fit      <- rgr_se$fit
pred_rgr_s6$rgr_ci_lower <- rgr_se$fit - 1.96 * rgr_se$se.fit
pred_rgr_s6$rgr_ci_upper <- rgr_se$fit + 1.96 * rgr_se$se.fit
rgr_r2 <- summary(rgr_gam)$r.sq

# P(+growth) GAM
pos_gam_s6 <- gam(positive_growth ~ s(log_size, k = 3),
                   data = growth_clean, family = binomial, method = "REML")
pos_link_se <- predict(pos_gam_s6, newdata = pred_grid_s6, type = "link", se.fit = TRUE)
pred_grid_s6$pos_fit      <- plogis(pos_link_se$fit) * 100
pred_grid_s6$pos_ci_lower <- plogis(pos_link_se$fit - 1.96 * pos_link_se$se.fit) * 100
pred_grid_s6$pos_ci_upper <- plogis(pos_link_se$fit + 1.96 * pos_link_se$se.fit) * 100
pos_dev <- summary(pos_gam_s6)$dev.expl

# --- Panel (a): AGR vs size ---
fig_s6a <- ggplot() +
  geom_point(data = agr_fit_data, aes(x = log_size, y = agr),
             alpha = 0.08, size = 0.3, color = pal$slate_light) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60", linewidth = 0.3) +
  geom_ribbon(data = pred_agr_s6,
              aes(x = log_size, ymin = agr_ci_lower, ymax = agr_ci_upper),
              alpha = 0.2, fill = pal$surv_mid) +
  geom_line(data = pred_agr_s6,
            aes(x = log_size, y = agr_fit),
            color = pal$surv_mid, linewidth = 0.8) +
  log_size_axis() +
  coord_cartesian(ylim = quantile(agr_fit_data$agr, c(0.01, 0.99), na.rm = TRUE)) +
  scale_y_continuous(name = expression(paste("AGR (cm"^2, " yr"^-1, ")"))) +
  theme_manuscript(base_size = 9) +
  theme(
    axis.title.x.top = element_text(size = 7),
    plot.margin = margin(5, 6, 3, 5, "mm")
  )

# --- Panel (b): RGR vs size ---
fig_s6b <- ggplot() +
  geom_point(data = rgr_fit_data, aes(x = log_size, y = rgr),
             alpha = 0.08, size = 0.3, color = pal$slate_light) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60", linewidth = 0.3) +
  geom_ribbon(data = pred_rgr_s6,
              aes(x = log_size, ymin = rgr_ci_lower, ymax = rgr_ci_upper),
              alpha = 0.2, fill = pal$grow_mid) +
  geom_line(data = pred_rgr_s6,
            aes(x = log_size, y = rgr_fit),
            color = pal$grow_mid, linewidth = 0.8) +
  log_size_axis() +
  coord_cartesian(ylim = quantile(rgr_fit_data$rgr, c(0.01, 0.99), na.rm = TRUE)) +
  scale_y_continuous(name = expression(paste("RGR (yr"^-1, ")"))) +
  theme_manuscript(base_size = 9) +
  theme(
    axis.title.x.top = element_text(size = 7),
    plot.margin = margin(5, 6, 3, 5, "mm")
  )

# --- Panel (c): P(positive growth) vs size ---
fig_s6c <- ggplot() +
  stat_summary_bin(
    data = growth_clean,
    aes(x = log_size, y = positive_growth * 100),
    fun = mean,
    fun.min = function(x) {
      p <- mean(x) / 100
      max(0, (p - 1.96 * sqrt(p * (1 - p) / max(length(x), 1))) * 100)
    },
    fun.max = function(x) {
      p <- mean(x) / 100
      min(100, (p + 1.96 * sqrt(p * (1 - p) / max(length(x), 1))) * 100)
    },
    geom = "pointrange",
    bins = 20,
    alpha = 0.5,
    size = 0.25,
    color = pal$slate_mid
  ) +
  geom_ribbon(data = pred_grid_s6,
              aes(x = log_size, ymin = pos_ci_lower, ymax = pos_ci_upper),
              alpha = 0.2, fill = pal$grow_mid) +
  geom_line(data = pred_grid_s6,
            aes(x = log_size, y = pos_fit),
            color = pal$grow_mid, linewidth = 0.8) +
  log_size_axis() +
  scale_y_continuous(name = "P(positive growth) (%)",
                     limits = c(0, 100), breaks = seq(0, 100, 20)) +
  theme_manuscript(base_size = 9) +
  theme(
    axis.title.x.top = element_text(size = 7),
    plot.margin = margin(5, 6, 3, 5, "mm")
  )

# --- Panel (d): Residual heteroscedasticity comparison ---
# Show AGR vs RGR variance by size bin

# Compute binned variance
var_comparison <- growth_clean %>%
  mutate(size_bin_idx = ntile(log_size, 10)) %>%
  group_by(size_bin_idx) %>%
  summarise(
    log_size_mid = mean(log_size, na.rm = TRUE),
    agr_sd = sd(agr, na.rm = TRUE),
    rgr_sd = sd(rgr, na.rm = TRUE),
    n = n(),
    .groups = "drop"
  ) %>%
  filter(!is.na(log_size_mid))

# Pivot for plotting
var_long <- var_comparison %>%
  pivot_longer(
    cols = c(agr_sd, rgr_sd),
    names_to = "metric",
    values_to = "sd"
  ) %>%
  mutate(
    metric = recode(metric,
                    "agr_sd" = "AGR",
                    "rgr_sd" = "RGR")
  )

fig_s6d <- ggplot(var_long, aes(x = log_size_mid, y = sd, color = metric)) +
  geom_point(size = 1.5, alpha = 0.8) +
  geom_line(linewidth = 0.7, alpha = 0.8) +
  scale_color_manual(
    values = c("AGR" = pal$surv_mid, "RGR" = pal$grow_mid),
    labels = c(AGR = "AGR (cm² yr⁻¹)", RGR = "RGR (yr⁻¹)"),
    name = NULL
  ) +
  scale_x_continuous(
    name = expression(paste("Log colony size (log cm"^2, ")")),
    sec.axis = sec_axis(
      ~ exp(.),
      name = expression(paste("Colony size (cm"^2, ")")),
      breaks = c(100, 10000),
      labels = c("100", "10 000")
    )
  ) +
  scale_y_log10(
    name = "SD by size bin (log scale)",
    labels = label_comma()
  ) +
  theme_manuscript(base_size = 9) +
  theme(
    axis.title.x.top = element_text(size = 7),
    legend.position = c(0.15, 0.15),
    legend.background = element_rect(fill = "white", color = NA),
    legend.key.size = unit(3, "mm"),
    legend.text = element_text(size = 8),
    plot.margin = margin(5, 6, 3, 5, "mm")
  )

# Combine S6 (2x2) with lowercase panel labels
fig_s6 <- (fig_s6a + fig_s6b) / (fig_s6c + fig_s6d) +
  plot_annotation(tag_levels = "a") &
  theme(plot.tag = element_text(size = 11, face = "bold", family = "sans"))

save_manuscript_fig(fig_s6, "FigS6_agr_vs_rgr",
                    width_mm = 174, height_mm = 155,
                    fig_dir = fig_dir)
cat("  Done: FigS6_agr_vs_rgr\n")

# Submission supplement: six diagnostics in reading order, with equal-width
# panels. Keep the threshold-model positive-growth smooth (b); the lower-k
# smooth is a repository diagnostic, not a second reader-facing estimate.
# Old panel g (variance comparison) becomes f. No model is changed here.
fig_s1_variance <- fig_s6d +
  geom_text(
    data = var_long %>% group_by(metric) %>% slice_max(log_size_mid, n = 1),
    aes(y = sd * ifelse(metric == "AGR", 0.45, 1.8), label = metric),
    hjust = 1.15, vjust = 0.5,
    size = 2.6, family = "sans", show.legend = FALSE
  ) +
  theme(legend.position = "none")

fig_s1_growth_diagnostics <- (fig_s5a + fig_s5b) /
  (fig_s5c + fig_s6a) /
  (fig_s6b + fig_s1_variance) +
  plot_layout(heights = c(1, 1, 1)) +
  plot_annotation(tag_levels = "a") &
  theme(plot.tag = element_text(size = 11, face = "bold", family = "sans"))

save_manuscript_fig(fig_s1_growth_diagnostics, "FigS1_growth_diagnostics",
                    width_mm = 174, height_mm = 215,
                    fig_dir = fig_dir)

# Retain the smooth-complexity comparison for reproducibility without adding
# a new fit. This is not cited as a second positive-growth result in ESM_1.
exploratory_dir <- file.path(fig_dir, "exploratory")
dir.create(exploratory_dir, showWarnings = FALSE, recursive = TRUE)
for (extension in c("png", "pdf")) {
  export_args <- list(
    filename = file.path(exploratory_dir,
                         paste0("positive_growth_lower_k_diagnostic.", extension)),
    plot = fig_s6c, width = 84, height = 75, units = "mm", bg = "white"
  )
  if (extension == "png") export_args$dpi <- 600
  if (extension == "pdf") {
    export_args$device <- if (capabilities("cairo")) cairo_pdf else "pdf"
  }
  do.call(ggsave, export_args)
}

legend_dir <- file.path(fig_dir, "legends")
dir.create(legend_dir, showWarnings = FALSE, recursive = TRUE)
pos_legend <- if (pos_gate_passed && !is.na(pos_thresh_cm2)) {
  sprintf(paste0("(b) Probability of positive growth from the threshold-analysis GAM; ",
                 "the dashed line marks the selected model-defined location ",
                 "(%.0f cm²; n = %s fitted records), not an estimated optimum for planting size."),
          pos_thresh_cm2, comma(nobs(pos_gam)))
} else {
  sprintf(paste0("(b) Probability of positive growth from the threshold-analysis GAM ",
                 "(n = %s fitted records). The nonlinearity gate did not support a ",
                 "threshold (delta %s = %.2f); no threshold line is shown."),
          comma(nobs(pos_gam)), pos_gate_criterion, pos_thresh_row$gate_delta_aicc[1])
}
writeLines(c(
  "# Fig. S1. Size-dependent survival and growth diagnostics",
  "",
  sprintf(paste0("(a) Interval survival against log colony size (n = %s fitted records); ",
                 "the improvement of the GAM over the linear model (delta %s = %.2f; ",
                 "the pre-specified gate was 2)."), comma(nobs(surv_gam)),
          surv_gate_criterion, surv_gate_delta),
  pos_legend,
  sprintf(paste0("(c) Second derivative of the relative-growth-rate GAM; ",
                 "the dashed line marks the most negative second derivative (%.0f cm²)."),
          rgr_thresh_cm2),
  sprintf(paste0("(d, e) Absolute growth rate (AGR, cm² yr−1; n = %s) and relative growth ",
                 "rate (RGR, yr−1; n = %s) against colony size, from the stored threshold models."),
          comma(nobs(agr_gam)), comma(nobs(rgr_gam))),
  sprintf(paste0("(f) Standard deviation of AGR and RGR within size bins on a log scale ",
                 "(n = %s); lines join bin summaries and are directly labeled. AGR SD is in cm² yr−1 and RGR SD in yr−1; their magnitudes are not directly comparable."),
          comma(nrow(growth_clean))),
  "",
  paste0("Panels a and b show binned means and approximate binomial 95% intervals; ",
         "panels d and e show individual records. Observations in a, b, d and e ",
         "are exactly the rows used by their displayed models. Model ribbons show pointwise 95% ",
         "confidence intervals; panels d/e display the central 98% of observed response ",
         "values without excluding any additional rows from their fitted models. The ",
         "dotted line in a is the linear-model comparison. ",
         "Blue denotes survival/AGR and teal denotes positive growth/RGR. ",
         "Panel a uses binary interval fates for natural colonies and excludes subannual ",
         "intervals; remaining intervals are not uniformly annual. Growth models ",
         "pool colony sources under script 03's filtering rules. Panel f and the ",
         "exploratory lower-k display exclude the upper and lower 0.5% of RGR values ",
         "and high-variance Navassa records. Growth metrics prefer measured live-area ",
         "change, with total-area change retained only when live change is unavailable. ",
         "Size includes study-specific area indices/proxies; these are not uniformly ",
         "direct planar measurements. These diagnostic fits are not independent ",
         "replications of the size relationship."),
  "",
  paste0("The lower-dimension (k = 3) positive-growth smooth remains in ",
         "exploratory/positive_growth_lower_k_diagnostic.{png,pdf} and source FigS6. ",
         "It is fitted to the display-filtered growth data, whereas panel b uses ",
         "the stored threshold-model analysis population; it is therefore not a ",
         "controlled comparison of k alone. Its omission from the reader-facing ",
         "figure does not resolve model-shape sensitivity.")
), file.path(legend_dir, "FigS1_growth_diagnostics_legend.md"))
cat("  Done: FigS1_growth_diagnostics\n")

# =============================================================================
# FIGURE S7: ALLOMETRY (2x2)
# =============================================================================

cat("Generating Figure S7: Allometry...\n")

# --- Panel (a): Overall allometric scaling (log-log) ---
allometry_model <- lm(log_final_size ~ log_size, data = growth_clean)
allom_slope <- coef(allometry_model)[2]
allom_r2 <- summary(allometry_model)$r.squared
allom_intercept <- coef(allometry_model)[1]

pred_allom <- data.frame(
  log_size = seq(min(growth_clean$log_size),
                 max(growth_clean$log_size), length.out = 200)
)
pred_allom$fit <- predict(allometry_model, newdata = pred_allom)

fig_s7a <- ggplot(growth_clean, aes(x = log_size, y = log_final_size)) +
  geom_point(alpha = 0.06, size = 0.3, color = pal$slate_light) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed",
              color = "grey60", linewidth = 0.4) +
  geom_line(data = pred_allom, aes(x = log_size, y = fit),
            color = pal$surv_dark, linewidth = 0.8) +
  coord_equal(ratio = 1) +
  scale_x_continuous(name = expression(paste("Log initial size (log cm"^2, ")"))) +
  scale_y_continuous(name = expression(paste("Log final size (log cm"^2, ")"))) +
  theme_manuscript(base_size = 9) +
  theme(
    plot.margin = margin(5, 6, 3, 5, "mm")
  )

# --- Panel (b): Scaling by study ---
study_colors <- OKABE_ITO[seq_len(min(nrow(allometry_by_study), 7))]
names(study_colors) <- allometry_by_study$study[seq_len(min(nrow(allometry_by_study), 7))]

# Clean study names for display
allometry_display <- allometry_by_study %>%
  mutate(study_label = format_study_name(study))

# Plot allometric slopes with CIs as forest-style
fig_s7b <- ggplot(allometry_display,
                  aes(x = slope, y = reorder(study_label, slope))) +
  geom_vline(xintercept = 1, linetype = "dashed", color = "grey60", linewidth = 0.4) +
  geom_vline(xintercept = allom_slope, linetype = "solid",
             color = pal$surv_dark, linewidth = 0.5) +
  geom_linerange(
    aes(xmin = ci_lower, xmax = ci_upper),
    linewidth = 0.5, color = pal$slate_mid
  ) +
  geom_point(aes(size = n), color = pal$surv_dark, shape = 16) +
  scale_size_continuous(range = c(1.5, 4), name = "n",
                        guide = guide_legend(override.aes = list(alpha = 1))) +
  scale_x_continuous(name = "Allometric slope (log-log)") +
  scale_y_discrete(name = NULL) +
  theme_manuscript(base_size = 9) +
  theme(
    legend.position = c(0.88, 0.25),
    legend.background = element_rect(fill = "white", color = NA, linewidth = 0),
    legend.key.size = unit(3, "mm"),
    legend.text = element_text(size = 7),
    legend.title = element_text(size = 7),
    axis.text.y = element_text(size = 8),
    plot.margin = margin(5, 6, 3, 5, "mm")
  )

# --- Panel (c): Natural vs restored allometry ---
allometry_by_type <- growth_clean %>%
  group_by(population_type) %>%
  filter(n() >= 30) %>%
  nest() %>%
  mutate(result = map(data, function(d) {
    mod <- lm(log_final_size ~ log_size, data = d)
    pred_df <- data.frame(
      log_size = seq(min(d$log_size), max(d$log_size), length.out = 100)
    )
    pred_df$fit <- predict(mod, newdata = pred_df)
    list(
      slope = coef(mod)[2],
      intercept = coef(mod)[1],
      r_squared = summary(mod)$r.squared,
      n = nrow(d),
      predictions = pred_df
    )
  })) %>%
  select(-data)

# Extract predictions for overlay
type_preds <- allometry_by_type %>%
  mutate(preds = map(result, ~ .x$predictions)) %>%
  select(population_type, preds) %>%
  unnest(preds)

type_stats <- allometry_by_type %>%
  mutate(
    slope = map_dbl(result, ~ .x$slope),
    r2 = map_dbl(result, ~ .x$r_squared),
    n = map_int(result, ~ .x$n)
  ) %>%
  select(population_type, slope, r2, n)

fig_s7c <- ggplot() +
  geom_point(data = growth_clean,
             aes(x = log_size, y = log_final_size, color = population_type),
             alpha = 0.04, size = 0.3) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed",
              color = "grey60", linewidth = 0.4) +
  geom_line(data = type_preds,
            aes(x = log_size, y = fit, color = population_type),
            linewidth = 0.8) +
  scale_color_manual(
    values = c("Natural colony" = pal$natural,
               "Restoration fragment" = pal$restoration),
    labels = c("Natural colony" = "Natural",
               "Restoration fragment" = "Restoration"),
    name = NULL
  ) +
  coord_equal(ratio = 1) +
  scale_x_continuous(name = expression(paste("Log initial size (log cm"^2, ")"))) +
  scale_y_continuous(name = expression(paste("Log final size (log cm"^2, ")"))) +
  theme_manuscript(base_size = 9) +
  theme(
    legend.position = c(0.25, 0.88),
    legend.background = element_rect(fill = "white", color = NA),
    legend.key.size = unit(3, "mm"),
    legend.text = element_text(size = 8),
    plot.margin = margin(5, 6, 3, 5, "mm")
  )

# --- Panel (d): Size ranges by study ---
size_ranges <- growth_clean %>%
  group_by(study) %>%
  summarise(
    n = n(),
    min_size = min(size_cm2, na.rm = TRUE),
    max_size = max(size_cm2, na.rm = TRUE),
    median_size = median(size_cm2, na.rm = TRUE),
    q25 = quantile(size_cm2, 0.25, na.rm = TRUE),
    q75 = quantile(size_cm2, 0.75, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(study_label = format_study_name(study)) %>%
  arrange(median_size)

fig_s7d <- ggplot(size_ranges,
                  aes(y = reorder(study_label, median_size))) +
  geom_segment(aes(x = min_size, xend = max_size,
                   yend = reorder(study_label, median_size)),
               linewidth = 0.6, color = pal$slate_light) +
  geom_linerange(aes(xmin = q25, xmax = q75),
                 linewidth = 0.8, color = pal$slate_mid) +
  geom_point(aes(x = median_size, size = n),
             color = pal$surv_dark, shape = 16) +
  scale_x_log10(
    name = expression(paste("Colony size (cm"^2, ")")),
    breaks = c(1, 100, 10000),
    labels = c("1", "100", "10 000"),
    limits = c(1, 200000)
  ) +
  scale_y_discrete(name = NULL) +
  scale_size_continuous(range = c(1.5, 4), name = "n",
                        guide = guide_legend(override.aes = list(alpha = 1))) +
  theme_manuscript(base_size = 9) +
  theme(
    legend.position = c(0.88, 0.25),
    legend.background = element_rect(fill = "white", color = NA, linewidth = 0),
    legend.key.size = unit(3, "mm"),
    legend.text = element_text(size = 7),
    legend.title = element_text(size = 7),
    axis.text.y = element_text(size = 8),
    plot.margin = margin(5, 6, 3, 5, "mm")
  )

# Combine S7 (2x2) with lowercase panel labels
fig_s7 <- (fig_s7a + fig_s7b) / (fig_s7c + fig_s7d) +
  plot_annotation(tag_levels = "a") &
  theme(plot.tag = element_text(size = 11, face = "bold", family = "sans"))

save_manuscript_fig(fig_s7, "FigS7_allometry",
                    width_mm = 174, height_mm = 160,
                    fig_dir = fig_dir)
cat("  Done: FigS7_allometry\n")

# =============================================================================
# SUMMARY
# =============================================================================

cat("\n")
cat("================================================================\n")
cat("  FIGURE GENERATION COMPLETE\n")
cat("================================================================\n")
cat("  FigS5_threshold_analysis  -- 174 x 80 mm  (3-panel horizontal)\n")
cat("  FigS6_agr_vs_rgr          -- 174 x 155 mm (2x2 grid)\n")
cat("  FigS7_allometry            -- 174 x 160 mm (2x2 grid)\n")
cat("  All at 300 DPI, PNG + PDF\n")
cat("  Panel labels: lowercase a, b, c, d\n")
cat("================================================================\n\n")
