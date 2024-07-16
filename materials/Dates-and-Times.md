---
layout: page
element: notes
title: Dates and Times
language: R
---

## Handling Dates and Times in R

### Written notes (may vary slightly from video in details, but main content is the same)

If you are working with data, what are the different ways you could write today's date? If it is always the same order of information (month, day, year). Are those pieces of information always given in the same way (always numerical?).

> Write down the different ways you can think of recording a date

* What are some issues you see with these formats?  
* How do you think a computer would see these different styles for dates?  
* As the same thing? Or as different things?   
* How would it know what is a day or month or year?  

We're going to explore today what the challenge is for communicating dates and times to computers and learn to use some tools that will make it easier for us to tell the computer what we want in a way that lets both it and us interpret date-times accurately.

* First, we need to load the `tidyverse` which includes two packages that we will be focusing on today.  
* `ggplot` for making graphs and  
* `lubridate` which has some nice features for working with dates and times. 

```{r}
library(tidyverse)
```

We're going to use some data from a weather station from one of the sites that make up the National Ecological Observatory Network (NEON). Let's get that loaded up and make sure everything is working for everyone.  

* download the [NEON Harvard Forest 2001-2006 (link)](https://jpomz.github.io/ENVS396-FA-2024/data/NEON_Harvardforest_date_2001_2006.csv) data and put it in your `data/` folder  

```{r}
daily = read.csv("data/NEON_Harvardforest_date_2001_2006.csv", stringsAsFactors = FALSE)
```  

* This is a subset of a weather data from the Harvard Forest NEON site.  
* Let's look at the data and see what we got:

```{r}
head(daily)
```

* We have 2 columns  
* a `date` column, and an  
* `airt` column which is daily mean air temperature from 2001 through 2006.

* Does anyone have a date that doesn't match mine?  
* Sometimes this will happen if you open the file and save in Excel.  
* Dates in excel are nightmarish.  
* Excel has its own date formats.  
* ISO international is not a default  

* Remember what they say:  

> Abandon all hope, ye who enter dates in Excel  


* Let's see what the computer thinks this date is.

```{r}
class(daily$date)
```

* R reads this in as `character` data.  
* These could be names of species, sites, whatever, it will treat dates just like any other character data that we would give it.

```{r}
head(daily$date)
```

* Each date is an arbitrary label  
* Because of that, R does not know about any relationships that exist between these. 

* If the date format was day-month year (e.g. 01-01-2016) R would sort it numerically  
* all the January's together, then all the January 1's together, then all the january 1's by year  

* Let's try dates in one of the formats we brainstormed at the beginning that we commonly use in the United States: Month Day Year 

```{r}
US_dates = c("01-16-2015", "12-16-2015", "07-16-2014", "01-16-2023")
sort(US_dates)
```

* Note that this is **NOT** in chronological order  

* How was the date formatted in the NEON data?  
* How would those date formats sort? 

* The format used in the NEON data is called the ISO international date format.  
* Information is presented from largest (year) to smallest (second)  
* The order the information is presented avoids this problem, the computer will sort first on year, then month, then day, just like we would want.  

* let's look at the data we have from NEON by making a plot of temperature through time  
* x = `date`  
* y = `airt`  


```{r}
ggplot(daily,
        aes(x = date,
            y = airt)) + 
  geom_point()
```

* Anything look odd or annoying? 

* *x-axis*

* What if I told you this file had no observations from 2005?  
* Could you tell from the graph?  

* Why isn't the gap showing up?

* **the computer doesn't know anything is missing**

* The computer doesn't know that dates are special.  
* It doesn't understand that they come in a specific order.  
* It doesn't understand their relationship to each other.  
* Remember  

> Computers are very powerful but very dumb  

* To understand dates, the computer needs to store information in a special format and we need to tell it to do that.  
* R has a `date` format which we can create by using `as.Date()`.  
* `as.Date()` stores the information in such a way that it knows what humans want the dates to do but in a way that the computer understand it.  
* We're going to start by using `as.Date()` which is part of Base R and not part of the `lubridate` package.  
* It's a little clunkier but will help illustrate some concepts.

* Let's see how `as.Date()` changes how our dates.

```{r}
daily$asdate.date = as.Date(daily$date)
head(daily$asdate.date)

```

* It looks like the computer is storing the information in the same way, as a `character` class.  
* Let's use `class()` to see what type of data the computer thinks this is now:

```{r}
class(daily$asdate.date)
```

* Now let's plot this:

```{r}
ggplot(daily, 
  aes(x=asdate.date,
      y=airt)) +
  geom_point() +
  labs(title = "Daily Air Temperature",
  x = "Date",
  y = "Air Temperature") +
  theme_bw()
```

* Now we see missing year.  
* R now knows that December 31 of 2004 is 1 year away from January 1 2006 and that it should space those data points accordingly.  

* And what happened to the x-axis?

* `as.date()` assumes that data is already in the ISO international data format.  
* This is why we didn't have to tell `as.Date()` what the year was and what the month was.  
* But what if our date is set up differently?

```{r}
test_date = "07-28-1977"
as.Date(test_date)

```

> Error in charToDate(x) : 
  character string is not in a standard unambiguous format

* `as.Date()` can read other formats, we just have to tell it what we're giving it.  

%d = day of month
%m = numeric month
%b = abbreviated month name
%B = full month name
%y = two digit year
%Y = 4 digit year


* What is the format of our `test_date`?  
* which of the above codes will we need?  

```{r}
as.Date(test_date, format = "%m-%d-%Y")
```

* Because R now knows that the dates are and their relationship between each other, you can do things like ask R to tell you the difference between two adjacent values in your date column.

```{r}
diff.dates = diff(daily$asdate.date)
head(diff.dates)
```

* This is something I've done when I need to know if samples are more than some period of time apart to find gaps in my data collection.

* You can also filter your data based on dates and have it behave as you think it should.

```{r}
dim(daily)
daily |> 
  as_tibble() |>
  filter(asdate.date > "2004-12-31")

```

* The full data object has 1785 rows, and the filtered data set only has 365 - one year of daily observations in 2006  

* If you have automated data, like from a sensor or weather station, you may also have a time associated with your date.   
* Let's look at the higher frequency data from the NEON site.

```{r}
quarterhour = read.csv("data/NEON_Harvardforest_datetime.csv", stringsAsFactors = FALSE)
head(quarterhour)
```

Let's see what `as.Date()` does with this format.

#### Class Activity

* Run the `as.Date()` function on that column like we did for the other data.  
* How did it store the time information?

```{r}
asDate_datetime = as.Date(quarterhour$datetime)
head(asDate_datetime)
class(asDate_datetime)

```

* It didn't store the time information.  
* `as.Date()` is only for dates and has pretty basic functionality.  
* This is where we're going to hop over the `lubridate` package.  
* `lubridate` is a handy package that is designed to make working with dates and times easier.  

* You can do everything we just did with `as.Date()` in `lubridate`, but it works slightly differently.  
* Instead of using one function and then telling it what order the information is in, there are different functions that assume different orders of information. 

```{r}
output = lubridate::mdy("3-15-2001")
output
class(output)

```
Or

```{r}
date_02 = lubridate::dmy("16-1-1980")
date_02
```

* If we have time as well as date information, we simply add that information in the order that it is presented.

```{r}
timeDate <- lubridate::ymd_hm("2015-10-19 10:15")
class(timeDate)
```

* `POSIXct` and `POSIXt` is a different type of object and is the format for date-time observations.   

* Let's see what this `POSIXct` object looks like:

```{r}
timeDate

```

* This looks pretty similar to what we gave it, because we gave it a format that it is expecting.  
* The one difference is the addition of the timezone.

* To see how `POSIXct` deals with your date and time, let's pull out the underlying info:

```{r}
unclass(timeDate)
```

* This is the number of seconds since January 1 1970.  
* The computer doesn't understand dates the way we do  
* The computer stores the information in a way that it can work with in the way we want it to be dealt with.  
* These different functions (`as.Date()` and `ymd_hm()`)  have ways of converting that into what we expect to see.  
* Here's what we have if we look under the hood at the 

```{r}
unclass(date_02)
```
This is the number of days since 1/1/1970.

#### CLASS ACTIVITY - 

* Convert the `datetime` column in our NEON object (`quarterhour`) to `POSIXct` format using `lubridate`. Look at the data object and see what order the date time is given, then use the appropriate `lubridate` function.

```{r}
neon_datetime <- quarterhour %>%
  mutate(datetime = ymd_hm(datetime))

class(neon_datetime$datetime)
```

* Now you have the power to convert whatever datetimes into a format your computer can work with and recognize as a date.

#### Fun with Lubridate 

* `lubridate` just generally makes working with dates less terrible.  
* It is capable of auto-detecting lots of different date formats and extracting the relevant information:


```{r}
nightmare_date = dmy("4th of July 1999")
two_digit_year = dmy("4-7-99")
nightmare_date
two_digit_year
```
You can extract parts of a date:

```{r}
nightmare_year <- year(nightmare_date)
nightmare_month <- month(nightmare_date)
nightmare_day <- day(nightmare_date)
nightmare_year
nightmare_month
nightmare_day
```

You can also make a date out of different components  
```
make_date(nightmare_year, nightmare_month, nightmare_day)
```

* You can have the computer tell you what today's date is  

```
Sys.Date()
```

* and you can have the computer tell you the current date and time  

```{r}
today = now()
today
```
And have it tell you what day of the week a date is/was

```{r}
wday(today)
```

* You can see what the "Julian" day is (number of days into the year)  

```
yday(today)
```

You can do math with dates:

```{r}
today - dmy_hm("21-07-2002 0:00")
```

[End of Tutorial]


```
