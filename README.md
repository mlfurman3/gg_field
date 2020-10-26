
## Introduction

Welcome to gg_field!

Inspired by the NFL's Big Data Bowl, gg_field is a tidy way to incorporate an NFL field into your plotting workflow.

The `gg_field()` function creates a list of `ggplot2` annotations, and it can be added to a `ggplot()` call with a `+` before adding other geom layers. 

## Field Details

The units for this field are in yards. The origin starts at the bottom left of the field, with the x-axis going from 0 (back of left endzone) to 120 (back of right endzone), and the y-axis ranging from 0 (bottom sideline) to 53.33 (top sideline). Other key markers are the left goal line (x=10), 50-yard line (x=60), right goal line (x=110).

Current features: 
  - hash marks every yard, in the middle of the field and along each sideline
  - long yard marks every 5 yards
  - field numbers every 10 yards
  - conversion lines at each 2-yard line

## Basic gg_field


```{r}
source("gg_field.R")
ggplot() + gg_field()
```

![Basic field](img/gg_field_basic.png)

## Vertical Field

```{r }
ggplot() + gg_field(direction="vert")
```
![vertical field](img/gg_field_vertical.png)


## Zooming in on the field

```{r pressure, echo=FALSE}
## right half of field, from 50 yard line to right end zone
ggplot() + gg_field(yardmin=60)
```
![Right half of field](img/gg_field_clip1.png)

```{r pressure, echo=FALSE}
## middle of field, between the two 20-yard lines
ggplot() + gg_field(yardmin=30, yardmax=90)
```
![Middle of field](img/gg_field_clip2.png)

## Sideline Buffer

Defaults to 5 yards on each sideline. Make it larger or smaller to get a different perspective on the field.

```{r pressure, echo=FALSE}
## larger sideline buffer
ggplot() + gg_field(buffer=15)
```

![Large sideline buffer](img/gg_field_buffer.png)


## Adding points to the field

```{r}
## generate random dataset with group labels
df <- data.frame(x=runif(50,10,110), y=runif(50, min=1, max=53), grp=rep(1:5,each=10))

ggplot(data=df, aes(x=x, y=y)) + 
  gg_field() +
  geom_point(col='gold', cex=2)
```
![Adding points to field](img/gg_field_points.png)

## Faceting

```{r}
ggplot(data=df, aes(x=x,y=y)) + 
  gg_field() + 
  geom_point(col='gold', cex=2) +
  facet_wrap(~grp, labeller = label_both)

```
![Facetted field](img/gg_field_facet.png)

## Changing color schemes

```{r}
## adjust all color arguments
ggplot() + 
  gg_field(field_color='white', line_color='black', 
           sideline_color = 'gray', endzone_color='blue') 
```

![Different color scheme](img/gg_field_color1.png)

## Pretty Color Palettes

Think beyond the green field! Using color palettes from packages like `RColorBrewer`, you can create some beautiful field designs.

![RColorBrewer fields](img/gg_field_rcolorbrewer.png)
