
from pathlib import Path
import pandas as pd

raw_folder = Path("data") / "raw"
nav_files = sorted(raw_folder.glob("live_nav_*.csv"))

print("NAV DATA QUALITY REPORT")
print("=" * 50)

for file_path in nav_files:
    df = pd.read_csv(file_path)

    print(f"\nFile: {file_path.name}")
    print(f"Total rows: {len(df)}")
    print(f"Missing values: {df.isnull().sum().sum()}")
    print(f"Duplicate rows: {df.duplicated().sum()}")
    print(f"Invalid NAV values: {(df['nav'] <= 0).sum()}")
    print(f"Invalid dates: {pd.to_datetime(df['date'], errors='coerce').isna().sum()}")

    print("Date range:",
          df["date"].min(), "to", df["date"].max())

    print("NAV range:",
          df["nav"].min(), "to", df["nav"].max())

print("\nQuality check completed.")
