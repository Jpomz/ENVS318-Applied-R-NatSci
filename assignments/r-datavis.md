---
layout: page
element: assignment
title: Data Visualization
language: R
exercises: ['Acacia and Ants', 'Mass vs Metabolism', 'Acacia and Ants Histograms', 'Acacia and Ants Data Manipulation', 'Graphing Data From Multiple Tables', 'Adult vs Newborn Size']
points: [20, 20, 20, 20, 20, optional]
---

### Learning Objectives

> Following this assignment students should be able to:
>
> - understand the basic plot function of `ggplot2`
> - import 'messy' data with missing values and extra lines
> - execute and visualize a regression analysis

{% include reading.html %}

Place this code at the start of the assignment to load the `tidyverse`. The `tidyverse` is a large suite of packages. This assignment will specifically be using the `ggplot2`, `dplyr` and `readr` packages.

```r
library(tidyverse)
```

{% include assignment.html %}
