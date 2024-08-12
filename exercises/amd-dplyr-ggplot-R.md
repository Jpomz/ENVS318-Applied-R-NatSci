---

layout: exercise
topic: dplyr
title: Data Join Aggregation ggplot
language: R
---

Download and load the [AMD_bugs_joined.csv](https://jpomz.github.io/ENVS396-FA-2024/data/AMD_bugs_joined.csv) 
in your assignment script. 


1. Summarize the data to get an average `mean_dm_g` for every site, and plot the data as a bar chart.   

2. Summarize the data to get an average `mean_dm_g` for each category, and plot the data as a bar chart. 


3. Summarize the data to get an average and a standard deviation (SD) `mean_dm_g` for each category, and plot the data as a bar chart with an errorbar. 

4. Modify the data to make a bar chart of the number of `taxa` in each category.  


5. Modify the data to make a scatter point graph of the number of `taxa` for each values in the `pca1` column.  
  * Make the size of the points = 3  
  * Map color to pca1 and use `scale_color_viridis_c()`  
  * run `?scale_color_viridis_c` to see what color `option`'s are available and choose one  

6. Modify the data to make a scatter point graph of the number of `taxa` for each values in the `pca1` column. This time, modify the code to include the `category` variable in your summary.    
  * Make the size of the points = 3  
  * Map color to `category` and use `scale_color_viridis_d()`  
  * `scale_color_viridis_d` has the same color options. Choose the same option you used above.  
  * set `direction = -1` to make the color pallette match above.   


