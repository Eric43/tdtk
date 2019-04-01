---
title: "TDTK-package overview" 
author: "Name"
date: "Date"
output: html_document: default
---


# Part I.  Overview of Trauma Director Tool Kit

## tdtk-package

	
## Markdown


Originally this is an R Markdown document. Markdown is a simple
formatting syntax for authoring HTML, PDF, and MS Word documents. For
more details on using R Markdown see <http://rmarkdown.rstudio.com>.



```{r, Librarys, include = FALSE, knitr::opts_chunk$set(echo = TRUE)}

library(tidyverse)
library(lubridate)
library(ggmap)
library(knitr) ## See if included in tidyverse

                                        #ibrary(tdtk)

```

The above library's are the basic part of starting the tdtk.  Several
different packages within tidyverse are needed by the package as well
as the reports.  The R-core is version 3.4.4 with ESS, EMACS.  The R
packages used were: (REFS).


```{r, Loading tdtk-package, include = FALSE}

library(devtools)

## Need to OAuth the tdtk-package api for github

install_github("Eric43/tdtk", subdir = "package")

```

## Loading the data

Once the basic library's are installed the next step is to load the
data.  Depending on how the data is loaded (i.e. using readr or
tdtk_read()), the calls will be differnt.  However the overall goal is
the same or to get the  data into a varible called "trauma data".

Some basic housekeeping.  The overall goal of this project is to
follow standardize naming, therefore, column names will begin with a
capitalized letter.  On the other hand, varibles, functions and
constants will be all lower case (unless absolutely necessary).  In
keeping with python scripting and other OOP languages, the use of "."
will be avoided in all naming conventions and replaced by underscore
"_" or dash "-".

In the load data section (below) Make sure to use to correct file
path or an error will occur.  Check on the age group since some will
export days or months for pediatric patients and will need to be
converted to years.

```{r, load data, echo=FALSE}

col_names <- c("Age", 
               "ISS", 
               "ICD_10_txt", 
               "County", 
               "State",
               "Zip",
               "ER_Disp",
               "Disp_Des",
               "Disp_Des_S",
               "Dis_Fac")

trauma_data <- read_csv("~/Desktop/Trauma Project Folder/TraumaPtsByZipCode.csv", 
                        skip=1, #skip set to 1 to avoid column names in row 1
                        col_names = col_names) #set column names to above varible)


head(trauma_data, n = 4)

```
The above should be showing the first four records of the
"trauma_data" data frame.  This data frame contains the data necessary
for a nearly coplete analysis by the medical professional but requres
additional "cleaning" (i.e. in tidyvers "tidying") and potential
blinding of the data.  At this point its good to decide what are:

1.  Goals of the research
	- Trauma director.
	- Internal Report.
	- Verivicatoin of PHI removal prior to data scientist use.
	- Partial blinding for specific uses.
	- Full blinding for very low probabilty of reidentification.
2.  Final use of the data
	- Summary statisics 
	- Geo spatial
	- Classical machine learning and neural network/advanced
      simulations
3.  Type of figures needed

There is no need for extra use/data processing.  If you are not doing
travel time analysis or neural network modeling, there is little need
to attempt to model ever travel time and transfer.  However, if you
are doing only the more advanced slightly 'lernt machine analysis the
entire data set will have to be processed completly to minimize
records with NA's or missing data fields (except where appropriate).
	
## Reading, cleaning and preparing the data set.

After loading the data, the data needs a few columns added to make
later anaysis easier.  This can be done manually or part of a function
if using standarized registary data.This section prepares that data
set for analysis.  Several steps are involve including: (i) removing
all records with NA's in essential fields, (ii) extracting/converting
date information to allow for easier grouping, (iii)
cleaning/converting of zip code to a numeric value, (iv)
cleaning/converting age to years (i.e. days and months to years), (v)
grouping by injury severity score (REF), (vi) catogorizing inital
dispensation, (vii) grouping by ICD-10 description and finally (viii)
merging with zip code data base for geocoding information.  This is
the intial trauma data set post-tidying and ready for basic summary
and geo-spatial statistics.

NOTE: Rewrite using pipes

# Add to notes for R install and install.packages

I kept getting total fail for zero sum or something like that in the R
install.packages().  To get it to work I install the following as per
the instructions during the failed package install.

```{cmd}

sudo apt install libcurl4-openssl-dev 

sudo apt install libssl-dev 

```

Need to say somthing about the clean up and later use?

```{r, tidy of data}

#### Removing the na's that are present in the arrival date and time.


trauma_data <- trauma_data %>% filter(Reduce(`+`, lapply(., is.na)) != ncol(.))


trauma_data$Arr.Date.Time <-mdy_hm(trauma_data$Arr.Date.Time, tz = "EST")


#### Adding ISS catagory

trauma_data <- mutate(trauma_data, ISS_cat = map_chr(ISS, ISS.cat)) 

#### Extracting and adding Zip code from chr to numeric

TraumaPtsByZipCode <- mutate(TraumaPtsByZipCode, Zip.num = as.numeric(map_chr(Zip, Zip.clean)))


TraumaPtsByZipCode <- mutate(TraumaPtsByZipCode, zip = extract_numeric(Zip.num))

#Adding ICD_10 grouping (Function need to be written for ICD 10 number too)

TraumaPtsByZipCode <- mutate(TraumaPtsByZipCode, ICD_10grp = map_chr(ICD_10_txt, ICD_10.cat)) 

#### Adding Dispensation based upon intial ER visit

TraumaPtsByZipCode <- mutate(TraumaPtsByZipCode, Initial_disp = map_chr(ER_Disp, Disp.cat))

#### Merging the geocodeded zipcode data

trauma.zip <- merge(TraumaPtsByZipCode, zipcode, by='zip')

#### Visualizing the data set

head(trauma_data, n = 4)

```

The above code chunk shows how the data set is changed in the
tdtk_read().  Although the use of this allow for the user to see how
and what columns are modified. In the blinded versions, transmutate
instead of mutate is used to replace the columns containing sensitive
health information.   To read and clean the data in an easy
way dirct tdtk call can be made.  The blind is set to false and this
call is meant for the medical professional that does not requie full
blinded data.

```{r, tdtk read & clean function calls}

trauma_data <- read_tdtk(file = "<insert path and file name>",
                         blind = FALSE,
                         clean = TRUE)

head(trauma_data, n = 4)

```


# Part 2. Summary Statistics

## Text/Column summary statistics

### Summary by county

```{r table sourted by county, mechanism and serverity}


ISS_grp <- trauma.zip %>%
              group_by(County, ICD_10grp, ISS_cat) %>%
              summarise("N" = n(), "Avg.Age" = mean(Age), "Avg.ISS"=mean(ISS))%>%
              arrange(desc(N))

knitr::kable(ISS_grp, digits = 2)
```


## Graphical summary statistcs

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
with set zoom values.  If you do not have a google api registerd
account, usoing google's api is not possible and an Open
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
determining the hypotonuse as the radiuse for 45 deg and 235 deg and
use geosphere destpoint to determine the lon, lat for upper right and
bottom left bounding box.  Need to determine if it will be squeare or
a certian ratio with landscape or portrait being selections.

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

