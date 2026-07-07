## A folder for Microsoft SQL Server databases and their queries

## Table of contents
* [General info](#general-info)
* [Projects](#projects)
* [Setup](#setup)

## General info
This folder contains various databases built from scratch using Microsoft SQL Server language


## Projects
* `Disk` - Project mimicking disk, contains tables about Author and File
* `Weather data` - Project to analyze weather data (mock data used, including future dates)
* `Praline shop` - Project to analyze packages, pralines and daily transactions (mock data used for tables: Purchases, Morning Delivery and Closing Stock).

## Setup
To run any of the projects inside this folder, you need access to a running Microsoft SQL Server instance and an SQL client (like Visual Studio Code, SSMS, or Azure Data Studio).

1. **Get the Code:**
   * Download the chosen `.sql` file from the project folder or copy its content.

2. **Open Your SQL Client:**
   * **If you use Visual Studio Code (like me):** Ensure you have the `mssql` extension installed. Open the `.sql` file or paste the code into a new query tab.
   * **If you use SSMS / Azure Data Studio:** Open the application and create a new query window.

3. **Connect and Run:**
   * Connect to your local or remote SQL Server instance (e.g., `localhost` or `.` using Windows Authentication/SQL Login).
   * Execute the entire script (in VSC: press `Ctrl + Shift + E` or right-click and choose *Execute Query*).
   * The script will automatically create the database, build the tables, insert sample data, and execute all the analytical queries.
