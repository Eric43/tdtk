
#' Clean tdtk is a function to clean up exported trauma data
#'
#' Given 
#'
#' The clean_tdtk is designed for cleaning data exported using DI
#' driller or equivelent.  It is meant to be used along with read_tdtk
#' or with the readr using standardized column names (col_names)
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
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

clean_tdtk <- function (data_set = ...,
                        blind = NA, 
                        time_zone = "EST",
                        na_rm = TRUE,
                        zip_geo = FALSE)
{
## May need to change the arr.date.time to Arr_date for consistiency

    ## Check on the function calls
    ## Check on the need for all to undego cleanind and not send all data

    

    if (na_rm = TRUE){## Removing the NA rows
        trauma_data <- trauma_data %>% filter(Reduce(`+`, lapply(., is.na)) != ncol(.))
    }
    
    ## Setting date time column to appropriate format
    
    data_set$Arr.Date.Time <-mdy_hm(data_set$Arr.Date.Time, tz = time_zone)

    data_set <- data_set %>%
        transmutate(Age = as.numeric(map_chr(Age, age_clean)))

    if (is.na(blind) || !(blind)){## If not blinded assumse need for all data
        data_set <- data_set %>%
            mutate(ISS_cat = map_chr(ISS, iss_cat)) %>%
            mutate(Zip_num = as.numeric(map_chr(Zip, zip_clean))) %>%
            mutate(ICD_10grp = map_chr(ICD_10_txt, icd_cat)) %>%
            mutate(Init_disp = map_chr(ER_Disp, disp_cat)) %>%
        
    }
    else if (!is.na(blind) && blind){ ## not mose efficient but easiest for differe usr grps.
        data_set <- blind_tdtk(data_set = data_set, blind = blind)
    } 
    

    if (zip_geo){## Merging zip goe data maybe function it?
        data_set <- merge(data_set, zipcode, by='zip')
    }

    return(data_set)
}
