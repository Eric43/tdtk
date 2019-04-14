---
title: "TDTK-package overview" 
author: "Name"
date: "Date"
output: html_document: default
---


# Overview of Trauma Director Tool Kit

## tdtk-package

	
## Markdown


Originally this is an R Markdown document. Markdown is a simple
formatting syntax for authoring HTML, PDF, and MS Word documents. For
more details on using R Markdown see <http://rmarkdown.rstudio.com>.



```{r, Librarys, include = FALSE, knitr::opts_chunk$set(echo = TRUE)}

library(tidyverse)
library(lubridate)e geocodeded zipcode data

trauma.zip <- merge(TraumaPtsByZipCode, zipcode, by='zip')

#### Visualizing the data set

head(trauma_data, n = 4)

```

The above code chunk shows how the data set is changed in the
tdtk_read().  Although the use of this allow for the user to see how
and what columns are modified. In the blinded versions, trans-mutate
instead of mutate is used to replace the columns containing sensitive
health information.   To read and clean the data in an easy
way direct tdtk call can be made.  The blind is set to false and this
call is meant for the medical professional that does not require full
blinded data.

# NOTE: need to do correct call names may have changed

```{r, tdtk read & clean function calls}

trauma_data <- read_tdtk(file = "<insert path and file name>",
                         blind = FALSE,
                         clean = TRUE)

head(trauma_data, n = 4)

```


# Part 2. Summary Statistics

## Text/Column summary statistics

The goal of these statistics are to provide a basic text column
summary statistics for a quick overview.  This should provide an
overall summary of the patient population (i.e. Injury severity, age,
Injury Mechanism) as either an average, median, IQR or whatever the
medical professional chooses.  The use of averages can be skewed due
to large.  An example of this can be seen in the linear modeling
section.  A few patients with high injury scores (moralities) and low length of
stay can leverage the model to an overall lower LOS.  This could lead
to administrative decisions based on averages that may not be accurate
for the living patients.

### Summary by county

```{r table sourted by county, mechanism and serverity}


ISS_grp <- trauma.zip %>%
              group_by(County, ICD_10grp, ISS_cat) %>%
              summarise("N" = n(), "Avg.Age" = mean(Age), "Avg.ISS"=mean(ISS))%>%
              arrange(desc(N))

knitr::kable(ISS_grp, digits = 2)
```


## Graphical summary statistics

The goal of summary statistics is to quickly give the medical
professional a summary of the data as well as the potential to look
for areas that may differ from expert expectations.  This can be
displayed as a text summary, standard bar graph or a summary scatter
plot.  The goal of the county summary data plot is to provide the
trauma doctor and injury prevention coordinator a rapid display of
injury distributions across age and severity.  These are currently
static plots but can be used to look for the correlating county in the
data.  If useful for injury prevention, 

### Summary of county data

```{r plot of county summary with overal ACS adult age demarkations}

ggplot(ISS.grp, aes(x=Avg.Age, y=Avg.ISS, size=N, color= ICD_10grp))+
    ylab("Low to high average severity")+
    xlab("Average Age of County Subgroup")+
    geom_point()+
    theme_bw()+ 
    theme(panel.border = element_blank(), panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
    geom_hline(yintercept = 10)+
    geom_vline(xintercept = c(13,65))+
    annotate(geom ="text",x=6, y=20, angle = 90, label = "Pediatric Trauma", color = "Maroon")+
    annotate(geom = "text", x = 75, y = 20, angle = 90,  label = "Geriatric Trauma", color = "Violet")+
    scale_colour_brewer(palette = "Set1")
```



# Part 3. Geo-spatial statistics


## Geocoding the hospital data

Setting the google api is first as the easiest way to obtain a map
with set zoom values.  If you do not have a google api registered
account, using google's api is not possible and an Open
Source Map should be used.  This will require a bit more calculation
using the osm_bb() (open street map bounding box) function to set the
upper right and lower left corners of the OSM map call.

### Setting the coordinates of the hospitals

```{r, hospital geocoding with google, echo=FALSE}
# Geocoding the Hospital

HVMC <- geocode("Holston Valley Medical Center", source = "osm")


JCMC <- geocode("Johsnon City Medical Center", source="google")
BRMC <- geocode("Bristol Regional Medical Center", source="google")


```

### Open Street Maps

#NOTE: Need to write osm_bb() to calculate the bounding box from
determining the hypotenuses as the radius for 45 deg and 235 deg and
use geosphere destpoint to determine the lon, lat for upper right and
bottom left bounding box.  Need to determine if it will be square or
a certain ratio with landscape or portrait being selections.

```{r, hospital geocoding (?) with OSM}


```


### Obtaining the maps 

```{r getting the maps, echo=FALSE}

#Pair down to the minimum per hospital


map.8 <- get_map(location = HVMC,zoom=8,maptype = 'terrain',source = 'google',color = 'color')

map.10 <- get_map(location = HVMC, zoom=10,maptype = 'toner',source = 'stamen')

HVMC.stamen.map <- get_map(location = HVMC, zoom= 8, maptype = "toner", source = "stamen")

```




### Mapping the data

```{r map of full cohort}
ggmap(map.8) +
  geom_point(aes(x=longitude,y=latitude,color = ICD_10grp,
                 size=ISS) 
             ,data=trauma.zip
             ,na.rm = T
             ,position = position_jitter(w=0.5, h=0.5)
             ,alpha = 0.4
  ) +
  scale_colour_brewer(palette = "Set1")
```





##### Top 3 
```{r}

top.three <- filter(trauma.zip, ICD_10grp=="Fall"|ICD_10grp=="MVT"|ICD_10grp=="FARI")


ggmap(map.8) +
  geom_point(aes(x=longitude,y=latitude, size=ISS)
             ,data=top.three
             ,na.rm = T
             ,position = position_jitter(w=0.5, h=0.5)
             ,alpha = 0.20
             ,color="slateblue1"
  )+
    facet_wrap(~ ICD_10grp)


```

```{r}

ggmap(map.10) +
  geom_point(aes(x=longitude,y=latitude
                 ,color = ISS_cat)
             ,data=trauma.zip
             ,na.rm = T
             ,size = 1
             ,position = position_jitter(w=0.5, h=0.5)
             ,alpha = 1
  ) 

```

```{r}
ggmap(map.8) +
  geom_point(aes(x=longitude,y=latitude)
             ,data=trauma.zip
             ,na.rm = T
             ,size = 1
             ,position = position_jitter(w=0.5, h=0.5)
             ,alpha = 0.50
             ,color="Yellow"
  )+
    facet_wrap(~ ISS_cat)

```



```{r}
ggmap(map.8) +
  geom_point(aes(x=longitude,y=latitude, color=ISS)
                ,data=top.three
                ,na.rm = T
                ,size = 1
                ,position = position_jitter(w=.5, h=.5)
                ,alpha = .4
  )+
  facet_grid(~ ICD_10grp)+
  scale_colour_gradient(low = "yellow", high = "red")
  

```

```{r 2d trauma density model full cohort color map}



HVMC_trauma <- ggmap(map.8, base_layer=ggplot(aes(x=longitude,y=latitude), data=trauma.zip))

HVMC_trauma +
  stat_density2d(aes(x=longitude,y=latitude, fill= ..level.., alpha = ..level..), bins = 90, geom = "polygon", data = trauma.zip)+
  scale_fill_gradient(low="blue", high ="yellow")


```


```{r 2d trauma density modeling by ISS levels with black and white map}


new.levels <- (c("mild", "moderate", "severe", "profound", "not determined"))

zip.arrange <- arrange(transform(trauma.zip,ISS_cat=factor(ISS_cat,levels=new.levels)),ISS_cat)

HVMC_trauma <- ggmap(HVMC.stamen.map, base_layer=ggplot(aes(x=longitude,y=latitude), 
                                              data= zip.arrange))



HVMC_trauma +
  stat_density2d(aes(x=longitude,y=latitude, fill= ..level.., alpha = ..level..), bins = 90, geom = "polygon", data = zip.arrange)+
  scale_fill_gradient(low="blue", high ="yellow")+
  facet_wrap(~ ISS_cat)


```


