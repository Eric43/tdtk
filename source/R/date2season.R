
#' Date 2 Season is a function designed to determine season
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
#' @param data_set is the data set to be cleaned
#' @param blind is the type of blinding for Age only, zip only or
#'     both.  Both setting will wipe age to three catagories (peds,
#'     adul, geriatric) and blind last two of zip.
#' @param zip_chr is the characters or numbers used to blind.  Can be
#'     from 1-5 char is length
#' @param age_blind is the type of age blinding for ACS Adult, ACS
#'     combo, pediatric and all (cats: "peds", "combo", "adult",
#'     "blind")
#' @param age_clean is a T/F on if the data needs to be sent to
#'     extract and convert the age (or some ages) from months or days
#'     to years.  This can also return a numbberic when fed a char
#'
#' @return a standard season determination is done from a date or date
#'     time varible
#' 
#' @examples
#'
#' test <- as.Date("Nov, 23", format = "%b, %d")
#' date2season(test)
#'
#' test <- as.Date("Feb 29, 2012", format = "%b %d, %y")
#' date2season(test)
#'
#' @export


date2season <- function(date = ...,
                        seasons = "std"
                        )
{

    library(dplyr)

    if (class(date) != "Date"){
        stop("date is not in the correct format")
    }
    else {
        mo <- as.numeric(month(date))
    }
    
    season <- case_when(
                     mo %in% 1:2 ~ "Winter",
                     mo %in% 3:5 ~ "Spring",
                     mo %in%  6:9 ~ "Summer",
                     mo %in% 10:11 ~ "Fall",
                     mo %in%  12 ~ "Winter"
                 )

    return(season)
    
}

    





                                        # Note as date check for
                                        # appropriate year for leap
                                        # testing

