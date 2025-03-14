#data cleaning project

#process
#1 Remove Duplicate Data
#2 Standardize the data
#3 Populate null or blank values where possible
#4 Remove unnecessary rows or columns
DROP TABLE layoffs_staging2;

SELECT *
FROM layoffs
;

CREATE TABLE layoffs_staging
LIKE layoffs
;

SELECT *
FROM layoffs_staging;

SELECT*
FROM layoffs_staging 
WHERE total_laid_off IS NULL
OR percentage_laid_off IS NULL;

INSERT layoffs_staging
SELECT *
FROM layoffs;

#note we use back ticks below on date since it is a keyword in mysql and we want the column values instead
#this code shows reveals the duplicate rows by showing any row number that is greater than 1
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off,  `date`) AS row_num
FROM layoffs_staging;

#find duplicates
WITH duplicate_cte AS
(
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company, 
location, industry, total_laid_off, percentage_laid_off,  `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoffs_staging
WHERE company = 'Casper'
;

#remove duplicates
WITH duplicate_cte AS
(
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company, 
location, industry, total_laid_off, percentage_laid_off,  `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE 
FROM duplicate_cte
WHERE row_num > 1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company, 
location, industry, total_laid_off, percentage_laid_off,  `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT DISTINCT(company)
FROM layoffs_staging2;

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

#STANDARDIZED CRYPTO
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%'
;

#standardizing the countries
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM COUNTRY)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM COUNTRY)
WHERE country LIKE 'United States%';

#standardizing the dates
#remeber date is a keyword so we have to use backticks when refeering to a column name
SELECT `date`
FROM layoffs_staging2;

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y')
;

SELECT `date`
FROM layoffs_staging2;

#changing data type of date from text to DATE but note always do this in staging area not actual table
ALTER TABLE layoffs_staging2
MODIFY COLUMN  `date` DATE;

#populating null and balank values and removing unnecessary rows and columns
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
or industry = '';

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb'
;

SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
		ON t1.company = t2.company
        WHERE t1.industry IS NULL 
        AND t2.industry IS NOT NULL;
        
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    SET t1.industry = t2.industry
	WHERE t1.industry IS NULL 
        AND t2.industry IS NOT NULL;
        
DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

        
SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
