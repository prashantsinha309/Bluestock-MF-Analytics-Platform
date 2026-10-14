
from pathlib import Path
import pandas as pd

raw_folder = Path("data") / "raw"

fund_master = pd.read_csv(
    raw_folder / "1788499983024-b042c300-01_fund_master.csv"
)

nav_history = pd.read_csv(
    raw_folder / "1788499983331-4389156d-02_nav_history.csv"
)

fund_codes = set(fund_master["amfi_code"].astype(str))
nav_codes = set(nav_history["amfi_code"].astype(str))

matched_codes = fund_codes & nav_codes
missing_codes = fund_codes - nav_codes

print("FUND CODE VALIDATION REPORT")
print("=" * 40)
print("Fund master codes:", len(fund_codes))
print("NAV history codes:", len(nav_codes))
print("Codes found in both:", len(matched_codes))
print("Fund codes missing from NAV history:", len(missing_codes))

if missing_codes:
    print("\nMissing AMFI codes:")
    print(sorted(missing_codes))
else:
    print("\nAll fund master codes exist in NAV history.")
