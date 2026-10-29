#!/usr/bin/env python3
"""Block stale model numbers in the main manuscript, ESM, and README."""
import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "06_analysis/output"

def rows(name):
    with (OUT / name).open(newline="") as source:
        return list(csv.DictReader(source))

params = {r["parameter"]: float(r["value"]) for r in rows("population_parameters.csv")}
diag = {r["metric"]: float(r["value"]) for r in rows("transition_matrix_model_diagnostics.csv")}
heat = rows("heatwave_scenario_summary.csv")
base = next(r for r in heat if r["scenario"] == "baseline")
observed = sorted((r for r in heat if r["scenario"] == "observed_2023_florida"),
                  key=lambda r: int(r["return_interval_yr"]))
imputed = next(r for r in rows("transition_matrix_imputation_sensitivity.csv")
               if r["approach"] == "impute_missing_survival_classes")
loso = rows("sensitivity_lambda_loo.csv")
largest_exclusion = max(loso, key=lambda r: float(r["lambda"]))
smallest_exclusion = min(loso, key=lambda r: float(r["lambda"]))
study_labels = {"vardi_2011": "Vardi", "neely_et_al_2022": "Neely", "NOAA_survey": "NOAA"}
main = (ROOT / "07_reporting/manuscript/acropora_palmata_demography_manuscript_draft.md").read_text()
esm = (ROOT / "paper/submission/supplement/ESM_1.md").read_text()
readme = (ROOT / "README.md").read_text()
lam = f'{params["lambda"]:.3f}'
interval = f'{params["lambda_ci_lower"]:.3f}–{params["lambda_ci_upper"]:.3f}'
share = f'{100 * params["p_decline"]:.1f}%'
checks = [
    ("main lambda", f"deterministic lambda of {lam}" in main),
    ("main interval", f"bootstrap interval: {interval}" in main),
    ("bootstrap share", f"In {share} of hierarchical-bootstrap replicates" in main),
    ("SC5 cell elasticity", f'{100*diag["sc5_cell_elasticity"]:.1f}% of matrix-cell elasticity' in main),
    ("bootstrap imputation", f'{int(imputed["n_imputed_iterations"])} imputed survival' in main),
    ("study exclusion lower", f'{params["loso_lambda_min"]:.3f} (excluding {study_labels[smallest_exclusion["excluded_study"]]}' in main),
    ("study exclusion upper", f'{params["loso_lambda_max"]:.3f} (excluding {study_labels[largest_exclusion["excluded_study"]]}' in main),
    ("heatwave baseline", f'effective lambda was {float(base["effective_lambda"]):.3f}' in main and
                           f'effective lambda was {float(base["effective_lambda"]):.3f}' in esm),
    ("heatwave uncertainty", f'{100*float(base["p_quasi_extinction_50yr"]):.1f}% of the 500 primary simulations' in main and
                             f'{100*float(base["p_quasi_extinction_50yr"]):.1f}% of simulations' in esm),
    ("ESM deterministic lambda", f"deterministic lambda ({lam})" in esm),
    ("README model", f"{lam} (CI: {interval})" in readme and share in readme),
]
heat_values = [f'{float(r["effective_lambda"]):.3f}' for r in observed]
checks.append(("heatwave scenarios", f'{heat_values[0]}, {heat_values[1]}, {heat_values[2]}, and {heat_values[3]}' in main))
failed = [name for name, ok in checks if not ok]
if failed:
    raise SystemExit("FAIL - stale matrix reporting: " + ", ".join(failed))
print(f"PASS - {len(checks)} model-reporting checks match their source outputs.")
