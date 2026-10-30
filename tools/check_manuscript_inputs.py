#!/usr/bin/env python3
"""Check manuscript inventory/cohort denominators against source audit tables."""
import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
def rows(relative):
    with (ROOT / relative).open(newline="") as f:
        return list(csv.DictReader(f))

main = (ROOT / "07_reporting/manuscript/acropora_palmata_demography_manuscript_draft.md").read_text()
esm = (ROOT / "paper/submission/supplement/ESM_1.md").read_text()
audit = rows("06_analysis/output/population_origin_sampling_audit.csv")
inventory = sum(int(r["n_intervals"]) for r in audit)
eligible = sum(int(r["n_intervals"]) for r in audit if r["survival_cohort_eligible"] == "TRUE")
endpoint = sum(int(r["n_intervals"]) for r in audit if r["survival_sampling_basis"] == "fragment_status_selected_at_live_endpoint")
unverified = inventory - eligible - endpoint
raw_survival = len(rows("05_data/standardized/apal_surv_ind.csv"))
raw_growth = len(rows("05_data/standardized/apal_growth_ind.csv"))
filtering = rows("06_analysis/output/data_filtering_audit.csv")
dedup = next(r for r in filtering if r["stage"] == "deduplication" and r["dataset"] == "growth")
growth = int(dedup["n_after"])
checks = {
    "standardized survival": f"contained {raw_survival:,} interval records" in main,
    "survival inventory": f"left {inventory:,} inventory records" in main,
    "primary survival eligibility": f"leaving {eligible:,} eligible intervals" in main,
    "selected endpoint exclusion": f"{endpoint:,} endpoint-selected natural-fragment records" in main,
    "unverified duration exclusion": f"{unverified:,} intervals without verified duration" in main,
    "standardized growth": f"contained {raw_growth:,} records" in main,
    "prepared growth": f"{growth:,} prepared records" in main,
    "source origin wording": "classified population origin independently of fragmentation" in main,
    "supplement cohort exclusion": f"{endpoint:,} NOAA" in esm and f"{unverified:,} Neely" in esm,
}
out = "06_analysis/output/"
survival = rows(out + "survival_thresholds.csv")[0]
diagnostic = rows(out + "survival_gam_diagnostics.csv")[0]
growth_fits = {r["response"]: r for r in rows(out + "growth_thresholds.csv")}
rgr = growth_fits["relative_growth_rate"]
positive = growth_fits["positive_growth_prob"]
shrink = next(r for r in rows(out + "shrinkage_retrogression_subset_summary.csv")
              if r["analysis_subset"] == "matrix_compatible")
classes = [r for r in rows(out + "shrinkage_retrogression_size_class_summary.csv")
           if r["analysis_subset"] == "matrix_compatible"]
class_counts = [int(r["n_records"]) for r in sorted(classes, key=lambda r: r["size_class"])]
assert sum(class_counts) == int(shrink["n_records"]), "size-class totals differ from matrix subset"
count_sentence = "SC1–SC5 starting counts were " + ", ".join(f"{n:,}" for n in class_counts[:-1]) + f", and {class_counts[-1]:,}."
screen = rows(out + "study_window_disturbance_summary_overall.csv")[0]
surv_p = float(rows(out + "disturbance_size_survival_model.csv")[0]["comparison_lrt_p"])
growth_p = float(rows(out + "disturbance_size_growth_model.csv")[0]["comparison_lrt_p"])
parameters = {r["parameter"]: float(r["value"]) for r in rows(out + "population_parameters.csv")}
checks.update({
    "survival GAM sample": f'{int(survival["n_observations"]):,} fitted natural-colony records' in main,
    "survival GAM deviance": f'{100*float(diagnostic["deviance_explained"]):.1f}% of deviance' in main,
    "survival nonlinearity": f'ΔAIC = {float(survival["gate_delta_aicc"]):.1f}' in main,
    "growth GAM sample": f'{int(rgr["n_observations"]):,} records from all colony sources' in main,
    "positive growth sample": f'*n* = {int(positive["n_observations"]):,}' in esm,
    "tissue loss denominator": f'{float(shrink["shrinkage_frequency_pct"]):.1f}% of {int(shrink["n_records"]):,}' in main,
    "tissue loss class denominators": count_sentence in esm,
    "screening overlap": f'{float(screen["pct_with_any_overlap"]):.1f}% matched at least one regional screening window' in main,
    "screening denominator": f'Of {int(screen["n_intervals"]):,} monitoring-window groups' in main,
    "survival screening test": f'global likelihood-ratio test, *p* = {surv_p:.3f}' in main,
    "growth screening test": f'positive growth (*p* = {growth_p:.3f})' in main,
    "replacement uncertainty": ("bootstrap interval included one" in main) ==
        (parameters["lambda_ci_lower"] <= 1 <= parameters["lambda_ci_upper"]),
    "constant observed proportion": "horizontal line marks the observed proportion" in esm,
})
failed = [name for name, ok in checks.items() if not ok]
if failed:
    raise SystemExit("FAIL - source/cohort reporting: " + ", ".join(failed))
print(f"PASS - {len(checks)} source/origin reporting checks: {inventory:,} inventory, {eligible:,} eligible survival, {growth:,} growth.")
