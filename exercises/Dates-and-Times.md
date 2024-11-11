---
layout: exercise
topic: Dates and Times
title: Dates and Times
language: R
---

Cut and paste the following objects into your assignment. Then use code to answer the following questions. 

```
# problems 1.1-1.10
date_01 <- "2019-07-28"
date_02 <- "02-15-2019"
date_03 <- "22-01-2002"
date_04 <- "May 4 1977"
date_05 <- "03-July-1901"
date_06 <- mdy("06-08-2024")

# problem 1.12
date_table <- data.frame(
  month = c(10, 11, 6, 1, 8, 4),
  day = c(17, 28, 19, 30, 10, 14),
  year = c(2003, 2002, 1995, 2022, 2007, 2016)
)

#problem 1.13-1.14
neon <- read.csv("data/NEON_Harvardforest_datetime.csv")
```

1. Convert `date_01` into a `Date` class object.  
2. Convert `date_02` into a `Date` class object. 
3. Convert `date_03` into a `Date` class object. 
4. Convert `date_04` into a `Date` class object. 
5. Convert `date_05` into a `Date` class object. 
6. Extract the year information from `date_06`  
7. Extract the month information from `date_06`   
8. Extract the day information from `date_06`  
9. Extract the day of the year (`yday`) information from `date_06`
10.Extract the week day information from `date_06`  

11. Calculate how many days old you are.  
  * Make an object called `bday` which is your birth date.  
  * Use R commands to calculate todays date.  
  * Subtract `bday` from todays date. 

12. Modify the `date_table` object to have a `date` column which is in the proper `Date` format and print it out on the screen.  

Make sure the the [`NEON_Harvardforest_datetime.csv (link)`](https://jpomz.github.io/ENVS396-FA-2024/data/NEON_Harvardforest_datetime.csv) object is in your `data/` folder and load it into your assignment.  

13. Make a plot of the 15-minute temperature readings through time.  
  * You will first need to convert the `datetime` column to be in the proper format.  
  * Add appropriate axis labels and a title.  

14. Make a plot of the 15-minute temperature readings only for the time period between January 12th and January 16th.  
  * After converting the column to a `Date` format, you will need to extract the month and day information from it.  
  * Then `filter()` the data to the appropriate interval.  

