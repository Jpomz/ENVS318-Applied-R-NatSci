---
layout: page
element: notes
title: Object Types
language: R
--- 

### Overview  

* In R, we work with objects  
* Objects store data  
* Objects have different dimensions of data storage  

### Object types  

* scalars  
* **vectors**  
* matrices  
* **data.frames**  
* lists  
* **bold** indicates the two types we will work with the most  

### Scalars (AKA basic variables)  

* simplest object type  
* a single value  
* can be any class (`numeric`, `character`, `logical`, `factor`, etc.)  
* create using the assign operator: `<-`  

```
x <- 1
```

### Vectors

* A sequence of values with the same type
* Create using `c()`, which stands for "combine"

```
sites <- c("a", "a", "b", "c")
```

### Matrices  

* matrices (singular: matrix) are 2-dimensional structures with the same type  
* Usually organized into rows and columns  
* create using the `matrix()` function  
* arguments include:  
  * `nrow` the number of rows to create  
  * `ncol` the number of columns to create  
  * `byrow` if `TRUE`, arranges matrix by row, if `FALSE`, arranges matrix by column  
  
* create a matrix with values 1 to 10 and 2 rows 
* note order of numbers when set `byrow = TRUE`  

```
m1 <- matrix(1:10, nrow = 2)
m1_row <- matrix(1:10, nrow = 2, byrow = TRUE)

```
* create matrix with set number of columns  
```
m2 <- matrix(1:10, ncol = 2)
```

* can also create a matrix with values in any order by using the `c()` inside the first argument in the `matrix()` function  

```
m3 <- matrix(c(1, 5, 20, 3, 4, 6, 1000, 33), nrow = 4)
```

* Just like vectors, matrices have to have the same data type in all cells

```
m4 <- matrix(c(1, 2, "3", TRUE), nrow = 2)
```
* This results in all values being a character type since it is the most flexible  

### Data frames  

* Data frames are 2-dimensional structures  
* Each column has to be one data type
* Can have different data types across columns  
* create with the `data.frame()` function  
* give each column a name

```
df <- data.frame(col1 = c(1, 2, 3),
                 col2 = c("a", "b", "c"),
                 logical_column = c(TRUE, FALSE, FALSE))
```

* Use descriptive names in columns  

```
df2 <- data.frame(count = c(1, 2, 3),
                 site_name = c("a", "b", "c"),
                 treated = c(TRUE, FALSE, FALSE))
```

* can also create data frame by combining vectors  

```
# create vectors 
eggs <- 1:5
genus <- c("Cardinalis", "Cardinalis", "Cyanocitta", "Cardinalis", "Cyanocitta")
state <- c("DE", "MA", "CO", "DE", "DE")

# name before "=" in function is what it will be called in data frame
# name after "=" is the object you use to create the column
df3 <- data.frame(eggs = eggs, 
                  genus = genus,
                  st = state) # changed name for reference 
```

### Lists  

* complex, multidimensional data structure  
* lists have elements, and each element can be any object type (including another list)  
* create using the `list()` function  

```
list1 = list("a", 1:4, matrix(letters, ncol = 2), data.frame(x = 1:3, y = TRUE), list(100, 200, 400))
```

* you can name list elements  

```
list2 = list(scalar = 1, 
             vect = 1:3,
             df = data.frame(x = 1:3, y = TRUE))
```

* access elements in list by name:  

```
list2$vect
list2$df
```

* or by number using `[[]]`  

```
list2[[2]]
list2[[3]]

list1[[3]]
```

> Do [Exercise - object types]({{ site.baseurl }}/exercises/object-types-R/).
