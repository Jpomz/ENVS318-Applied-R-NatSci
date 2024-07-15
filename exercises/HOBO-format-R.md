---
layout: exercise
topic: HOBO loggers
title: HOBO format
language: R
---

Collecting data in the field is important for characterizing environmental conditions. However, we can't always be in the field. One solution to this issue is using data loggers and other automated equipment to collect data or measure variables for us. Unfortunately, this data is often recorded in an untidy format and requires some modification before it can be used in computer software and programming languages. 

We're going to look at temperature data recorded by a [HOBO pendant logger](https://www.onsetcomp.com/products/data-loggers/ua-001-64). 

If the [`HOBO_temperature_single.csv`](https://jpomz.github.io/ENVS396-FA-2024/data/HOBO_temperature_single.csv) is not already in your `data/` folder, download a copy.

1. Open the `HOBO_temperature_single.csv` file in a spreadsheet software such as Microsoft Excel or Google Sheets. How many rows and columns have data in this file? Which row number has the column names? How many columns have data that we actually want to keep?  

2. Use `read.csv()` to import the file into R and save it as an object called `dat`. You will want to skip the first few lines so that the column names are read in as the first row. for now, keep all columns. Use `head()` to display the first few rows of your data. 

3. Use the `[,]` notation to modify your `dat` object to keep all rows and only columns `1:3`. Print out the dimensions of your new object. 

4. Use the `class()` function to print out the type of data stored in each of your columns.  

5. Rename the columns in your `dat` object to be: `obs`, `data_time_chr` and `temperature` and print out the first few rows of your new object. You are using `data_time_chr` to highlight the point that this column is a character type, and not in the proper `date-time`.

6. Use `mutate()` and `mdy_hm()` to convert the `date_time_chr` column into a proper data type. Your new column should be named `date_time`. Print out the first few rows of your new object. 

7. Use the `year()`, `month()`, and `day()` functions inside of mutate to make a new column for each of these date components. Print out the first few rows of your new data object. 

8. Group your data by year, month, day (in that order) and calculate the mean daily temperature. Save this as a new object and print out the first few rows of your new object. 

9. Use the `make_date()` function inside of `mutate` to combine your year, month, and day columns into a single column. Print out the first few rows of your data. 

10. Plot the daily mean data you calculated with date on the x-axis and daily mean temperature on the y-axis. 

~ 7 problems