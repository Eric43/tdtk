
#' Blind tdtk is a blinding function 
#'
#' Given a data set this will use individual tdtk function plus basic
#' code to blind the dataset in accordance with what needs to be
#' blinded.  This is meant to be a basic blinding of data additional
#' blindingg operations can occur for transfer center to reduce to a
#' mathematical model.
#'
#' The blind_tdtk is a function designed around the standard blinding
#' scenarios with the trauma registary data.  It can blind by age, zip
#' or all. This is done to allow for flexiblity for the medical
#' professinals.
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
#' 
#' @param data_set is the data set to be cleaned
#' @param blind is NA for no blinding or type of blinding to be called
#'     by blind_tdtk()
#' @param time_zone is the time zone of data collecion to allow for
#'     conversion of the date/time data to apprpriate type
#' @param na_rm is set to T or F depending on if the data set needs
#'     rows of NA's removed
#' @param zip_geo is T/F on if to add the zip code geo-coding data
#'
#' @return a clean and possibly blinded data set
#'
#' @examples
#'
#' @export
