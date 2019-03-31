---
title: "Part 1. Loading of Trauma Patient Data"
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



```{r, Librarys, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)

library(tidyverse)
library(lubridate)
library(ggmap)

                                        #ibrary(tdtk)

```
The above librarys are the basic part of starting the tdtk.  Several
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


```{r, load data, echo=FALSE}

#load data Note: path maybe different.  Lood actual data.  Note: Dont
# forget to modify excel .csv so that <1 yr (in months or weeks) is
# calculated as year (i.e. 1 wk old = 1/52 of a year and 6 months is
# 6/12 = 0.5 yr)


col.names <- c("Age", 
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
                        col_names = col.names) #set column names to above varible)


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
	- Machine learning/
	
## Reading, cleaning and preparing the dataset.

This section prepares that data set for analysis.  Several steps are
involve including removing all records with NA's in essential fields.
Next, the data fields are converted to the proper form (lubridate) 


After loading the data, the data needs a few columns added to make
later anaysis easier.  This can be done manually or part of a function
if using standarized registary data.


```{r, tidy of data}

### Removing the na's that are present in the arrival date and time.


# trauma_data$Arr.Date.Time <-mdy_hm(trauma_data$Arr.Date.Time, tz = "EST")
# trauma_data <- trauma_data %>% filter(Reduce(`+`, lapply(., is.na)) != ncol(.))


#Adding ISS catagory

trauma_data <- mutate(trauma_data, ISS_cat = map_chr(ISS, ISS.cat)) 

#Extracting and adding Zip code from chr to numeric

TraumaPtsByZipCode <- mutate(TraumaPtsByZipCode, Zip.num = as.numeric(map_chr(Zip, Zip.clean)))


TraumaPtsByZipCode <- mutate(TraumaPtsByZipCode, zip = extract_numeric(Zip.num))

#Adding ICD_10 grouping (Function need to be written for ICD 10 number too)

TraumaPtsByZipCode <- mutate(TraumaPtsByZipCode, ICD_10grp = map_chr(ICD_10_txt, ICD_10.cat)) 

#Adding Dispensation based upon intial ER visit

TraumaPtsByZipCode <- mutate(TraumaPtsByZipCode, Initial_disp = map_chr(ER_Disp, Disp.cat))

#Merging the geocodeded zipcode data

trauma.zip <- merge(TraumaPtsByZipCode, zipcode, by='zip')

#Visualizing the data set
head(trauma.zip)

```




	




# Part 2. Summary Statistics





# Part 3. Geo-spatial statistics


## Geocoding the hospital data

#### Setting the coordinates of the hospitals

```{r, hospital geocoding, echo=FALSE}
# Geocoding the Hospital

HVMC <- geocode("Holston Valley Medical Center", source = "google")
JCMC <- geocode("Johsnon City Medical Center", source="google")
BRMC <- geocode("Bristol Regional Medical Center", source="google")


```

####Obtaining the maps 

```{r getting the maps, echo=FALSE}

#Pair down to the minimum per hospital


map.8 <- get_map(location = HVMC,zoom=8,maptype = 'terrain',source = 'google',color = 'color')

map.10 <- get_map(location = HVMC, zoom=10,maptype = 'toner',source = 'stamen')

HVMC.stamen.map <- get_map(location = HVMC, zoom= 8, maptype = "toner", source = "stamen")

```







####Mapping the data

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





#####Top 3 
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


###Summary by county

```{r table sourted by county, mechanism and serverity}


ISS.grp <- trauma.zip %>%
              group_by(County, ICD_10grp, ISS_cat) %>%
              summarise("N" = n(), "Avg.Age" = mean(Age), "Avg.ISS"=mean(ISS))%>%
              arrange(desc(N))

knitr::kable(ISS.grp, digits = 2)
```

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
