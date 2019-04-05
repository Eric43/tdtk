
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
#'     combo, pediatric and all
#'
#' @return a blinded data set should not be used unless blinding data
#'
#' @examples
#'
#' @export



blind_tdtk <- function(data_set = ...,
                       blind = "both",
                       zip_chr = "xx",
                       age_blind = "blind",
                       random = FALSE)
{
    ## Goal of this function is to take a data set, remove potential PHI
    ## and return a data frame that has been appropriately blindedd.

    if (blind == "age"){
        Case when ? (blind = XXX or XXX or XXX then call differently)
        
        data_set <- transmutate(data_set, Age = (age_clean( XXXXX ))) NOTE: type of blinding
    }
    else if (blind == "zip"){

        data_set <- transmutate(data_set, Zip = zip_clean())
            
    }
    else if (blind == "both"){
        data_set <- data_set %>%
            Blind_tdtk(type) %>%
            zip_clean()
    }

    return(data_set)
