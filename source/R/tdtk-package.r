#' tdtk: A package for analyzing  patient data
#'
#' The tdtk is designed for a trauma driector or similar medical
#' professional to analyze patient data.  In addition to data
#' anlysis this series of functions can be used to blind data.  The
#' tdtk can be used for any patient data but us desugbed around known
#' registry fields.  The tdtk paccage is comprised of several
#' functions including: <list the stuff>
#'
#' @section ctr2cir: The ctr2cir function takes a lon, lat and
#'     calculates a circle of a radius = rad
#'
#' @section center2circle: This function is similar to ctr2cir but
#'     returns a list with the essential data including circle lon,lat
#'     for 360 degrees
#'
#' @section read_tdtk: This function helps load standardized trauma
#'     registry data that is in csv or xls.
#'
#' @section disp_cat: This function helps groups dispensations to
#'     groups to allow for analysis depending on dispensation.
#'
#' @section icd_cat: This function summarizes and groups the ICD-10
#'     text to groups to simplify anaysis.
#'
#' @section iss_cat: This function groups patients intoo ISS
#'     catagories of mild, moderate, severe, profound and NA.
#'
#' @section age_cat: This function catagorizes age bins based upon
#'     type of trauma center or blind the age into 3 groups.
#'
#' @section zip_clean: This function removes the 5 numbers the compase
#'     the US zip code.  If blind is true the characters will be put
#'     in place from the end
#'
#' @section route2center: This function is meant to geocode the routes
#'     from all the either zip code or town name.  Once this is done
#'     this routh data can be used to overlay all the routes to
#'     demonstrate major routes of travel for EMS to main hospital.
#'
#' @docType package
#' @name tdtk
NULL
