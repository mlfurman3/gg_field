## libraries only needed for custom colored field designs
library(patchwork)
library(RColorBrewer)

source("scripts/gg_field.R")

## reminders: 
### x-axis goes from 0 (back of left endzone) to 120 (back of right end zone)
### left goal line (x=10), 50-yard line (x=60), right goal line (x=110)
### y-axis goes from 0 to 53.33

##################################################
### Examples of gg_field 
##################################################

## regular field (direction="horiz")
ggplot() + gg_field() 

## vertical field
ggplot() + gg_field(direction="vert") 


## zoomed in on half
ggplot() + gg_field(yardmin=60) 

## decrease/increase sideline buffer (default is 5 yards on each side)
ggplot() + gg_field(buffer=0) 
ggplot() + gg_field(buffer=15) 


## generate random dataset with group labels
df <- data.frame(x=runif(50, 10,110), y=runif(50, min=1, max=53), grp=rep(1:5,each=10))

## adding points to the field
ggplot(data=df, aes(x=x,y=y)) + 
  gg_field() + 
  geom_point(col='gold', cex=2)

## faceted fields! 
ggplot(data=df, aes(x=x,y=y)) + 
  gg_field() + 
  geom_point(col='gold', cex=2) +
  facet_wrap(~grp, labeller = label_both)


## change the field colors (sideline and endzone default to same color as field unless 
## otherwise specified)
ggplot() + gg_field(field_color='gray') 


## adjust sideline and endzone colors
ggplot() + gg_field(endzone_color = 'gold',sideline_color = 'gray') 



## generate 9 fields with random colors from grDevices::colors()
p <- vector("list", 9)
random_cols <- matrix(NA, nr=9, nc=4)

for(i in 1:9){
  random_cols[i,] <- sample(colors(), 4, replace=F)  
  p[[i]] <- ggplot() + gg_field(field_color = random_cols[i,1], 
                                line_color  = random_cols[i,2], 
                                endzone_color = random_cols[i,3],
                                sideline_color = random_cols[i,4]) 
  
}

## patchwork package allows for easy combining of separate ggplots :)
(p[[1]] + p[[2]] + p[[3]]) / (p[[4]] + p[[5]] + p[[6]]) / (p[[7]] + p[[8]] + p[[9]])


## generate 9 fields using RColorBrewer palettes
pal_vec <- c('Reds','Blues','Purples', 'Oranges','Greens','Greys','YlOrRd','PuBuGn','YlGnBu')


for(i in 1:9){
  
  ## ordered from lightest to darkest
  tmp_cols <- RColorBrewer::brewer.pal(4, pal_vec[i])
  
  p[[i]] <- ggplot() + 
              ## assign lightest color to field, darkest to lines
              gg_field(field_color    = tmp_cols[1], 
                       sideline_color = tmp_cols[2],
                       endzone_color  = tmp_cols[3],
                       line_color     = tmp_cols[4]) + 
              ggtitle(paste0('RColorBrewer::',pal_vec[i]))
  
}

(p[[1]] + p[[2]] + p[[3]]) / (p[[4]] + p[[5]] + p[[6]]) / (p[[7]] + p[[8]] + p[[9]])
