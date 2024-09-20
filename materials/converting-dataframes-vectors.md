---
layout: page
element: notes
title: Converting Between Data Frames and Vectors
language: R
---

* We've learned about two general ways to store data, vectors and data frames
* Vectors store a single set of values with the same type
* Data frames store multiple sets of values, one in each column, that can have different types

* These two ways of storing data are related to one another
* A data frame is a bunch of equal length vectors that are grouped together
* So, we can extract vectors from data frames and we can also make data frames from vectors

### Extracting vectors from data frames

* There are several ways to extract a vector from a data frame
* Let's look at these using the Portal data
* We'll start by loading the `surveys` table into R and looking at the `head()`  

```r
surveys <- read.csv("data/surveys.csv")
head(surveys)
```

#### Extracting values based on position  

* One common approach to extracting a column into a vector is to use the `[]`
* Remember that `[]` also mean "give me a piece of something"  
* The order inside of the `[]` is `rows`, and `columns`.   
* so if we wanted the item in the first row and the second column we would write:  

```
surveys[1, 2]
```

#### Extracting columns by name  

* Let's get the `species_id` column
* `"species_id"` has to be in quotes because we we aren't using `dplyr`

```r
surveys["species_id"]
```

* This actually returns a one column data frame, not a vector
* To extract a single column as a vector we use two sets of `[[ ]]`
* Think of the second set of `[]` as getting the single vector from inside the one column data frame

```r
surveys[["species_id"]]
```

* We can also do this using `$`
* The `$` in R is short hand for `[[]]` in cases where the piece we want to get has a name
* So, we start with the object we want a part of, our `surveys` data frame
* Then the `$` with no spaces around it
* and then the name of the `species_id` column (without quotes, just to be confusing)

```r
surveys$species_id
```

* finally, we can extract one column as a vector by using the `,` and leaving the `rows` section empty  

```
surveys[,"species_id"]
```

* Think of this as "give me all rows in the column "species_id" "  
* we can do this by column name (above) or by column position.  

```
surveys[,6]
```

> Do [Extracting vectors from data frames]({{ site.baseurl }}/exercises/extracting-vectors-from-data-frames-R/).

### Combining vectors to make a data frame

* We can also combine vectors to make a data frame
* We can make a data frame using the `data.frame` function
* It takes one argument for each column in the data frame
* The argument includes the name of the column we want in the data frame, `=`, and the name of the vector whose values we want in that column
* Just like `mutate` and `summarize`
* So we give it the arguments `sites`, and `density`

 ```r
density_data <- data.frame(sites = c("a", "a", "b", "c"), density = c(2.8, 3.2, 1.5, 3.8))
```

* If we look in the `Global Environment` we can see that there is a new data frame called `density_data` and it has our two vectors as columns

* We could also make this directory using the vectors that are already stored in variables

```r
sites <- c("a", "a", "b", "c")
density <- c(2.8, 3.2, 1.5, 3.8)
density_data <- data.frame(sites = sites, density = density)
```

* We can also add columns to the data from that only include a single value without first creating a vector
* We do this by providing a name for the new column, an equals sign, and the value that we want to occur in every row
* For example, if all of this data was collected in the same year and we wanted to add that year as a column in our data frame we could do it like this

```r
density_data_year <- data.frame(year = 2000, sites = sites, density = density)
```

* `year =` sets the name of the column in the data frame
* And 2000 is that value that will occur on every row of that column
* If we run this and look at the `density_data_year` data frame we'll see that it includes the year column with `2000` in every row

> Do [Building data frames from vectors]({{ site.baseurl }}/exercises/building-data-frames-from-vectors-R/).

### Summary

* So, that's the basic idea behind how vectors and data frames are related and how to convert between them.
* A data frame is a set of equal length vectors
* We can extract a column of a data frame into a vector using either `$` or two sets of `[]`
* We can combine vectors into data frames using the `data.frame` function, which takes a series of arguments, one vector for each column we want to create in the data frame.