
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
#' minimize the need to export.  This is probably an inefficient way
#' to load the file etc but its a start.
#'
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
#' @param file_name is the name of the file
#' @param file_type is the type of file ("csv" or "xls" for now with
#'     "SQL" functionality to be added later.
#' @param save_file is T/F and will save the file prior to returnign
#'     the dataframe/list
#' @param blind is a case type of blinding for ("NA", "zip", "age" or
#'     "both")
#' @param random is the shuffling of unblinded data prior to use
#'     blindied data is automatically shuffled once time series data
#'     is removed.
#' @param save_data meant to be used as a T/F for saving data
#' @param warning T/F to turn off warnings for unblinded data
#'
#' @return either a dataframe extract_ts = T will return a timeseries
#'
#' @examples
#'
#' @export

read_tdtk  <- function(file_name = ...,
                       file_type = "csv",
                       save_file = FALSE,
                       blind = NA,
                       extract_ts = FALSE,
                       random = TRUE,
                       save_data = FALSE,
                       sql_svr = FALSE,
                       warning = FALSE)
{

                                        # requred librarys
    library(readr)
    #library(lubridate) # seperated two functions...old function call
    library(dplyr)
    #library(dbplyr) # used if sql_svr = T....move to dbread_tdtk.R
    library(stringr) # str_extract zip with regex
    library(purrr) # map char


                                        # Rapid check of passed  parameters prior to function
    param_check  <- function (blind,
                              file_name,
                              warning)

    {

    if (!(is.na(blind)) && warning == TRUE){
        stop("Data is meant to be blinded but warning(s) is turned off.")
    }
    else if (is.na(file_name)){
        stop("Fine name and file not supplied")
    }
    else {
        return(TRUE)
    }
    }

        #### another f(x)

    save_blind  <- function (data = ...,
                             file = NA)
     {

         if (is.na(file))
         {
             stop("ERROR: No file name or file =NA")
         }
         else {
             blind_name  <- paste(file, "blind", sep = "_")
             save(data, file = paste(blind_name,
                                 "Rda",
                                 sep = "."))
         }




         return(print(paste(blind_name,
                            "Has been saved to the working directory",
                            sep = " ")))

     }







                                       # main

#load data Note: path maybe different.  Lood actual data.  # Note: Dont forget
# to modify excel .csv so that <1 yr (in months or weeks) is calculated as year
# (i.e. 1 wk old = 1/52 of a year and 6 months is 6/12 = 0.5 yr)



colnames <- c("Age",
               "ISS",
               "ICD_10_txt",
               "County",
               "State",
               "Zip",
               "ER_Disp",
               "Disp_Des",
               "Disp_Des_S",
               "Dis_Fac")


                                        # set a case_when or if statements to load either csv or xls usng readr

    if (param_check(blind, file_name, warning)) { # just basic param check

        if (file_type == "csv"){
            patient_data <- read_csv(file_name,
                         skip = 1, #skip set to 1 to avoid column names in row 1
                         col_names = colnames)
        }
        else if (file_type == "xls"){
            patient_data <- read_xls(file_name,
                                     skip = 1,
                                     col_names = colnames)
        }
        else {
            stop("No readable file name entered")
        }
    }

    if (!is.na(blind)){
        patient_data  <-  tdtk_blind(data = patient_data, blind = blind) #Maybe make another function
    }

    if (random) {
        patient_data  <-  shuffle(patient_data)
    }
    if (save_data){
        if (!is.na(blind)){
            save_blind(data = patient_data,
                       file = save_file)
        }
        else {
            save_tdtk(data = patient_data,
                      file = save_file)
        }

    }

    return(patient_data)


}
