---
layout: page
element: notes
title: dplyr matching joins
language: R
time: 30
---

### Matching joins  

* Sometimes the data in our columns doesn't match  
* Requires mutating the values only in certain cells  


### Setup 

* Download [`AMD_bugs_01.csv` (link)](https://jpomz.github.io/ENVS396-FA-2024/data/AMD_bugs_01.csv), [`AMD_bugs_02.csv` (link)](https://jpomz.github.io/ENVS396-FA-2024/data/AMD_bugs_02.csv), and [`AMD_gradient.csv` (link)](https://jpomz.github.io/ENVS396-FA-2024/data/AMD_gradient.csv) and put them in your `data/` folder.  


```
library(tidyverse)
bugs_01 = read.csv("data/AMD_bugs_01.csv")
bugs_02 = read.csv("data/AMD_bugs_02.csv")
gradient = read.csv("data/AMD_gradient.csv")
```

* we will start with `bugs_01` and the `gradient` objects  

```
head(bugs_01)
head(gradient)
```

* The `bugs_01` object has information on the site, the taxa and the mean dry mass (in grams).  
* The `gradient` object has a column for `site`, `pca1` (a continuous measure of AMD impacts), and a `category` column which broadly groups the sites into reference, impact, and heavily impacted.  
* you can probably guess that we want to add the gradient information to the biological information based on the `site` column.  

* let's first try it as-is using `left_join()`  
* Recall that `left_join()` keeps all the data from the first table, whether or not it has a match in the second table  

```
left_join(bugs_01, gradient)
```

* Notice that the new table has `NA`s for the site `"Burnet Tributary"`.  
* Let's look at all the values for `site` in both tables  

```
unique(bugs_01$site)
unique(gradient$site)
```

* Notice that in the `gradient` object the site name is `Burnet_Trib` and it is `Burnett Tributary` in the `bugs_01` object.  
* Here, there is only about 25 sites, so you could probably just look at them manually to figure out where the mismatches are  
* `dplyr` has a number of functions which can help us do this programmatically  
* We will specifically be using the `intersect()` and `setdiff()` functions  
* See `?dplyr::setops` for a full list

* `intersect()` shows you which values occur in both tables  
* `setdiff()` finds all rows in the first table (x) which are **not** in the second table (y)  

```
unique(bugs_01$site)
intersect(bugs_01$site, gradient$site)
```

* There are 12 site names in `bugs_01` and only 11 in `gradient`  
* We can see which one is missing:  

```
setdiff(bugs_01$site, gradient$site)
```

* recall that it shows which value in the first table does not show up in the second  
* I find it is often helpful to switch the order to see it the other way  

```
setdiff(gradient$site, bugs_01$site)
```

* In this case, there are many sites in gradient that don't appear in `bugs_01` (but they do show up in `bugs_02`)  

### Mutating specific values  

* We need to change the `gradient` object  
* Specifically, we need `Burnet_Trib` to become `Burnet Tributary`  
* To do that, we can use `mutate()` with a special helper function called `case_when()`  

* `case_when()` only mutates specific rows which match some criteria  
* It's kind of like a `filter()` command inside of a mutate function  
* We are going to overwrite the `site` column, but we only want to overwrite it when `site == "Burnet_trib"`.  
* Let's take a look at what the code looks like:  

```
gradient |>
  mutate(site = case_when(site == "Burnet_Trib" ~ "Burnet Tributary"))
```

* We can see that the output has "Burnet Tributary" in the `site` column, but all of our other sites are now `NA`s  
* The `mutate` command above is very specific, and only looks for when `site == "Burnet_Trib"`.  
* Since we didn't tell it about any of the other values in `site`, it treats them as `NA`s  
* What we really want to do is keep all the original `site` values, and only overwrite the value we are interested in  
* to do that, we can use the `.default` argument inside of `case_when()`  

```
gradient |>
  mutate(site = case_when(
      site == "Burnet_Trib" ~ "Burnet Tributary", 
      .default = site))
```
* Below is the full line of code including comments

```
gradient |> # our original table
    mutate(site = # overwriting the entire `site` column
          case_when( # we only want to change certain values
              site == "Burnet_Trib" ~ # value to search for
                  "Burnet Tributary", # replacement
              .default = site)) # for all values that don't match above, keep site the same

```

* make sure this makes sense to students in class  
* There is a lot going on here  

* here is another example with a new column name as an illustrative example  
* Note that either option works  
* Overwriting the column and keeping the original `site` name makes the joining in the next step easier  

```
gradient |>
    mutate(site_corrected = case_when(site == "Burnet_Trib" ~ "Burnet Tributary", 
                                      .default = site))
```

* Let's make a new object called `gradient_correct`  
* we will make sure there is not differences in values  
* and then join it to our biological table  

```
gradient_correct <- gradient |>
    mutate(site = case_when(site == "Burnet_Trib" ~ "Burnet Tributary", 
                                      .default = site))

setdiff(bugs_01$site, gradient_correct$site)
```

* The `setdiff()` should return `character(0)` which means that all the rows in table 1 appear in table 2  
* Now we are ready to join the tables  

```
bugs_gradient <- left_join(bugs_01, gradient_correct)
bugs_gradient
```

### Binding rows from two tables  

* The `..._join()` commands we've been using are essentially makes the tables wider by combining columns from two tables  
* We can also make tables longer by combining rows from two different tables using the`bind_rows()` function  
* Let's combine `bugs_01` and `bugs_02`.  

* First, let's look at the `dim()` of the tables on their own and together  

```
dim(bugs_01)
dim(bugs_02)
bugs_together <- bind_rows(bugs_01, bugs_02)
dim(bugs_together)
```

* Notice that the number of columns stays the same but the number of rows increases  

* Be careful that the names of both tables is the same  
* you can check that using `setdiff()` as in the following  

```
setdiff(names(bugs_01), names(bugs_02))
```

* See what happens when the tables have different names  

```
bugs_wrong <- rename(bugs_02, site_name = site)
dim(bugs_wrong)
dim(bugs_01)
dim(bind_rows(bugs_01, bugs_wrong))
```

* here, the number of rows increased correctly, but the new object has an extra column  

```
head(bind_rows(bugs_01, bugs_wrong))
``` 

* R doesn't realize that `site` and `site_name` are the same thing  
* Here's what `setdiff()` looks like when the names don't match  

```
setdiff(names(bugs_01), names(bugs_wrong))
```
* The output is saying that "site" occurs in `bugs_01`, but does **not** occur in `bugs_wrong`  

```
setdiff(names(bugs_wrong), names(bugs_01))
```

* Likewise, "site_name" occurs in `bugs_wrong` but does not occur in `bugs_01`  
* Before binding these tables together, you would want to change one so that the names match.  

### Save results using `write_csv()`  

* Recall that `bugs_gradient` contains the biological information along with the AMD gradient data  
* In a real analysis scenario, you wouldn't want to have to fix and join these tables together everytime  
* If you want to save your results for later use, you can use the `write_csv()` function  
* Let's save `bugs_gradient` to our `data/` folder  

```
write_csv(bugs_gradient, file = "data/AMD_example_from_lecture.csv")
```

