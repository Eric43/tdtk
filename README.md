# Trauma Director Tool Kit (tdtk)
Trauma director tool kit repository
# Description
The trauma director tool kit is a collection of files and packages designed to allow trauma professionals to analyze, blind and graphically display pertinant clinical information.  Where possible the ACS care of the critially injured patient criteria are used:


https://www.facs.org/~/media/files/quality%20programs/trauma/vrc%20resources/resources%20for%20optimal%20care.ashx


The tdtk is not designed to supplant ACS excellent work with NTDM or TQUIP but meant to help trauma directors with a eye to rural/poorly resourced trauma system report analysis.  See Chapter 15 in ACS care of the critically injured patient:

>"A trauma registry can be valuable only if the data it contains can be transformed into useful information through the process of report writing. Trauma registry reports support decision making and guide the management of the trauma center. Most trauma registry software provides for the generation of several standard reports that summarize different ways to address specific questions or areas of concern. Most standard reports are oriented to anticipate the needs of a trauma center’s PIPS program and provide the needed information. This capability should be built into the software itself or achieved by exporting the data to a separate spreadsheet, relational database, or statistical program."

# Installation

To install the tdtk package use the devtools install_github() using the "package" directory for subdir.  For example:

```{r}
library(devtools)
install_github("Eric/43/tdtk", subdir = "package")
```

This is a basic devtool install and once the tdtk-package progress past prototype and into full version the goal is to move a stable version to CRAN and deveolpers version on Github or equivelent.  

# Project Organization

The tdtk project is designed to be fully free and open devlopment in keeping with this mission, the directory structure is divided into three parts.  First, there is the package subdirectory.  In this subdir is the necessary componets to install the current development version of the tdtk-package.r.  Next there is the ./code director that contains the code used to generate the tdtk package.  Finally any note, org files etc will be maintqined in the tdtk main directory.  

# Project Goals

The goal of this project is to provide trauma directors with the necesary statistical/mathematical models to analyze trauma patient data that has a basic Protected Health Informtion (PHI) removed but may still have a greather than very-low probability of patient ID.  In addtion to only the basic removal HIPAA proteted research done by the trauma director (that is not meant for public use), several function have added data blinding option.  This blining option can bin ages, zip codes (removal of last 2 or full removal) or both.  To prevent further patient ID, the geocoded plots include random noise to prevent geo-location identificatino.  Togheeter these tools can be used to fully inv
