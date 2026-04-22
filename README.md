# walmart-sql
🛒 Walmart Sales Data Analysis (SQL + Python)
📌 Project Overview
This project focuses on analyzing Walmart sales data using Python (Pandas) and SQL (PostgreSQL/MySQL).
The goal is to extract meaningful business insights such as revenue trends, branch performance, and year-over-year comparisons.

📂 Project Structure
├── project.ipynb        # Data cleaning, transformation & upload├── walmart.sql         # SQL queries for analysis├── data/               # Dataset (CSV file)└── README.md           # Project documentation

⚙️ Technologies Used


Python (Pandas, SQLAlchemy, PyMySQL)


SQL (PostgreSQL / MySQL)


Jupyter Notebook (VS Code)



🚀 Workflow
1. Data Loading & Cleaning


Loaded dataset using Pandas


Handled missing values and formatting


Converted date columns


2. Database Connection


Connected Python to MySQL/PostgreSQL using SQLAlchemy


Uploaded dataset to database using:


df.to_sql(name='sales', con=engine_mysql, if_exists='append', index=False)
3. SQL Analysis
Performed business queries such as:


Revenue by branch


Year-wise sales comparison


Top performing branches


Revenue decrease analysis



📊 Sample Insights


Identified branches with revenue decline


Compared 2022 vs 2023 performance


Found top 5 underperforming branches



🛠️ Key SQL Concept Used


CTE (WITH clause)


Aggregation (SUM, GROUP BY)


Date extraction


Joins


Percentage calculation



⚠️ Challenges Faced


Module installation issues (pymysql, sqlalchemy)


Database connection errors


Column mismatch errors


SQL syntax issues (CTE, date formatting)



✅ Learnings


End-to-end data pipeline (CSV → Python → SQL)


Debugging real-world errors


Writing optimized SQL queries


Handling environment issues in VS Code



📌 How to Run


Install dependencies:


pip install pandas sqlalchemy pymysql psycopg2-binary


Run Jupyter Notebook:




Load dataset


Connect to database


Upload data




Execute SQL file in your DB



📈 Future Improvements


Add dashboard (Power BI / Tableau)


Automate pipeline


Deploy project



👩‍💻 Author
Riddhi Bhor

folio project 🚀

