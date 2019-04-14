
#' Age clean is a function to clean and convert ages 
#'
#' Given an age column to convert ages in days or months to years.
#'
#' This function was written to address the fact that some reports
#' generate the ages in days, months or years dependion on the
#' individual age.  This means that the number and the text descrptor
#' for age need to be extracted and then converted to years.
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
#' 
#' @param data is the data to be cleaned
#' @param n_round digits to round degault 2 
#' @param conver_to is the unity of measure to convert to currently
#'     only suuppors year.  For potential future use.
#' 
#' @return clean and coonverted age to years.
#'
#' @examples
#'
#' age_clean("11 mo")
#'
#' age_clean("36 d")
#' 
#' @export

age_clean <- function (data = ...,
                       n_round = 2,
                       convert_to = "yr")
{
                                        # regex or strinr will work....
    library(stringr)
    
    unit <- str_extract(data, pattern = "\\w{1,3}\\Z")
        
    age <- as.numeric(str_extract(data, pattern = "\\d{2,3}"))
    
    
    ## Convert age to years based upon extracted unit
    if (unit == "mo"){
        age <- age/12
    }
    else if (unit == "d"){
        age <- age/365
    }

    return (round(age, digits = n_round)) 
}

