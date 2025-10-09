---
layout: page
element: notes
title: Functions
language: R
---

### Understandable and reusable code

* Write code in understandable chunks.
* Write reusable code.

### Understandable chunks

* Human brain can only hold limited number of things in memory
* Write programs that don't require remembering all of the details at once
* Treat functions as a single conceptual chunk.

### Reuse

* Want to do the same thing repeatedly?
    * Inefficient & error prone to copy code
    * If it occurs in more than one place, it will eventually be wrong somewhere.
* Functions are written to be reusable.

### Function basics

```r
function_name <- function(inputs) {
  output_value <- do_something(inputs)
  return(output_value)
}
```

* The braces indicate that the lines of code are a group that gets run together  
* A function runs all of the lines of code in the braces
* Using the arguments provided
* And then returns the output  

### "Chunk" of code   

* Let's write some code to calculate the average of a vector  
  * I know there is already a `mean()` function, but let's go through the process  

* First, let's see what needs to happen if we wrote the code line-by-line  
* To calculate an average, we need the sum of all the numbers in a vector, as well as the sample size, or n.  
* We can do this with some basic built-in functions  

* The basic workflow is:  
    * Make a vector  
    
    * Sum the vector  
    
    * Get the sample size, n (using `length()`)  
    
    * Divide the sum by n  
    

```
# make a vector
z <- 1:10
# sum the vector
total <- sum(z)
# use length() to get sample size or n
sample_size <- length(z)
# divide sum by n  
average <- sum_z / n_z
average 
```

* We can use the built-in `mean()` function to check our work  

```
mean(z)
```

* Let's look at our code again  

```
total <- sum(z)
sample_size <- length(z)
average <- total / sample_size
```
* If we had a new vector called `y`, what would we need to change in that code, and what needs to stay the same?  
* All the `x`'s need to be turned into `y`'s:  

```
y <- 10:20
total <- sum(y)
sample_size <- length(y)
average <- total / sample_size
average
```
* This works, but if we wanted to have unique values for `total`, `sample_size`, etc., we need to come up with new names  
* It also takes a lot of copy/pasting, and would be easy to make a mistake. e.g., 

```
total <- sum(x) # missed this one and it's still an x... calculation will be incorrect
sample_size <- length(y)
average <- total / sample_size
average
```

* if we turn those lines of code into a function, we can call it on any vector  
* Also, if there is an error, we only need to fix the function and can then re-run the code  

### Writing a function  

* We already established that the thing that changes from one run to another is just our vector (`y` or `z` in the previous examples)  
* The rest of the code is identical  

* But first, let's assign a function  

```
my_mean <- function(input){ # function name and input/arguments
# body of the function, what it does
  input_total = sum(input)
  input_sample_size = length(input)
  input_average = input_total / input_sample_size
# use return to designate what comes out of the function
  return(input_average)
}
```
* We assign the function by giving it a name (`my_mean`) and then telling R it is a `function()` 
* Inside the `function()` command, we name the input arguments (in this case `input`)  
* In the body of the function, we define what to do with the input arguments  
  * Note that I changed the names slightly of the intermediate variables.  
  * There is a reason for this that we will return too.  
  
* In this case, the only thing that we want the function to spit out at the end is the `input_average`, so we use the `return()` function  

### Running the function  

* The above code assigned the function  
* To run it, we need to call the function and define the input variable  
* Let's make a new variable, `x`, and call our new function  
* We can check our answer by using the built-in `mean()` function

```
x <- 100:150

my_mean(input = x)
my_mean(x)
```

### Intermediate variables  

* Note that in our function we made the intermediate variables `input_total`, `input_sample_size`, and `input_average`  
* But if we try and print these out we get an error:

```
input_total
input_sample_size
input_average
```

* That's because these objects only exist "inside" the function call  
* When we call `my_mean()`, it creates a temporary variable with the above names, but then they disappear  
* Similar to how we can print things in the console, but if we want to use them again we have to save them as an object  
* The only things that "exist" at the end of the function are what is in the `return()` call at the end. 

* Treat functions like a black box
  * *Draw a box on board showing inputs->function->outputs*
  * The only things the function knows about are the inputs we pass it
  * The only thing the program knows about the function is the output it produces


> Do [Writing Functions]({{ site.baseurl }}/exercises/Functions-writing-functions-R)


### Multiple outputs  

* Let's modify our function to return the sample size and the total, in addition to the mean  
* Let's rename it `my_mean2()` so we have both versions  
* We will also modify the `return()` call at the end    
  * use the `c()` command inside to make a vector of our three return values  

```
my_mean2 <- function(input){ 
  input_total = sum(input)
  input_sample_size = length(input)
  input_average = input_total / input_sample_size
  return(c(input_total, input_sample_size, input_average))
}

my_mean2(x)
```
* This is good, but we need to remember the order of the outputs  
* Let's modify it one more time to return it as a data.frame  
* We can also specify the colnames to be more descriptive  

```
my_mean3 <- function(input){ 
  input_total = sum(input)
  input_sample_size = length(input)
  input_average = input_total / input_sample_size
  # make a dataframe holding all our values
  out_df = data.frame(total = input_total, 
                      sample_size = input_sample_size, 
                      average = input_average)
  # return the data frame
  return(out_df)
}

my_mean3(x)
```
> Do [Multiple Outputs]({{ site.baseurl }}/exercises/Functions-multiple-outputs-R)

### Functions with multiple arguments  

* Let's make a function to calculate volume  
* $v = l * w * h$  
* where l is length, w is width, and h is height  
```
calc_shrub_vol <- function(length, width, height) {
  area <- length * width
  volume <- area * height
  return(volume)
}
```

* Call the function with some arguments.  
* Note we need three arguments  
* we can put them in the right order, or name them  

```r
calc_shrub_vol(0.8, 1.6, 2.0)
calc_shrub_vol(length = 0.8, width = 1.6, height = 2.0)
```

* Store the output to use it later in the program

```r
shrub_vol <- calc_shrub_vol(0.8, 1.6, 2.0)
```

> Do [Use and Modify]({{ site.baseurl }}/exercises/Functions-use-and-modify-R).
> End of 1 hour class

### Default arguments

* Defaults can be set for common inputs.
* For example, many of our shrubs are the same height so for those shrubs we only measure the `length` and `width`.
* So we want a default value for the `height` for cases where we don't measure it

```r
calc_shrub_vol <- function(length, width, height = 1) {
  area <- length * width
  volume <- area * height
  return(volume)
}

calc_shrub_vol(length = 0.8, width = 1.6) # no height = needed
calc_shrub_vol(0.8, 1.6, 2.0)
calc_shrub_vol(length = 0.8, width = 1.6, height = 2.0)
```

> Do [Default Arguments]({{ site.baseurl }}/exercises/Functions-default-arguments-R).

> *Discuss why passing `a` and `b` in is more useful than having them fixed*

### Named vs unnamed arguments

* When to use or not use argument names

```r
calc_shrub_vol(length = 0.8, width = 1.6, height = 2.0)
```

Or

```r
calc_shrub_vol(0.8, 1.6, 2.0)
```

* You can always use names
    * Value gets assigned to variable of that name
* If not using names then order determines naming
    * First value is `length`, second value is `width`, third value is `height`
    * If order is hard to remember use names
* In many cases there are *a lot* of optional arguments
    * Convention to always name optional argument
* So, in our case, the most common approach would be

```r
calc_shrub_vol(0.8, 1.6, height = 2.0)
```

### Combining Functions

* Each function should be single conceptual chunk of code
* Functions can be combined to do larger tasks in two ways

* Calling multiple functions in a row

```r
est_shrub_mass <- function(volume){
  mass <- 2.65 * volume^0.9
}

shrub_volume <- calc_shrub_vol(0.8, 1.6, 2.0)
shrub_mass <- est_shrub_mass(shrub_volume)
```

* We can also use pipes with our own functions
* The output from the first function becomes the first argument for the second function

```r
library(dplyr)
shrub_mass <- calc_shrub_vol(0.8, 1.6, 2.0) %>%
  est_shrub_mass()
```

* Note that `calc_shrub_volume()` requires three inputs, but only returns one input  
* `est_shrub_mass()` only requires one input, so piping works  

> Do [Combining Functions]({{ site.baseurl }}/exercises/Functions-combining-functions-R).

* We can nest functions

```r
shrub_mass <- est_shrub_mass(calc_shrub_vol(0.8, 1.6, 2.0))
```

* But we careful with this because it can make code difficult to read
* Don't nest more than two functions

* Can also call functions from inside other functions
* Allows organizing function calls into logical groups

```r
est_shrub_mass_dim <- function(length, width, height){
  volume = calc_shrub_vol(length, width, height)
  mass <- est_shrub_mass(volume)
  return(mass)
}

est_shrub_mass_dim(0.8, 1.6, 2.0)
```

* We ***don't*** need to pass the function name into the function
* That's the one violation of the black box rule

### Using dplyr & ggplot in functions

* There is an extra step we need to take when working with functions from dplyr and ggplot that work with "data variables", i.e., names of columns that are not in quotes
* These functions use tidy evaluation, a special type of non-standard evaluation
* This basically means they do fancy things under the surface to make them easier to work with
* But it means they don't work if we just pass things to functions in the most natural way

```r
library(ggplot2)

make_plot <- function(df, column, label) {
  ggplot(data = df, mapping = aes(x = column)) +
    geom_histogram() +
    xlab(label)
}

surveys <- read.csv("surveys.csv")
make_plot(surveys, hindfoot_length, "Hindfoot Length [mm]")
```

* To fix this we have to tell our code which inputs/arguments are this special type of data variable
* We do this by "embracing" them in double curly braces \{\{
`aes(x = \{\{column\}\})`  

  * NOTE: sometimes the code display doesn't render correctly. In the `make_plot()` function below, the `aes()` function should have the variable `column` inside of two curly braces \{

```r
library(ggplot2)

make_plot <- function(df, column, label) {
  ggplot(data = df, mapping = aes(x = {{column}})) +
    geom_histogram() +
    xlab(label)
}

surveys <- read.csv("surveys.csv")
make_plot(surveys, hindfoot_length, "Hindfoot Length [mm]")
make_plot(surveys, weight, "Weight [g]")
```

### Code design with functions

* Functions let us break code up into logical chunks that can be understood in isolation
* Write functions at the top of your code then call them at the bottom
* The functions hold the details
* The function calls show you the outline of the code execution

```r
clean_data <- function(data){
  do_stuff(data)
}

process_data <- function(cleaned_data){
  do_dplyr_stuff(cleaned_data)
}

make_graph <- function(processed_data){
  do_ggplot_stuff(processed_data)
}

raw_data <- read.csv('mydata.csv')
cleaned_data <- clean_data(raw_data)
processed_data <- process_data(cleaned_data)
make_graph(processed_data)
```

### Documentation & Comments

* Documentation
    * How to use code
    * Use Roxygen comments for functions
* Comments
    * Why & how code works
    * Only if it code is confusing to read

### Working with functions in RStudio

* It is possible to find and jump between functions
* Click on list of functions at bottom of editor and select

* Can be helpful to clearly see what is a function
* Can have RStudio highlight them
*  Global Options -> Code -> Display -> Highlight R function calls
