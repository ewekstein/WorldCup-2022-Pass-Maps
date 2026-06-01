# ---- Libraries ----
library(StatsBombR)
library(SBpitch)
library(ggplot2)
library(tidyverse)
library(cowplot)
library(jsonlite)

# ---- Get Data ----
wc2022 <- FreeCompetitions() %>%
  filter(competition_name == "FIFA World Cup", season_name == "2022")

wc2022_matches <- FreeMatches(wc2022)

final_events <- fromJSON(
  "https://raw.githubusercontent.com/statsbomb/open-data/master/data/events/3869685.json",
  flatten = TRUE
)

# ---- Filter Completed Passes & Extract Coordinates ----
passes <- final_events %>%
  filter(type.name == "Pass", is.na(pass.outcome.name)) %>%
  mutate(
    pass_end_x = sapply(pass.end_location, function(l) l[1]),
    pass_end_y = 80 - sapply(pass.end_location, function(l) l[2])
  )

argentina <- passes %>% filter(team.name == "Argentina")
france <- passes %>% filter(team.name == "France")

# ---- Extract Goal Locations ----
goals <- final_events %>%
  filter(type.name == "Shot", shot.outcome.name == "Goal") %>%
  mutate(
    x = sapply(location, function(l) l[1]),
    y = 80 - sapply(location, function(l) l[2])
  )

argentina_goals <- goals %>% filter(team.name == "Argentina")
france_goals <- goals %>% filter(team.name == "France")

# ---- Team Color Palettes ----
argentina_palette <- colorRampPalette(c("#FFFFFF", "#74ACDF", "#003087"))(10)
france_palette <- colorRampPalette(c("#002395", "#FFFFFF", "#EF0107"))(10)

# ---- Argentina Plot ----
p_argentina <- create_Pitch(grass_colour = "gray15", background_colour = "gray15", line_colour = "white") +
  geom_density_2d_filled(data = argentina,
                         aes(x = pass_end_x, y = pass_end_y, fill = after_stat(level)),
                         alpha = .4, contour_var = "ndensity",
                         breaks = seq(0.1, 1.0, length.out = 10)) +
  geom_point(data = argentina_goals, aes(x = x, y = y),
             color = "white", fill = "#74ACDF",
             size = 4, shape = 21, stroke = 1.5) +
  annotate("point", x = 3, y = 4, size = 4, shape = 21,
           color = "white", fill = "#74ACDF", stroke = 1.5) +
  annotate("text", x = 5.5, y = 4, label = "= Goal", color = "white",
           size = 3, hjust = 0, family = "Comic Sans MS", fontface = "bold") +
  coord_fixed(ratio = 1) +
  scale_x_continuous(limits = c(0, 120)) +
  scale_y_continuous(limits = c(0, 80)) +
  scale_fill_manual(values = argentina_palette, aesthetics = c("fill", "color")) +
  theme(legend.position = "none",
        plot.background = element_rect(colour = "gray15", fill = "gray15"),
        plot.margin = margin(t = 25, r = 10, b = 20, l = 10),
        plot.title = element_text(color = "white", hjust = .5, size = 22,
                                  family = "Comic Sans MS", face = "bold"),
        plot.subtitle = element_text(color = "white", hjust = .5, size = 10,
                                     family = "Comic Sans MS", face = "bold"),
        plot.caption = element_text(color = "white", hjust = .5, size = 8,
                                    family = "Comic Sans MS", face = "bold")) +
  labs(title = "Argentina Pass Reception Map",
       subtitle = "2022 World Cup Final vs. France",
       caption = paste("Data: StatsBomb | Total Completed Passes:", nrow(argentina)))

# ---- France Plot ----
p_france <- create_Pitch(grass_colour = "gray15", background_colour = "gray15", line_colour = "white") +
  geom_density_2d_filled(data = france,
                         aes(x = pass_end_x, y = pass_end_y, fill = after_stat(level)),
                         alpha = .4, contour_var = "ndensity",
                         breaks = seq(0.1, 1.0, length.out = 10)) +
  geom_point(data = france_goals, aes(x = x, y = y),
             color = "white", fill = "#EF0107",
             size = 4, shape = 21, stroke = 1.5) +
  annotate("point", x = 3, y = 4, size = 4, shape = 21,
           color = "white", fill = "#EF0107", stroke = 1.5) +
  annotate("text", x = 5.5, y = 4, label = "= Goal", color = "white",
           size = 3, hjust = 0, family = "Comic Sans MS", fontface = "bold") +
  coord_fixed(ratio = 1) +
  scale_x_continuous(limits = c(0, 120)) +
  scale_y_continuous(limits = c(0, 80)) +
  scale_fill_manual(values = france_palette, aesthetics = c("fill", "color")) +
  theme(legend.position = "none",
        plot.background = element_rect(colour = "gray15", fill = "gray15"),
        plot.margin = margin(t = 25, r = 10, b = 20, l = 10),
        plot.title = element_text(color = "white", hjust = .5, size = 22,
                                  family = "Comic Sans MS", face = "bold"),
        plot.subtitle = element_text(color = "white", hjust = .5, size = 10,
                                     family = "Comic Sans MS", face = "bold"),
        plot.caption = element_text(color = "white", hjust = .5, size = 8,
                                    family = "Comic Sans MS", face = "bold")) +
  labs(title = "France Pass Reception Map",
       subtitle = "2022 World Cup Final vs. Argentina",
       caption = paste("Data: StatsBomb | Total Completed Passes:", nrow(france)))

# ---- Display & Save ----
ggdraw(p_argentina) + theme(plot.background = element_rect(fill = "gray15", color = NA))
ggsave("Argentina_PassMap.png", height = 8, width = 12, dpi = 300)

ggdraw(p_france) + theme(plot.background = element_rect(fill = "gray15", color = NA))
ggsave("France_PassMap.png", height = 8, width = 12, dpi = 300)
