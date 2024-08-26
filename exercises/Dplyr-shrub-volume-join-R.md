---
layout: exercise
topic: dplyr
title: Shrub Volume Join
language: R
---

In addition to the main data table on shrub dimensions, Dr. Granger has two additional data tables.
The first describes the manipulation for each experiment.
The second provides information about the different sites.
Download the [shrub-volume-experiments.csv file]({{ site.baseurl }}/data/shrub-volume-experiments.csv) and the [shrub-volume-sites.csv file]({{ site.baseurl }}/data/shrub-volume-sites.csv) and put them in your `data/` subfolder. 

Copy and run the following code into your assignment. 

```
shrub_dims <- read.csv("data/shrub-volume-data.csv")
experiments <- read.csv("data/shrub-volume-experiments.csv")
sites <- read.csv("data/shrub-volume-sites.csv")
```

1. Use `inner_join` to combine the `experiments` and the `shrub_dims` objects. The result will be the shrub dimensions data with an additional `manipulation` column.

2. Import the `sites` data and then combine it with both the data on shrub dimensions and the data on experiments to produce a single data frame that contains all of the data columns.
