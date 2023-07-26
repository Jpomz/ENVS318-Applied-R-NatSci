---
layout: page
element: notes
title: First Day Demo
---

* Quickly show some of the sorts of things we'll be able to do by the end of the
  course
* Use data from the National Ecological Observation Network NEON
* Continental scale science project where systematic, quantitative data is collected repeatedly through time
* Look at how the number of species at a site responds to environmental factors
* We only have a few minutes, so I'm going to move quickly and use tools you
  won't have installed yet, so this is the one day of the course where I won't
  encourage you to code along with me.
* The goal today isn't to understand everything, it's to see where we're going.

### Demo

* First we need to load some packages to leverage code that others have written
  to make our lives easier

```
library(tidyverse)
library(maps)
```

* Download [neon-stream data]({{ site.baseurl }}/materials/datasets/) from the course website

* Load data

```
bugs <- read_csv("data/neon-stream-macros.csv")
sites <- read_csv("data/neon-stream-information.csv")
```

* Once we've done this we can use tables in the database in R


* *Show tables*
* `bugs`: data on how many individuals of each size class (dr weight, `dw`) for each species are sampled at each site
* `sites`: information on where each site is and its mean annual temperature in C (`mat.c`)

* First, let's convert the `bugs` data into total biomass at each site

```
biomass <- bugs %>%
  mutate(biomass = estimatedTotalCount * dw) %>%
  group_by(siteID) %>%
  summarise(tot_b = sum(biomass))
```

* Combine our site data with our species richness data

```
biomass_env <- inner_join(biomass, sites)
```

* Let's see where our sites are located
* first need to load base-map data

```
world <- map_data("world")
states <- map_data("state")

ggplot() +
  geom_polygon(data = world,
               aes(x = long, 
               y = lat, 
               group = group),
               color = "white",
               fill = "gray") +
  geom_polygon(data = states,
               aes(x = long,
                   y = lat,
                   group = group),
               color = "white",
               fill = "grey") +
  coord_quickmap(ylim = c(18,70),
                 xlim = c(-160,-50)) +
  theme_void()
```

* Now we can plot our sites over the map

```
ggplot() +
  geom_polygon(data = world,
               aes(x = long, y = lat, group = group),
               color = "white",
               fill = "gray") +
  geom_polygon(data = states,
               aes(x = long,
                   y = lat,
                   group = group),
               color = "white",
               fill = "grey") +
  coord_quickmap(ylim = c(18,70),
                 xlim = c(-160,-50)) +
  geom_point(data = rich_env,
             aes(x = longitude,
                 y = latitude),
             size = 4) +
  theme_void()
```

* Let's add color to the sites to show the mean annual temperature

```
ggplot() +
  geom_polygon(data = world,
               aes(x = long, y = lat, group = group),
               color = "white",
               fill = "gray") +
  geom_polygon(data = states,
               aes(x = long,
                   y = lat,
                   group = group),
               color = "white",
               fill = "grey") +
  coord_quickmap(ylim = c(18,70),
                 xlim = c(-160,-50)) +
  geom_point(data = rich_env,
             aes(x = longitude,
                 y = latitude,
                 color = mat.c),
             size = 4) +
  scale_color_viridis_c(option = "plasma") +
  theme_void()

```


* Now let's see how biomass relates to the mean annual temperature
```
ggplot(biomass_env,
       aes(x = mat.c,
           y = t_b)) +
  geom_point()
```

* Note the scale on the y-axis
* let's put it on the log10 scale

```
ggplot(biomass_env,
       aes(x = mat.c,
           y = t_b)) +
  geom_point() +
  scale_y_log10()
```

* It looks like there's a pattern here, so let's fit a linear model to it
* we will also change the theme to be easier to view

```
ggplot(biomass_env,
       aes(x = mat.c,
           y = t_b)) +
  geom_point() +
  scale_y_log10()+
  stat_smooth(method = "lm") +
  theme_bw()
```

* Look like total biomass on the log~10~ scale increases with temperature
* This could help us with management decisions for fisheries
  * i.e., "colder" sites have less biomass, so may not be able to support large fish biomass
