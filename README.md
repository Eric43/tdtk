# Trauma Director Tool Kit (tdtk)
Trauma director tool kit repository

## __Special thanks to all contributors__

### Clinical Team/Initial Development

-  Dr. Tiffany Lasky
-  Dr. Sarah Robison

### Background Literature Search/ References

- Zach Easley

# Description
The trauma director tool kit is a collection of files and packages designed to allow trauma professionals to analyze, blind and graphically display pertinent clinical information.  Where possible the ACS care of the critically injured patient criteria are used:


https://www.facs.org/~/media/files/quality%20programs/trauma/vrc%20resources/resources%20for%20optimal%20care.ashx


The tdtk is not designed to supplant ACS' excellent work with NTDB or Quality Improvement Programs (QIP) but meant to help trauma directors with a eye to rural/poorly resourced trauma system report analysis.  See Chapter 15 in ACS care of the critically injured patient:

>"A trauma registry can be valuable only if the data it contains can be transformed into useful information through the process of report writing. Trauma registry reports support decision making and guide the management of the trauma center. Most trauma registry software provides for the generation of several standard reports that summarize different ways to address specific questions or areas of concern. Most standard reports are oriented to anticipate the needs of a trauma center’s PIPS program and provide the needed information. This capability should be built into the software itself or achieved by exporting the data to a separate spreadsheet, relational database, or statistical program."

# Installation


The following example is using Pop!_OS a derivative of Unbuntu but similar steps are involved for all OS's.

First, download the source file:

https://github.com/Eric43/tdtk/tree/master/package

Next, determine where the package is located and then install in R (direct, ESS or R-studio methods) using:


```{r}
install.packages(path_to_file, repos = NULL, type="source")

```
I downloaded tdtk-package version 0.2.0.2019 into the "Downloads" folder therefore:

```{r}
 install.packages("~/Downloads/tdtk_0.2.0.2019.tar.gz", repos = NULL, type="source")
```

## OR

To install the tdtk package use the devtools install_github() using the "package" directory for subdir.  For example:


```{r}
# Currently getting 404 error but direct link works
# On the fix list.

library(devtools)

install_github("Eric43/tdtk", subdir = "package")
```

This is a basic devtool install and once the tdtk-package progress past prototype and into full version the goal is to move a stable version to CRAN and developers version on Github or equivalent.  

# Project Organization

The tdtk project is designed to be fully free and open development in keeping with this mission, the directory structure is divided into three parts.  First, there is the package sub-directory.  In this subdir is the necessary components to install the current development version of the tdtk-package.r.  Next there is the ./source directory that contains the code used to generate the tdtk-package (with Roxygen2 document information).  

## Directory Structure

In the main directory there should be several sub-directories containing the information necessary for the tdtk.  In addition, there should be the LICENSE, README.md and other files in this directory.


### package
Contains the most up-to-date build of the package.  It may not be up to date with the code in the source directory.
### reports
Contains the markdown or similar files for generation of trauma reports from patient data.
### source
Contains the exact code/R files used to build the package.  


# Project Goals

The goal of this project is to provide trauma directors with the necessary statistical/mathematical models to analyze trauma patient data that has a basic Protected Health Information (PHI) removed but may still have a greater than very-low probability of patient ID (limited data set).  With the limited data set, a trauma director or appropriate medical professional can generate necessary reports/figures.  

In addition to the basic removal of PHI in the limited data set (not intended for direct public use/viewing), the trauma director or appropriately trained personnel can blind age and zip to decrease potential risk or re-identification to very low.  This blinding option can bin ages, zip codes (removal of last 2 or full removal) or both(recommended for non-professionals).  To prevent further patient ID, the geo-coded plots include random noise or will use mathematical modeling via 2d statistical density models that minimize potential patient identification.

In conclusion, the tdtk-package is designed to be used by anyone in the medical profession that needs: basic summary statistics, scatter plots, geo-spatial modeling, ARIMA/time series modeling and others.  It is hoped that as/if this project is utilized that it can aid all medical professionals across the globe independent of the resources available to the practitioner.  When combined with free Electronic Health Record (EHR) systems like LibreHealth that multi-institutional, multi/trans-cultural blinded database. This database can be used for a range of advanced projects like machine-learning/AI models that once developed have no need for proprietary software/hardware. To quote Bob Dylan "I'll let you be in my dreams if I can be in yours"


# References

## R specific

### Work on these...totally not done/complete.

R core team

  R Core Team (2018). R: A language and environment for statistical
  computing. R Foundation for Statistical Computing, Vienna, Austria.
  URL https://www.R-project.org/.
  
dplyr

  Hadley Wickham, Romain François, Lionel Henry and Kirill Müller
  (2019). dplyr: A Grammar of Data Manipulation. R package version
  0.8.0.1. https://CRAN.R-project.org/package=dplyr
  
Magrittr (? tidyverse? the pipe command...but seems to work in the universe)

  Stefan Milton Bache and Hadley Wickham (2014). magrittr: A
  Forward-Pipe Operator for R. R package version 1.5.
  https://CRAN.R-project.org/package=magrittr

readr

  Hadley Wickham, Jim Hester and Romain Francois (2018). readr: Read
  Rectangular Text Data. R package version 1.3.1.
  https://CRAN.R-project.org/package=readr

tidyr


  Hadley Wickham and Lionel Henry (2019). tidyr: Easily Tidy Data with
  'spread()' and 'gather()' Functions. R package version 0.8.3.
  https://CRAN.R-project.org/package=tidyr


purrr (map instead of apply)

  Lionel Henry and Hadley Wickham (2019). purrr: Functional Programming
  Tools. R package version 0.3.2.
  https://CRAN.R-project.org/package=purrr


ggplot2

  H. Wickham. ggplot2: Elegant Graphics for Data Analysis.
  Springer-Verlag New York, 2016.
  
Tidyverse (Easy install for the nearly total Hadley-verse)

  Hadley Wickham (2017). tidyverse: Easily Install and Load the
  'Tidyverse'. R package version 1.2.1.
  https://CRAN.R-project.org/package=tidyverse
  
ggmap
  
  D. Kahle and H. Wickham. ggmap: Spatial Visualization with ggplot2.
  The R Journal, 5(1), 144-161. URL
  http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf
  
  
Forecast (ARIMA Modeling.  Awesome package IMO)

 Hyndman R, Athanasopoulos G, Bergmeir C, Caceres G, Chhay L,
 O'Hara-Wild M, Petropoulos F, Razbash S, Wang E and Yasmeen F (2019).
 _forecast: Forecasting functions for time series and linear models_. R
 package version 8.5, <URL: http://pkg.robjhyndman.com/forecast>.

Need Random Forest ('02 or '03 paper?), LM and PCA refs

## Clinical References

JabRef/BbiTex databales/list in progress (Zach)

