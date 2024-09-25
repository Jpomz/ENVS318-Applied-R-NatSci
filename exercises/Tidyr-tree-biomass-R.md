---
layout: exercise
topic: Tidyr
title: Tree Biomass
language: R
---

Estimating the total amount of biomass (*the total mass of all individuals*) 
in forests is important for understanding the global carbon budget and how the 
earth will respond to increases in carbon dioxide emissions. We can estimate
the mass of a tree based on its diameter.

There are lots of equations for estimating the mass of a tree from its diameter, 
but one good option is the equation: 
    
Mass = 0.124 * Diameter<sup>2.53</sup>

where `Mass` is measured in kg of dry above-ground biomass and
`Diameter` is in cm
[DBH](https://en.wikipedia.org/wiki/Diameter_at_breast_height)
([Brown 1997](http://www.fao.org/docrep/W4095E/W4095E00.htm)).

We're going to estimate the total tree biomass for trees in a 96
hectare area of the Western Ghats in India.
The data needs to be tidied before all of the tree stems can be used for analysis.
f
If the [`Macroplot_data_Rev.txt`](http://datacarpentry.org/semester-biology/data/Macroplot_data_Rev.txt) is not already in your working directory download a copy.

1. Use the data pipeline (including `mutate()` and `pivot_longer()`) we developed in class to create a longer data frame with one row for each measured stem. Use dplyr's `filter` function to remove all of the girths that are zero and use `extract()` to get the stem number, making sure to `convert = TRUE` to make it a number class. Store this longer data frame as an object called `clean_data`, and use `head()` to display the first few rows in your console.  
2. Stems are measured in girth (*i.e., circumference*) rather than diameter.
   Use `mutate()` to convert girth to diameter using the following formula: `diameter = circumference / pi` and use `head()` to display the first few rows in your console.  
   
3. Add another line to your `mutate()` function which calculates tree mass from the new diameter column you made according to the following equation: `mass = 0.124 * diameter^2.53`. Save this new data frame as `tree_mass` and use `head()` to display the first few rows in your console.  

4. Estimate the total biomass by summing the mass of all of the stems in the `tree_mass` data.

5. The `SpCode` column contains information on the genus and specific epithet (species). Use `separate()` on the `SpCode` column to make a `GenusCode` and `SpEpCode` columns by separating them at position 4. Then use `group_by` and `summarize` to calculate the total biomass for each unique `GenusCode`.

6. Use ggplot to make a histogram of the `diameter` values in your `tree_mass` object. Make the x label `"Diameter [cm]` and the y label `"Number of Stems"`