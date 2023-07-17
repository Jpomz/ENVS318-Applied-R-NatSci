---
layout: page
element: assignment
title: Introduction to Course
language: R
---

### Learning Objectives

> Following this assignment students should:
>
> - Have R and Rstudio downloaded
> - Be able to access and open Rstudio
> - Have an R-Project for the course
> - Be able to download packages and load them into your working session

1. Download R and Rstudio
2. Make a new Project called "ENVS396" 
3. In the console, enter the following command and run it:

```
install.packages("tidyverse")
```

**NOTE:** Do *NOT* put `install.packages()` commands in your scripts. Only ever run them in the console. 

* You can also install packages by clicking `Tools` --> `Install Packages` and then entering the package name in the text box and clicking `Install`  


4. Make a new script called "lastname_first-assignment.R" and save it in your `Assignments` folder in your ENVS396 Project. 

5. In your script, type in the following code and make sure it runs correctly:

```
library(tidyverse)
data("starwars")
starwars %>% 
    filter(homeworld == "Tatooine") %>%
    select(name) %>%
    unique()
```
You should see the following output in your console:

```
# A tibble: 10 x 1
   name              
   <chr>             
 1 Luke Skywalker    
 2 C-3PO             
 3 Darth Vader       
 4 Owen Lars         
 5 Beru Whitesun lars
 6 R5-D4             
 7 Biggs Darklighter 
 8 Anakin Skywalker  
 9 Shmi Skywalker    
10 Cliegg Lars
```
Assignment turn in: For full credit, you must show your instructor that you have accomplished all of the above tasks. 