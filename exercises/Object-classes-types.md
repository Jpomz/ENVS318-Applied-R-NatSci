---
layout: exercise
topic: Vectors
title: Vector classes
language: R
---

Cut and paste the following vectors into your assignment. Then use code to answer the following questions. 

```
char_num <- c("a", "b", 3)
char <- c("z", "x", "y")
numbers2 <- c(7, 6, NA)
numbers3 <- c(8, 16, 1)
logical1 <- c(TRUE, TRUE)
logical2 <- c(TRUE, FALSE)
logical3 <- c(FALSE, FALSE)
char_num2 <- c("1", "2", "3")
char_num3 <- c("1", "2", "b")
```
1. What is the `class()` of the `char_num` vector?  

2. Using basic math expressions, add the `char_num` and `char` vectors together. This should result in an error. Copy the error output from your console and put it in as a comment in your assignment. Briefly, explain why you got an error for this problem.  

3. What is the class of `numbers2` and `numbers3`?  

4. Add `numbers2` and `numbers3` together and print out the results. What happens with the `NA` from `numbers2` in your output?  

5. Convert the `numbers2` vector using the `as.character()` function. 

6. What is the class of `logical1`?  

7. Add the `logical1` and `logical2` vectors together and print out the results. 

8. Subtract the `logical3` vector from the `logical1` vector and print out the results. 

9. Convert the `logical2` vector to a number using the `as.numeric()` function. What number is the value of `TRUE` and `FALSE` equal to?

10. Convert the `logical2` vector to a character using the `as.character()` function. 

11. Convert `char_num2` vector to a number using the `as.numeric()` function.  

12. Convert `char_num3` vector to a number using the `as.numeric()` function.  

13. Convert `char_num2` using the `as.logical()` function.  

14. Convert `char_num3` using the `as.logical()` function.  

15. Why do you think some classes can be converted while others cannot? Convert `char_num2` vector to a number using the `as.numeric()` function.







