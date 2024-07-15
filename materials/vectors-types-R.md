---
layout: page
element: notes
title: Vector types
language: R
--- 

### Vector types 

* Remember that all values in R have a type
* A vector is a sequence of values that all have the **same** type
* Create using the `c()` function, which stands for "combine"

```
v_char <- c("hello", "world", "I'm", "fine")
```

* Using the `class()` function we can see that the type of this vector is character 

```
class(v_char)
```

* We can make vectors of other types with the following:

```
v_logical <- c(TRUE, FALSE, FALSE)
v_numeric <- c(1, 10, 100)
v_numeric2 <- 1:3
```

* The types of these vectors are:  
  * Logical, numeric, and integer  
* Note that `numeric` is an umbrella type which is more flexible and includes types `integer` and `double` which only includes whole numbers and decimal values, respectively.  

* We can also test to see if a vector is of a given type.  
* Use `is.character()` to test to see if `v_logical` vector is a character. 

```
is.character(v_logical)
```

* other functions: `is.character()`, `is.numeric()`, `is.integer()`, `is.double()`, `is.logical()`  
* all these functions return either a `TRUE` or `FALSE` value.  

### Using math with vectors  

* if vectors are numeric, we can perform basic math functions.  

```
v_numeric + v_numeric2
v_numeric * v_numeric2
```

* when performing math with vectors, pay close attention to the length of each vector.  
* the above vectors both had `length == 3` so the first, second, and third elements were each paired.  
* i.e., `1 + 1`, `10 + 2`, `100 + 3`  etc.  
* When vectors are of unequal length the shorter one will be "recycled".  

```
v_num_10 <- 1:10
v_num_3 <- c(10, 20, 30)
v_num_10 - v_num_3
```
* you will get a warning telling you that the lengths are not multiples  
* In this example, there is one "extra" place in `v_num_10` so the first element of `v_num_3` is used  
* when the vectors are multiples of each other the shorter one is recycled, but you do not get a warning message.  
```
v_num_5 <- 16:20
v_num_10 - v_num_5
```

* math functions do not work on character vectors.  

```
v_char2 <- c("good", "bye", "my", "friend")
v_char + v_char2
```

* but math functions do work on logical vectors  

```
v_numeric - v_logical
```

* in R, the logical value `TRUE` is equal to 1, and the logical value `FALSE` is equal to 0. 

### Converting Vector types  

* There is a series of functions which attempts to convert an input to a desired output. 

```
as.numeric(v_logical)
```
* see that `TRUE = 1` and `FALSE = 0`.  
* only certain inputs can be converted to `numeric` or `logical`, but everything can be converted to `character` 

```
as.numeric(v_char)
as.logical(v_char)
```
* these return `NA` values the same length as the input  

```
as.logical(v_numeric)
```
* if the input is a number that does not equal 0, it will return `TRUE`
* if the input is 0 it will return `FALSE`
```
v_num_0s <- c(0, 0, 1, 1)
as.logical(v_num_0s)
```

* character vectors are the most flexible and can contain any values.  

```
as.character(v_logical)
as.character(v_numeric)
```

* Be careful that what you think is a numeric vector is actually a number.  

```
v_char_num <- c("20", "40", "60")
v_char_num + v_numeric
```
* check the class  
```
class(v_char_num)
```
* convert before performing math  
```
as.numeric(v_char_num) + v_numeric
```



> Do [Exercise 9 - Vector classes]({{ site.baseurl }}/exercises/Objects-classes-types/).

