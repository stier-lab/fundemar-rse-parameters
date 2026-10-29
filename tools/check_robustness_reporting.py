#!/usr/bin/env python3
"""Check every new sensitivity-table row and load-bearing main-text result."""
import csv
from decimal import Decimal, ROUND_HALF_UP
from pathlib import Path

root = Path(__file__).resolve().parents[1]
out = root / "06_analysis/output"
esm = (root / "paper/submission/supplement/ESM_1.md").read_text()
main = (root / "07_reporting/manuscript/acropora_palmata_demography_manuscript_draft.md").read_text()
def rows(name):
    with (out / name).open() as f:
        return list(csv.DictReader(f))
def fmt(x, places=3, percent=False):
    value = Decimal(str(x)) * (100 if percent else 1)
    return str(value.quantize(Decimal(10) ** -places, rounding=ROUND_HALF_UP))
checks = []
labels = {
    "primary_independent_point_impute": "Primary independent, point imputation",
    "primary_independent_discard": "Primary independent, discard incomplete",
    "unstratified_independent_point_impute": "Independent sensitivity, point imputation",
    "unstratified_independent_donor_impute": "Independent sensitivity, distribution imputation",
    "stratified_independent_point_impute": "Fixed study mix, independent",
    "stratified_coordinated_point_impute": "Fixed study mix, coordinated",
}
summary = {r["approach"]: r for r in rows("matrix_resampling_summary.csv")}
for key, label in labels.items():
    r = summary[key]
    expected = f'| {label} | {int(r["n"]):,} | {r["n_imputed"]} | {fmt(r["ci_lower"])}–{fmt(r["ci_upper"])} | {fmt(r["fraction_below_one"], 1, True)} |'
    checks.append((label, expected in esm))
heat = rows("heatwave_matrix_robustness_summary.csv")
for initial in ("original", "recruit_heavy", "adult_heavy", "stable"):
    for method in ("lambda_only", "full_matrix"):
        b = next(r for r in heat if r["scenario"] == "baseline" and r["initial"] == initial and r["method"] == method)
        h = next(r for r in heat if r["scenario"] == "observed_2023_florida" and r["return_interval_yr"] == "50" and r["initial"] == initial and r["method"] == method)
        label = {"recruit_heavy": "Small-colony-heavy", "adult_heavy": "Large-colony-heavy"}.get(
            initial, initial.replace("_", "-").capitalize())
        ml = "Lambda-only" if method == "lambda_only" else "Full matrix"
        expected = f'| {label} | {ml} | {fmt(b["effective_lambda"])} | {fmt(b["p_below_10pct_year50"], 1, True)} | {fmt(h["p_below_10pct_year50"], 2, True)} |'
        checks.append((initial + method, expected in esm))
vardi = {r["scenario"]: r for r in rows("vardi_component_sensitivity.csv")}
for key, prefix in (("remove_vardi_survival_only", "survival data alone lowered lambda to"),
                    ("remove_vardi_fragmentation_only", "fragmentation estimates alone lowered it to")):
    checks.append((key, f'{prefix} {fmt(vardi[key]["lambda"])}' in main))
co = summary["stratified_coordinated_point_impute"]
checks.append(("coordinated share", f'{fmt(co["fraction_below_one"],1,True)}% of lambda estimates were below one' in main))
checks.append(("coordinated interval", f'95% interval: {fmt(co["ci_lower"])}–{fmt(co["ci_upper"])}' in main))
elasticity = next(r for r in rows("elasticity_bootstrap_ci.csv") if r["element"] == "SC5_stasis")
checks.append(("SC5 elasticity interval", f'95% bootstrap interval: {fmt(elasticity["ci_lower"],1,True)}–{fmt(elasticity["ci_upper"],1,True)}%' in main))
checks.append(("ESM tables dense", all(f"**Table S{i}." in esm for i in range(1,5))))
failures = [label for label, ok in checks if not ok]
if failures:
    raise SystemExit("FAIL - robustness reporting: " + ", ".join(failures))
print(f"PASS - {len(checks)} sensitivity-reporting checks.")
