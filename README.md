# World Layoffs Data Cleaning Project (SQL)

This project focuses on cleaning and preparing real-world layoff data for further analysis. The dataset includes information about layoffs across different companies, industries, countries, and time periods.

## 📝 Project Description
This project was part of my SQL Data Cleaning practice. The objective was to clean, standardize, and prepare the layoff data for future analytical tasks like visualization and reporting.

I used **MySQL** to perform the entire data-cleaning process.

---

## 🛠️ Key Cleaning Steps Performed

1. **Removed Duplicate Records**  
   - Utilized `Common Table Expressions (CTEs)` and the `ROW_NUMBER()` window function to identify and delete duplicate rows based on multiple columns.

2. **Standardized Data Formatting**  
   - Trimmed extra spaces in textual data (e.g., company names and industries) using `TRIM()`.
   - Standardized inconsistent entries, e.g., converting variations of "Crypto" industries into a single category.
   - Removed trailing periods in country names and ensured uniform formatting.
   - Converted the `date` column from `TEXT` to proper `DATE` format using `STR_TO_DATE()` and altered the column data type.

3. **Populated Missing (NULL) or Blank Values**  
   - Replaced blank values in the `industry` column with `NULL` for consistency.
   - Populated missing `industry` data by joining tables on `company` and filling in values from existing non-null entries.

4. **Removed Unnecessary Rows and Columns**  
   - Deleted rows where both `total_laid_off` and `percentage_laid_off` were `NULL`, as they provided no value.
   - Dropped helper columns (like `row_num`) after cleaning was completed.

---

## 📂 Dataset Overview
| Column                | Description                            |
|-----------------------|----------------------------------------|
| company               | Name of the company                   |
| location              | City or region                        |
| industry              | Industry of the company               |
| total_laid_off        | Number of employees laid off          |
| percentage_laid_off   | Percentage of workforce laid off      |
| date                  | Date of the layoff                    |
| stage                 | Stage of the company (e.g., Series B) |
| country               | Country where the layoff occurred     |
| funds_raised_millions | Total funding raised by the company   |

---

## 💡 Tools Used
- **MySQL Workbench**
- **SQL**

---

## 🚀 What's Next
This cleaned dataset can now be used for:
- Descriptive analysis
- Visualizations in Power BI or Tableau
- Predictive modeling using Python

---

## 🔗 Connect With Me
If you have feedback or ideas for further exploration, feel free to reach out!  
- [LinkedIn](https://www.linkedin.com/in/ms-lisa-692aa81b2/)  
- [GitHub](https://github.com/Lisa-codes)

