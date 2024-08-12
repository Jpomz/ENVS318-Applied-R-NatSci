---
layout: page
element: notes
title: dplyr aggregation ggplot
language: R
time: 30
---

> Remember to
> 
> * Load `surveys.csv`, `species.csv` and `plots.csv` data 

### Joining, Aggregating, and plotting

* Here is a basic workflow which is common in many analyses  

1. Join tables with different information in them  
2. Aggregate and summarize data table  
3. Plot the new summary information  

#### 1. Joining `surveys` and `plots`.  

```
library(tidyverse)

surveys <- read.csv("data/surveys.csv")
plots <- read.csv("data/plots.csv")
species <- read.csv("data/species.csv")

survey_plots <- inner_join(surveys, plots)
survey_plots <- inner_join(survey_plots, species)

head(survey_plots)
```

#### 2. Aggregate and summarize  

* We are interested in knowing if the mean weight is different in the different `plot_type`'s  
* First we will remove all the `NA` values from the `weight` column  
* Then, `group_by(plot_type)`  
* `summarize` the `weight` column  
* plot the results in ggplot  

```
survey_plots %>%
  filter(!is.na(weight)) %>%
  group_by(plot_type) %>%
  summarize(mean_weight = mean(weight)) 
```

#### 3. plot the results  

* add a `geom_bar(stat = "identity")`  
* recall that the default for geom_bar calculates and plots the count in your groups  
* we already calculate the number we want plotted, hence the `"identity"` in the function  

```
survey_plots %>%
  filter(!is.na(weight)) %>%
  group_by(plot_type) %>%
  summarize(mean_weight = mean(weight)) %>%
  ggplot(aes(x = plot_type,
             y = mean_weight)) +
  geom_bar(stat = "identity")
```

* We can make this plot a bit better by including the variation in the data  
* modify the `summarize()` command above to also calculate the standard deviation  
* plot the sd as an error bar using `geom_errorbar()`  

```
survey_plots %>%
  filter(!is.na(weight)) %>%
  group_by(plot_type) %>%
  summarize(mean_weight = mean(weight),
            sd_weight = sd(weight)) %>%
  ggplot(aes(x = plot_type,
             y = mean_weight,
             ymin = mean_weight - sd_weight,
             ymax = mean_weight + sd_weight)) +
  geom_bar(stat = "identity") +
  geom_errorbar()
```

* We can see that the SD is very wide  
* A better option would be the standard error, but there is not built in function for this and we are not here to learn about statistics (see my [stats in R course](https://jpomz.github.io/ENVS475/) if you're interested)  
* We can still make this plot better by only plotting the `ymax` side of the error bar  
* Note that it is generally recommended to plot both sides, but this is just an example  

```
survey_plots %>%
  filter(!is.na(weight)) %>%
  group_by(plot_type) %>%
  summarize(mean_weight = mean(weight),
            sd_weight = sd(weight)) %>%
  ggplot(aes(x = plot_type,
             y = mean_weight,
             ymin = mean_weight,
             ymax = mean_weight + sd_weight)) +
  geom_bar(stat = "identity") +
  geom_errorbar()
```

### Two grouping variables 

* Let's add another grouping variable to see if we can explain these patterns in greater depth  
* group by plot and species  

```
survey_plots %>%
  filter(!is.na(weight)) %>%
  group_by(plot_type, genus) %>%
  summarize(mean_weight = mean(weight)) %>%
  ggplot(aes(x = plot_type,
             y = mean_weight,
             fill = genus)) +
  geom_bar(stat = "identity")
  
```

* We can also modify the colors to be colorblind friendly  

```
survey_plots %>%
  filter(!is.na(weight)) %>%
  group_by(plot_type, genus) %>%
  summarize(mean_weight = mean(weight)) %>%
  ggplot(aes(x = plot_type,
             y = mean_weight,
             fill = genus)) +
  geom_bar(stat = "identity") +
  scale_fill_viridis_d()
```

* this makes it (a little) easier to see that the genus *Spermophilus* is lost in some treatments  

* Some other options in viridis  
```
survey_plots %>%
  filter(!is.na(weight)) %>%
  group_by(plot_type, genus) %>%
  summarize(mean_weight = mean(weight)) %>%
  ggplot(aes(x = plot_type,
             y = mean_weight,
             fill = genus)) +
  geom_bar(stat = "identity") +
  scale_fill_viridis_d(option = "magma")
```

* Plot mean weight by year and plot type

```
survey_plots %>%
  filter(!is.na(weight)) %>%
  group_by(plot_type, year) %>%
  summarize(mean_weight = mean(weight)) %>%
  ggplot(aes(x = year,
             y = mean_weight,
             color = plot_type)) +
  geom_point(size = 2, alpha = 0.75) +
  scale_color_viridis_d() +
  theme_bw()
```

### Modifying data before summarizing  

* Sometimes we need to modify the data before summarizing  

* For example, let's say we want to know the number of genera in each plot type  
* We first need to get the `distinct()` combinations of `plote_type` and `genus`  
* Then group it by plot type  
* Then summarize using the special `n()` function which gives us the count  

```
survey_plots %>%
  distinct(plot_type, genus) %>%
  group_by(plot_type) %>%
  summarize(genus_count = n())
```

* We can then pipe that into a `ggplot()` command

```
survey_plots %>%
  distinct(plot_type, genus) %>%
  group_by(plot_type) %>%
  summarize(genus_count = n()) %>%
  ggplot(aes(x = plot_type,
             y = genus_count)) +
  geom_bar(stat = "identity")
```