---
layout: exercise
topic: dplyr
title: AMD Join Bind
language: R
---

Make sure that [`AMD_bugs_01.csv` (link)](https://jpomz.github.io/ENVS396-FA-2024/data/AMD_bugs_01.csv), [`AMD_bugs_02.csv` (link)](https://jpomz.github.io/ENVS396-FA-2024/data/AMD_bugs_02.csv), and [`AMD_gradient.csv` (link)](https://jpomz.github.io/ENVS396-FA-2024/data/AMD_gradient.csv) are downloaded and in your `data/` folder.  


```
bugs_01 <- read.csv("data/AMD_bugs_01.csv")
bugs_02 <- read.csv("data/AMD_bugs_02.csv")
gradient <- read.csv("data/AMD_gradient.csv")
```

1. Load all three tables into your assignment and print out the `head()` of each  
2. In lecture we saw that one of the site values in `bugs_01` didn't match the site value in `gradient`. There are also problems in `bugs_02`. Write two lines of code, one which shows that values of site in  `bugs_02` which do not show up in `gradient`, and the second which shows the opposite; which values in `gradient` do not appear in `bugs_02`
3. Make a new object called `gradient_fixed` which changes all the values in the `site` column to match the values found in `bugs_01` and `bugs_02`. Print out the unique values of site from your new object.    
  * Note that only one value doesn't match in `bugs_01` and we corrected that together in lecture.  
  *  There are 7 sites which don't match between `bugs_02` and `gradient`  
  
4. make a new object called `bugs` which binds the rows from your two bug tables. Print out the dimensions of all three "bugs" objects.  
5. Make a new object called `AMD_bugs` which joins the fixed gradient table with your combined bugs table. Print out the dimensions of your new object.  
6. Save your `AMD_bugs` object as a csv in your `data/` folder. Your new file should be named `my_AMD_bugs.csv`  
  
