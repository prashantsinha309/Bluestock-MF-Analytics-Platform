
from pathlib import Path
import pandas as pd
import requests

SCHEMES = {
    125497: "SBI_Small_Cap",
    120586: "ICICI_Prudential_Large_Cap",
    118632: "Nippon_India_Large_Cap",
}

OUTPUT_FOLDER = Path("data") / "raw"
OUTPUT_FOLDER.mkdir(parents=True, exist_ok=True)

for code, fund_name in SCHEMES.items():
    try:
        print(f"\nFetching {fund_name}...")

        response = requests.get(
            f"https://api.mfapi.in/mf/{code}",
            timeout=30
        )
        response.raise_for_status()
        result = response.json()

        if not result.get("data"):
            print("No NAV records returned.")
            continue

        actual_name = result.get("meta", {}).get(
            "scheme_name", "Unknown"
        )

        df = pd.DataFrame(result["data"])
        df["amfi_code"] = code
        df["nav"] = pd.to_numeric(df["nav"], errors="coerce")
        df["date"] = pd.to_datetime(
            df["date"], format="%d-%m-%Y", errors="coerce"
        )

        df = df.dropna(subset=["date", "nav"])
        df = df[["amfi_code", "date", "nav"]]

        output_file = OUTPUT_FOLDER / f"live_nav_{code}.csv"
        df.to_csv(output_file, index=False, date_format="%Y-%m-%d")

        print("Actual scheme:", actual_name)
        print("Records saved:", len(df))
        print("File:", output_file)

    except (requests.RequestException, ValueError, KeyError) as error:
        print(f"Error for {code}: {error}")

print("\nVerified NAV fetching completed.")
