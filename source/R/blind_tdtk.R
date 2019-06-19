
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
#' @return a blinded data set with different allowable levels of
#'     blinding for medical or data professionals as well as public
#'     release of data
#'
#' @examples
#'
#' @export



blind_tdtk <- function(data_set = ...,
                       blind = "both",
                       blind_chr = "00",
                       age_blind = "blind",
                       age_clean = FALSE,
                       random = FALSE)
{
    ## Goal of this function is to take a data set, remove potential PHI
    ## and return a data frame that has been appropriately blindedd.
    ## This is probably a perfect case for a case_when argument

    library(purrr)
    library(dplyr)
    
### Look at modifying to a case when and use dplyr ?
    
    if (blind == "age"){
        if (age_clean){
            
            data_set$Age <- map(data_set$Age, age_clean)
        }
        
        data_set <- transmutate(data_set, Age = map(Age,
                                                    age_cat,
                                                    blind = age_blind))
    }

    else if (blind == "zip"){

*9        data_set <- transmutate(data_set, Zip = map_chr(Zip,
                                                        zip_clean,
                                                        blind_chr = blind_chr))    
    }
        
    else if (blind == "both"){
        if (age_clean){
            
            data_set$Age <- map(data_set$Age, age_clean)
        }
        
        data_set <-
            data_set %>%  transmutate(Age = map(Age,
                                           age_cat,
                                           blind = age_blind)) %>%
            
                          transmutate(Zip = map_chr(Zip,
                                               zip_clean,
                                               blind_chr = blind_chr))
    }
   

    
    if (random == TRUE){
        return(shuffle(data_set))
    }
    else {
        return(data_set)
    }
    
}
