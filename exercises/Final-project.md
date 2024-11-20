---
layout: exercise
topic: Final project
title: Final project
language: R
---

On Assignment Page, click on the "1. Final project (100 pts)" link to go to a correctly formatted assignment.  

**Overview**  

For your final project, you will be going through one of the typical data analysis procedures. This project incorporates many of the  concepts and tasks we've learned throughout the semester including:  
* Reading in many data files with a for loop  
* Dealing with untidy data formats  
* Joining information stored in different tables  
* Modifying data in a table including:  
  * Formatting `Dates`  
  * Separating columns  
  * Mutating columns  
  * Grouping and Summarizing data  
* and finally, Plotting your results  

**Data background**  

You will be working with a real data set from a former CMU student's independent research project. The student deployed temperature loggers at a site in the Colorado National Monument. The hypothesis was that a sheltered canyon created a microclimate suitable for Ponderosa Pines (*Pinus ponderosa*) to survive. They deployed a number of HOBO temperature loggers in the Ponderosa grove as well as near an adjacent valley for comparison. 

The loggers were deployed for a few months at a time and then returned to the lab so the data could be downloaded. This resulted in numerous files for each logger.  

Your final assignment is to work with this data to re-create two of the plots (see below) from their completed project. 

**Setup**  

You will need to load necessary libraries (at a minimum, the `tidyverse`). You will also need to download the final project data from the website. Copy, paste, and run the following code in your assignment.  

```
download.file("https://jpomz.github.io/ENVS396-FA-2024/data/final_project_CMU.zip",
              destfile = "data/final_project.zip")

unzip("data/final_project.zip", exdir = "data/")

```

After running the above code, make sure that:  
* you have a folder called `final_project_CMU` and that this folder is *inside* of your `data/` folder  
* Inside of `final_project_CMU` you should have a file called `HOBO_file_metadata.csv` as well as a folder called `HOBO_files/`.  
* The `HOBO_files/` folder should have 25 `.csv` files inside of it.  
* The names of the files inside of `HOBO_files/` include the serial number of the HOBO logger (7 digits) and the "part" of the data (the timeframe the logger was deployed).  
* Note that there is only part_2, part_3, or part_4, and not all loggers have all parts (some loggers malfunctioned or were lost in the field).  
* The `HOBO_file_metadata.csv` object has information related to the files in the  `HOBO_files/` folder including relating the filename to the datalogger, and the site information.  

**Assignment**  

Your assignment is to create the following two figures.  
![Figure 1.]({{ site.baseurl }}/exercises/final_fig_01.png)

![Figure 2.]({{ site.baseurl }}/exercises/final_fig_02.png) 

Your assignment script needs to start with the raw data downloaded above and create these two figures. There are multiple ways of getting this accomplished, and you are free to choose your own adventure as long as you end with these figures. You are also free to customize the plots as you wish (i.e., colors, shapes, themes and axis labels). You need to ensure that the figures are interpretable and have reasonable axis labels.  

Below are some things to consider while you're completing your assignment. The following is one suggested workflow but is certainly not the only way to complete this assignment.    
* Look at the format of the files inside of `HOBO_files`  
* The formats are all identical  
* Start with a single file and figure out how to import it in a proper, tidy format  
* Make two vectors, one with just the names of the files in the folder, and one with the full path name of each file.  
* Write a for loop to read in each file and bind the rows together  
  * Make sure to add a column with the filename in it for each file  
  * You should end up with an object that has 69,155 rows and 4 columns  
  
* Import the metadata file and join it with your dataset  
* Separate the site name (either "Ponderosa" or "Valley") into a new column  
* Make the date-time column into the proper format and create new columns with the date components separated  
* Group and summarize the data to make the plots    
  * This will most likely require two different lines of code, one for each plot  
  * You may need to group the data and then combine the columns into a date-format (i.e., `make_date()`).  
  * The first graph requires: `geom_point() + geom_smooth()`  
  * The second graph only uses `geom_smooth()`  
