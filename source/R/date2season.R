
#' date2season is a function designed to determine season
#'
#' Given a date determine what Northern Hemisphere standard season it
#' is in.  Later may add the astronomical or some approximation
#' thereof.
#'
#' The date2season.R is a function that is used in conjection with
#' trauma director tool kit and is used to catorgize or blind data
#' based upon users need. For catagories just use the standard mutate
#' and add a data column.  If its necessary to remove the actual
#' arrivad date and/or time one can than blind the date by using
#' seasonal catagories along with transmutate. Currently the date must
#' be passed inan appropriate as.Date format to allow for conversion
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
#' 
#' @param date is the date in correct Date class use as.Date
#' @param blind is the type of blinding for Age only, zip only or
#'     both.  Both setting will wipe age to three catagories (peds,
#'     adul, geriatric) and blind last two of zip.
#' @param seasonns is a test of std or ast for broken into 3 months
#'     blocks for each season with winther being Jan, Feb and Dec.
#' @param hemi is the hemisphere for seasons enter "North" or "South"
#'     current in progress
#' 
#' @return the season in text format
#' 
#' @examples
#'
#' test <- as.Date("Nov, 23", format = "%b, %d")
#' date2season(test)
#' 
#' date2season(test, hemi = "South")
#'
#' test <- as.Date("Feb 29, 2012", format = "%b %d, %Y")
#' date2season(test)
#' 
#' date2season(test, hemi = "South")
#'
#' @export


date2season <- function(date = ...,
                        seasons = "std",
                        hemi = "North")
{

    library(dplyr)
### dont know if necessary to do conversion in else
    if (class(date) != "Date"){
        stop("Data is not in Date class please convert")
    }
    else {
        mo <- as.numeric(month(date))
    }
    if (hemi == "North"){
    season <- case_when(
                     mo %in% 1:2 ~ "Winter",
                     mo %in% 3:5 ~ "Spring",
                     mo %in%  6:9 ~ "Summer",
                     mo %in% 10:11 ~ "Fall",
                     mo %in%  12 ~ "Winter"
    )
    }
    else if (hemi == "South"){
            season <- case_when(
                     mo %in% 1:2 ~ "Summer",
                     mo %in% 3:5 ~ "fall",
                     mo %in%  6:9 ~ "Winter",
                     mo %in% 10:11 ~ "Spring",
                     mo %in%  12 ~ "Summer"
    )
    } 

    return(season)
    
}

    





            
