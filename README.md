# 📊 Sales Data Warehouse — AdventureWorks (Pentaho + PostgreSQL)

## 🧠 Project Overview

This project implements a corporate Sales Data Warehouse using the AdventureWorks transactional database as the OLTP source.

The full ETL pipeline was developed using Pentaho Data Integration (PDI), while PostgreSQL was used as the database system for both the source and the destination Data Warehouse.

The result is a star schema optimized for Business Intelligence and historical sales analysis.

---

## 🎯 Objectives

- Design a corporate Data Warehouse
- Implement a dimensional star schema (Kimball approach)
- Build a robust and re-executable ETL pipeline
- Integrate data from a real OLTP system
- Enable multidimensional sales analysis

---

## 🏢 OLTP Source System

Database used:

AdventureWorks (migrated to PostgreSQL)

Relevant tables analyzed:

- SalesOrderHeader
- SalesOrderDetail
- Customer
- Product
- Employee
- SalesTerritory
- Store
- Person

---

## ⭐ Data Warehouse Architecture

The warehouse follows a dimensional star schema composed of one fact table and five dimensions.

### 🧩 Fact Table — FactSales

Each row represents a sales order line.

Measures:

- QuantitySold
- UnitPrice
- UnitDiscount
- SalesSubtotal
- TotalWithTax
- UnitCost (optional)

Foreign Keys:

- ProductKey → DimProduct
- CustomerKey → DimCustomer
- EmployeeKey → DimEmployee
- StoreKey → DimStore
- DateKey → DimDate

A surrogate key was generated for the fact table.

---

### 📦 DimProduct

Sources: Product, ProductSubcategory, ProductCategory

Attributes:

- ProductName
- Subcategory
- Category
- Color
- Size
- Model
- ProductType

---

### 👤 DimCustomer

Sources: Customer, Person, PersonPhone, EmailAddress

Attributes:

- FullName
- Gender
- CustomerType (Individual / Company)
- City
- StateProvince
- Country

---

### 🧑‍💼 DimEmployee

Sources: Employee, Person, EmployeeDepartmentHistory, Department

Attributes:

- FullName
- JobTitle
- Department
- HireDate
- Status (Active / Inactive)

---

### 🏪 DimStore / DimTerritory

Sources: SalesTerritory, Store

Attributes:

- StoreOrTerritoryName
- Region
- Country
- Group

---

### 📅 DimDate

Generated through the ETL process.

Attributes:

- FullDate
- Day
- Month
- MonthName
- Year
- Quarter
- DayOfWeek

---

## ⚙️ ETL Process

Developed entirely using Pentaho Data Integration.

### 🔹 Extraction

- Data extracted from AdventureWorks in PostgreSQL
- Selection of relevant sales tables

### 🔹 Transformation

- Data cleansing and standardization
- Integration of multiple OLTP tables
- Surrogate key generation
- Null handling
- Data type conversion
- Dimension construction
- Date dimension generation
- Referential integrity validation

### 🔹 Load

- Dimensions loaded first
- Fact table loaded afterward
- Key consistency ensured
- Re-executable process
- Basic incremental loading implemented

---

## 📈 Analytical Capabilities

This warehouse supports analysis such as:

- Sales by product category
- Sales trends over time
- Territorial comparisons
- Most profitable customers
- Employee performance
- Historical sales behavior

---

## 🛠️ Technologies Used

- Pentaho Data Integration (PDI)
- PostgreSQL
- SQL
- ETL Pipelines
- Data Warehousing

---

## 📊 Project Artifacts

The repository includes:

- Star schema diagram
- ETL workflow screenshots
- SQL scripts for schema creation

---

## 📌 Author

Dass — Data Science & AI Engineer
