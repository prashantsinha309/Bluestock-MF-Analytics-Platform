
from pathlib import Path
import pandas as pd

# Folder containing the 10 CSV datasets
RAW_FOLDER = Path("data") / "raw"

# Find all CSV files
csv_files = sorted(RAW_FOLDER.glob("*.csv"))

print(f"Total CSV files found: {len(csv_files)}")

if not csv_files:
    print("No CSV files found. Please check the data/raw folder.")
else:
    for file_path in csv_files:
        print("\n" + "=" * 70)
        print(f"FILE: {file_path.name}")
        print("=" * 70)

        try:
            df = pd.read_csv(file_path)

            print(f"\nShape (rows, columns): {df.shape}")
            print("\nColumn names:")
            print(df.columns.tolist())

            print("\nData types:")
            print(df.dtypes)

            print("\nMissing values per column:")
            print(df.isnull().sum())

            print(f"\nDuplicate rows: {df.duplicated().sum()}")

            print("\nFirst 2 rows:")
            print(df.head(2).to_string(index=False))

        except Exception as error:
            print(f"Could not read this file: {error}")


# step 2 - Fetch live mutual fund NAV from the API
