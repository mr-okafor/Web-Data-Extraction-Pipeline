# Web-Data-Extraction-Pipeline
An end-to-end data extraction and preparation pipeline that uses Python to scrape epidemic data from a web source, transform the extracted data into a structured DataFrame, and load it into SQL Server for data cleaning, transformation, and preparation for downstream analysis.

## Project Overview

This project demonstrates an end-to-end data extraction and preparation pipeline for collecting, transforming, cleaning, and storing epidemic-related data from a web source.

The project uses **Python** to extract and structure the raw web data into a Pandas DataFrame, followed by **SQL Server** for data cleaning, transformation, and preparation. The final dataset is structured and prepared for downstream analysis and visualization.

The project focuses on building a reliable workflow for turning semi-structured web data into a clean, analysis-ready dataset.

---

## Project Objectives

* Extract epidemic data from a web source using Python.
* Parse and structure the extracted information into a Pandas DataFrame.
* Identify and handle inconsistencies in the raw dataset.
* Load the extracted data into SQL Server.
* Clean and transform the data using SQL.
* Standardize fields and prepare the dataset for downstream analysis.
* Maintain a clear separation between raw and cleaned data.

---

## Technology Stack

| Tool                 | Purpose                                                 |
| -------------------- | ------------------------------------------------------- |
| **Python**           | Web data extraction and initial data processing         |
| **Pandas**           | Data manipulation and DataFrame creation                |
| **BeautifulSoup**    | HTML parsing and web data extraction                    |
| **SQL Server**       | Data storage, cleaning, and transformation              |
| **SQL**              | Data cleaning and preparation                           |
| **Jupyter Notebook** | Development and documentation of the extraction process |

---

## Data Pipeline

The project follows the workflow below:

```text
Web Source
    ↓
Python Web Scraping
    ↓
Raw Data
    ↓
Pandas DataFrame
    ↓
SQL Server
    ↓
Data Cleaning & Transformation
    ↓
Analysis-Ready Dataset
```

### 1. Web Data Extraction

Python was used to retrieve epidemic-related information from the source website. The HTML content was parsed to identify and extract the relevant fields.

The extraction process also accounted for variations in how information was presented on the source pages.

### 2. Data Structuring

The extracted information was converted into a Pandas DataFrame to provide a structured representation of the data.

At this stage, the data was inspected for:

* Missing values
* Inconsistent formats
* Unexpected characters
* Mixed data types
* Duplicate or incomplete records
* Inconsistent numerical representations

### 3. Loading into SQL Server

The structured DataFrame was transferred into SQL Server for more extensive data cleaning and preparation.

The database provided a structured environment for transforming the raw dataset and creating a reliable dataset for subsequent analysis.

### 4. Data Cleaning and Transformation

SQL was used to clean and standardize the data.

The cleaning process included tasks such as:

* Handling `NULL` and unknown values
* Removing unwanted reference characters
* Cleaning numerical fields
* Standardizing text values
* Extracting usable values from ranges
* Separating values where necessary
* Converting fields into appropriate data types
* Creating a cleaned version of the original dataset
* Selecting only the fields required for analysis

The raw data was preserved separately from the cleaned dataset to maintain data lineage and make the transformation process reproducible.

---

## Data Quality Challenges

One of the main challenges in the project was dealing with inconsistencies in the source data.

For example, numerical fields were not always represented in a consistent format. Values could appear as individual numbers, ranges, text-based quantities, or values containing additional descriptive information.

Examples included formats such as:

```text
75000
75000–100000
5–10 million
2 million
Unknown
Unknown around 1% of those infected
```

These inconsistencies required additional transformation before the data could be reliably used for analysis.

This highlighted an important aspect of working with real-world data: **data preparation often requires significantly more work than simply extracting the data.**

---

## Project Structure

```text
Web-Data-Extraction-Pipeline/
│
├── python/
│   └── data_extraction.ipynb
│
├── sql/
│   ├── data_cleaning.sql
│   └── data_preparation.sql
│
├── README.md
└── requirements.txt
```

> The exact folder and file structure may vary depending on the final implementation.

---

## Key Skills Demonstrated

This project demonstrates practical experience with:

* Web scraping
* HTML parsing
* Python
* Pandas
* DataFrame manipulation
* Data profiling
* Data cleaning
* Data transformation
* SQL
* SQL Server
* Data type conversion
* Handling semi-structured data
* Data quality management
* ETL workflows
* Data pipeline design
* Preparing datasets for BI and analytics

---

## Outcome

The project transformed data collected from a web source into a structured and cleaned dataset that can be used for further exploratory analysis, statistical analysis, or business intelligence reporting.

Rather than treating web scraping as the final objective, the project focuses on the complete process of **extracting, transforming, storing, and preparing data for downstream use**.

---

## Future Improvements

Potential extensions to the project include:

* Automating the extraction and loading process.
* Adding data validation checks.
* Implementing incremental data loading.
* Scheduling the pipeline for periodic updates.
* Performing exploratory data analysis.
* Building a Power BI dashboard from the cleaned dataset.
* Adding automated data quality monitoring.

---


Skills: **SQL · Power BI · Tableau · Python · Excel**
