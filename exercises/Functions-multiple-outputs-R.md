---
layout: exercise
topic: Functions
title: Multiple Outputs
language: R
---

Sometimes, we want to write a function which returns more than one output. 

1. Part 1: Make a vector called `my_vector` of numbers from `25:50`. Print out `my_vector` to your console.  

2. Part 2: Write a function called `multiple_outputs()` which has an input argument of `x`, where `x` is a numeric vector.  
  * Your function should calculate the following outputs:  
    * The sample size, n, of the vector (i.e., `length()`)  
    * The sum of the vector (i.e., `sum()`)  
    * The average of the vector  
    * The standard deviation of the vector (i.e., `sd()`)  
  * Return the 4 outputs listed above as a vector.  

3. Part 3: Make a new function called `multiple_outputs_df()`. Your new function will modify the function written in part 2 above, but this time the output will be a data frame with the following column names: `n`, `total`, `average`, `standard_deviation`.  
