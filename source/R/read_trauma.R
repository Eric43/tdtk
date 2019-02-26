#' Read Trauma is a Fucnction to read in trauma data
#'
#' Given either CSV or exl file with standard column names and order
#' be able to read in the file, extract time-series data (if
#' included), clean zip codes, determine ISS catagory and blind that
#' data (IFF blidn_data == TRUE).
#'
#' The read_trauma() function was designed to work with exported data
#' from an electronic health record source.  As the function continues
#' to develop it is expected to add direct SQL backend queeries to
#' minimize the need to export.
#'
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
#' @references \url{https:\\www.github.com\eric43\tdtk}
#' @seealso \code{\link{<tdtk_read.r>}}
#'
#' @param file_name is the name of the file
#' @param file_type is the type of file ("csv" or "xls" for now with
#'     "SQL" functionality to be added later.
#' @param save_file is T/F and will save the file prior to returnign
#'     the dataframe/list
#' @param blind is a case type of blinding for ("NA", "sip", "age" or
#'     "both")
#' @param extract_ts is a T/F to extract the time series data (if
#'     included) and will return a list wtih TS and PT data
#' @param random is the shuffling of unblinded data prior to use
#'     blindied data is automatically shuffled once time series data
#'     is removed.
#' @param warning T/F to turn off warnings for unblinded data
#'
#' @return either a dataframe or a list if extract_ts = T
#'
#' @examples
#'
#' @export
#'
read_tdtk  <- function(file_name = ...,
                         file_type = "csv",
                         save_file = FALSE,
                         blind = NA,
                         extract_ts = FALSE,
                         random = TRUE,
                         warning = FALSE)
{

                                        # requred librarys
    library(readr)
    library(lubridate)
    library(dplyr) #case_when
    library(dbplyr)


                                        # Rapid check of passes parameters prior to function

    if (!(is.na(blind)) && warning == TRUE){
        stop("Data is meant to be blinded but warning(s) is turned off.")
    }

    else if (is.na(file_name)) {
        stop("Fine name and file not supplied")

    }

                                        # read in the data



                                        # parse the data


                                        # Set column names


                                        # extract timeseries data (if needed)



                                        # Clean up/ tidy the dat set



                                        # Blind the data

                                        # save data (if selected)

                                        # return the data


                                        # MAIN #





    }







