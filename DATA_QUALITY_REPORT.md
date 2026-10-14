# Day 1 — Data Quality Report

## 1. CSV Dataset Inspection

- Total CSV datasets inspected: 10
- All 10 CSV files were successfully loaded using Pandas.
- Duplicate rows: 0 in all 10 original datasets.
- Missing values: 12 in `monthly_sip_inflows.csv`, all in the `yoy_growth_pct` column.
- Other inspected original datasets had no missing values.

## 2. Live NAV Data

Three mutual fund schemes were fetched using the MFAPI API.

| Fund | NAV Records |
|---|---:|
| Nippon India Large Cap | 3,391 |
| ICICI Prudential Large Cap | 3,391 |
| SBI Small Cap | 3,184 |
| **Total** | **9,966** |

Quality checks found no missing values, duplicate rows, invalid dates, or non-positive NAV values in these three selected files.

## 3. Fund Code Validation

- Unique AMFI codes in fund master: 40
- Unique AMFI codes in NAV history: 40
- Matching codes: 40
- Fund master codes missing from NAV history: 0

## 4. Initial Observations

- The original fund master contains 40 unique AMFI codes.
- The monthly SIP dataset contains 12 missing year-on-year growth values.
- The downloaded CSV datasets contain fewer rows than some counts specified in the project brief. These differences should be documented and verified against the supplied source files.
- Four additional NAV files from earlier API tests have been archived separately and excluded from the three-fund quality report.

## 5. Next Steps

- Build the database schema and load cleaned data.
- Validate dates, data types, and key constraints.
- Continue exploratory data analysis and calculate mutual fund performance and risk metrics.