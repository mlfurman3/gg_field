
library(tidyverse)
library(ggimage)
library(nflfastR)

source("gg_field.R")

gg_field_team <- function(team, name_color=NULL){
  
  ## filter to 1 team
  df_team <- nflfastR::teams_colors_logos %>% 
    filter(team_name == team | team_nick == team | team_abbr == team) 
  
  ## pull primary and secondary colors
  prm <- df_team %>% pull(team_color)
  sec <- df_team %>% pull(team_color2)
  
  ## color for team name
  name_color <- ifelse(is.null(name_color), prm, name_color)
  
  ## plot object
  p <- df_team %>%
    ggplot() + gg_field(endzone_color = prm, sideline_color=sec) + 
    ggimage::geom_image(aes(x=60, y=53.33/2,
                            image = team_logo_wikipedia),size=0.13) +
    geom_text(aes(x=60, y=53.33+3, label=team_name),
              col=name_color, fontface='bold', size=6)
  
  return(p)
}

## can pass multiple arguments
gg_field_team('CAR')
gg_field_team('Panthers')
gg_field_team('Carolina Panthers')

## change name color
gg_field_team('NYJ', name_color='white')

## use third team color for Arizona Cardinals
data("teams_colors_logos")

alt_color <- team_colors_logos %>% 
                filter(team_abbr=='ARI') %>% 
                pull(team_color3)

gg_field_team('ARI', name_color=alt_color)
