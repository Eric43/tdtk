
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
#' @param data_set is the data set to be cleaned
#' 
#' @return a blinded data set should not be used unless blinding data
#'
#' @examples
#'
#' @export

age_clean <- function (data = ...,
                       convert_to = "yr")
{

data
}

