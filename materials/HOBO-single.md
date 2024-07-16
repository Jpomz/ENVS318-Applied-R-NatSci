---
layout: page
element: notes
title: HOBO Temperature Data
language: R
---

### HOBO data loggers  

* Working with tidy data has many advantages  
* Unfortunately, real data is not always in a tidy format  
* Today we will be working with HOBO temperature logger data  

#### Setup  

* Load the `tidyverse`  
* Download the [`HOBO-short.csv (link)`](https://jpomz.github.io/ENVS396-FA-2024/data/HOBO-short.csv) file and put it in your `data/` folder  

```
library(tidyverse)
```

### Data file formatting  

* Let's first read the file in as normal  

```
hobo_orig <- read.csv("data/HOBO-short.csv")
head(hobo_orig)
```

* This looks like a mess!  
* Open the file using spreadsheet software like Microsoft Excel or Google Sheets  
* Make sure to point out the first couple of rows, and the extra columns  

* we can modify `read.csv()` to skip the first few lines  
* Our variable names start in row 3, so we want to `skip = 2` lines  
* We will deal with the extra columns in a minute  

```
hobo <- read.csv("data/HOBO-short.csv", skip = 2)
head(hobo)
```

* we can use the `[,]` notation to subset our `hobo` object  
* We want all the rows and only the first five columns  

```
hobo <- hobo[, 1:5]
head(hobo)
```
> Do [HOBO format 1-3]({{ site.baseurl }}/exercises/HOBO-format-R).

* It's looking better, but let's look at our column names now  
```
names(hobo)
```

* The names are quite long and we don't want to have to type all of that out every time  
* We can easily rename the columns with the following  

```
names(hobo) <- c("observation_number", "hobo_time", "UTC", "Excel_time", "temperature")
```

* note that a "real" file from a HOBO data logger will have slightly different structure  
* Normally, there will only be one date column  
* I added two more data columns as examples and for more practice converting different date-time formats  

### Dates and Times  

* Let's look at the class of our three date-time columns  

```
class(hobo$hobo_time)
class(hobo$UTC)
class(hobo$Excel_time)
```

* All the columns are currently in `"character"` class  
* If we tried to plot these it wouldn't look great  

```
ggplot(hobo,
       aes(x = hobo_time, 
           y = temperature)) +
  geom_point()

```

* In this case it doesn't look terrible, although it is hard to read the x-axis  
* We can rotate the axis labels to help read it:  

```
ggplot(hobo,
       aes(x = hobo_time, 
           y = temperature)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 45,
                                   vjust = 0.7,
                                   hjust = 0.69))
```

* Right now, the date-times are in the correct order, but this is only because there aren't many observations in this toy example  
* The observations are obeying alphabetical rules, and if there were more observations the order would get weird quick  
* We can use functions from `lubridate` (part of the `tidyverse`) to convert these character vectors to date-time format  

* Let's start with the default format that comes in HOBO loggers. 
* the HOBO time has information in the following order: month, day, year, hour, minute  
* We will use the `mdy_hm()` function from `lubridate`

```
hobo %>%
  select(hobo_time) %>%
  mutate(hobo_correct = mdy_hm(hobo_time))
```

* This looks better, the information is now from largest (year) to smallest (minute)  
* We can also check the class to make sure it is correct
```
hobo %>%
  select(hobo_time) %>%
  mutate(hobo_correct = mdy_hm(hobo_time)) %>%
  pull(hobo_correct) %>%
  class
```

* Recall that `POSIXct` and `POSIXt` are the standard date-time formats in R

* We can also convert the other two date-time formats for practice.  
* The information in `Excel_time` is Month, day, year, hour and minute, so we will use the `mdy_hm()` function 

```
hobo %>%
  select(Excel_time) %>%
  mutate(excel_correct = mdy_hm(Excel_time))
```

* This looks correct, and we can check the class just to be sure  

```
hobo %>%
  select(Excel_time) %>%
  mutate(excel_correct = mdy_hm(Excel_time)) %>%
  pull(excel_correct) %>%
  class
```

* Finally, the `UTC` column is already in the correct order (Year, Month, Day, Hour and Minute) but it is in a character class. 
* We can convert it using the `ymd_hm()` function 

```
hobo %>%
  select(UTC)
  mutate(UTC_correct = ymd_hm(UTC))
```

*... and confirm the format  

```
hobo %>%
  select(UTC)
  mutate(UTC_correct = ymd_hm(UTC)) %>%
  pull(UTC_correct) %>%
  class
```
> Do [HOBO format 4-6]({{ site.baseurl }}/exercises/HOBO-format-R).


### Summarizing the data  

* Let's simplify the data object to only have the default HOBO logger time format  
* We will also overwrite the column with the correct date-time format  
* I will also save it as a `tibble()` for ease of future use  

```
hobo2 <- hobo %>%
  select(observation_number,
         hobo_time,
         temperature) %>%
  mutate(hobo_time = mdy_hm(hobo_time)) %>%
  as_tibble()
hobo2
```

* Note that the column classes are listed, and how `<dttm>` formats are displayed in a tibble  

* We want to calculate the monthly mean temperature for this data  
* Currently, we only have a date-time column which has the month information in it  
* It is not possible to group the data by month in the current format  
* We can extract the month information and then group by that new column 
* We will also extract the year and day information

```
hobo2 <- hobo2 %>%
  mutate(year = year(hobo_time),
         month = month(hobo_time),
         day = day(hobo_time))
hobo2
```

* We will now group the data by year, month, and day to calculate the mean and standard deviation  
* In this case, there is only one year of data and only one day so grouping by all three is OK and will make the plotting easier  
* If you had multiple days or years in your data, you would want to carefully consider how to group your data and to format the dates after calculation  

```
hobo_monthly <- hobo2 %>% 
  group_by(year, month, day) %>%
  summarize(monthly_mean = mean(temperature),
            monthly_sd = sd(temperature))
hobo_monthly
```

* Now we have our summary statistics and our date, but the date information is in three separate numeric columns  
* we can use the `make_date()` function from `lubridate` to combine this information back into a date  

```
hobo_monthly <- hobo_monthly %>%
  mutate(date = make_date(year, month, day))
hobo_monthly
```

* Now we can plot our results using `ggplot()`  

```
hobo_monthly %>%
  ggplot(aes(x = date, 
             y = monthly_mean, 
             ymin = monthly_mean - monthly_sd,
             ymax = monthly_mean +monthly_sd)) +
  geom_pointrange()
```

* We can also add color and labels  
* in the y-axis label we want the "plus-minus" sign and we can add it using unicode character: `\u00B1`  

```
hobo_monthly %>%
  ggplot(aes(x = date, 
             y = monthly_mean, 
             ymin = monthly_mean - monthly_sd,
             ymax = monthly_mean +monthly_sd,
             color = date)) +
  geom_pointrange() +
  labs(x = "Date",
       y = "Monthly mean \u00B1 1 SD") +
  theme_bw()
```

* This looks good, but note that the color for date is continuous (black-to-blue shading).  
* We can use distinct colors by adding the `as.factor()` command.  

```
hobo_monthly %>%
  ggplot(aes(x = date, 
             y = monthly_mean, 
             ymin = monthly_mean - monthly_sd,
             ymax = monthly_mean +monthly_sd,
             color = as.factor(date))) +
  geom_pointrange() +
  labs(x = "Date",
       y = "Monthly mean \u00B1 1 SD") +
  theme_bw()
```

* Nice, except now we have a funky legend title  
* we can deal with this by renaming the legend title:

```
hobo_monthly %>%
  ggplot(aes(x = date, 
             y = monthly_mean, 
             ymin = monthly_mean - monthly_sd,
             ymax = monthly_mean +monthly_sd,
             color = as.factor(date))) +
  geom_pointrange() +
  labs(x = "Date",
       y = "Monthly mean \u00B1 1 SD") +
  theme_bw() +
  guides(color=guide_legend(title="Date"))
```

* ... or we can get rid of it since the date is already in the x-axis  

```
hobo_monthly %>%
  ggplot(aes(x = date, 
             y = monthly_mean, 
             ymin = monthly_mean - monthly_sd,
             ymax = monthly_mean +monthly_sd,
             color = as.factor(date))) +
  geom_pointrange() +
  labs(x = "Date",
       y = "Monthly mean \u00B1 1 SD") +
  theme_bw() +
  theme(legend.position = "none")

```

> Do [HOBO format 7-10]({{ site.baseurl }}/exercises/HOBO-format-R).
