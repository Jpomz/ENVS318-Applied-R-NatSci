library(tidyverse)
library(maps)

bugs <- read_csv("data/neon-stream-macros.csv")
sites <- read_csv("data/neon-stream-information.csv")

biomass <- bugs %>%
  mutate(biomass = estimatedTotalCount * dw) %>%
  group_by(siteID) %>%
  summarise(tot_b = sum(biomass))

biomass_env <- inner_join(biomass, sites)

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
  geom_point(data = biomass_env,
             aes(x = longitude,
                 y = latitude),
             size = 4) +
  theme_void()

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
  geom_point(data = biomass_env,
             aes(x = longitude,
                 y = latitude,
                 color = mat.c),
             size = 4) +
  scale_color_viridis_c(option = "plasma") +
  theme_void()


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
  geom_point(data = biomass_env,
             aes(x = longitude,
                 y = latitude,
                 fill = mat.c,
                 size = log10(tot_b)),
             shape = 21, 
             alpha = 0.75,
             color = "black") +
  scale_fill_viridis_c(option = "plasma") +
  theme_void()

ggplot(biomass_env,
       aes(x = mat.c,
           y = tot_b)) +
  geom_point()

ggplot(biomass_env,
       aes(x = mat.c,
           y = tot_b)) +
  geom_point() +
  scale_y_log10()

ggplot(biomass_env,
       aes(x = mat.c,
           y = tot_b)) +
  geom_point() +
  scale_y_log10()+
  stat_smooth(method = "lm") +
  theme_bw()
