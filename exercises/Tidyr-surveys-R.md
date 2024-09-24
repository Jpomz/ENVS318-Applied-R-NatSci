---
layout: exercise
topic: Tidyr
title: Surveys
language: R
---

Portal surveys data tidying. 

Load the surveys data into your session with the following

```
surveys <- read.csv("data/surveys.csv")
```

Sub problems 1-4 will build on each other starting with the `surveys` data object. Sub Problems 5-8 will build on each other and start a a new pipeline beginning with the original `surveys` data again. 

1. Use `filter()` to remove all `NA` values from the `weight` column. Use `head()` to print the first few rows of your new object.  
2. Use `unite()` to make a new column called `date_plot` which combines the `year`, `month`, `day`, and `plot_id` columns. Use `head()` to print out the first few rows of this object.  
3. Group your data by `date_plot` and `species_id` and summarize the mean `weight` for each group. Use `head()` to print out the first few rows of this object.  
4. Use `pivot_wider` to make a new data object with `species_id` in the columns and `weight` in the cells. Use `head()` to print out the first few rows of this object.  

5. Begin a new data pipeline using the original `surveys` data object. Use `filter()` to remove all `NA` values from weight, keep only the `DM` species, and remove all empty values (i.e., `""`) of `sex`. Use `head()` to print out the first few rows of this object.  
6. `unite()` the `species_id` and `sex` column into a new `sp_sex` column. Use `head()` to print out the first few rows of this object.  
7. Group the data by `year` and `sp_sex` to calculate the mean weight. Use `head()` to print out the first few rows of this object.  
8. Starting with your summarized data, `separate()` `sp_sex` into a `species` and `sex` column and then use `ggplot()` to make a scatter graph of mean weight by year, and color the points according to `sex`. Also add linear regression lines to your plot, one for males and one for females. 