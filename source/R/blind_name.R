
#' Blind name is for blinding hospital and physician names
#'
#' Given a data set this will use a random charecter generator to
#' generate a random string and look up table that is save as an RDS.
#' The lookup tavle is designed to be kept by approprite individuals
#' (i.e. Trauma Medical Director) or deleted. If ultimately deledted
#' it maybe best not to save the fiel and select save_names = FALSE.
#'
#' The blind_name is a function designed with the ability to blind and
#' remove names as well as save a look up file IFF needed.
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
#' 
#' @param data_set is the data set to be cleaned
#' @param blind is the type of name blinding i.e. human, hosp)
#' 
#' @param save_names is T/F on if the master name look up
#' 
#' @param method is methond for renaming random (rnd) , crypto
#'     ("crypt"...may require a method var at later date) or seqential
#'     (seq).  Please don't use sequential unless you randomize any
#'     albhebetized data sets.
#'
#' @param blind_len lenght of final string for rename
#'
#' @param file_name is the name for the look up table
#'
#'
#' @return a blinded data set with different allowable levels of
#'     blinding for medical or data professionals as well as public
#'     release of data
#'
#' @examples
#'
#' @export
#'

blind_name <- function(data_set = ...,
                       blind = "human",
                       save_name = FALSE,
                       method = "rnd",
                       blind_len = 8, # can use runif rnd
                       file_name = NA,
                       encrypt = ...,
                       passphrase = NA)
{
    library(dplyr)
    library(openssl)

### work on two methods one pass pharse and other fully random pass to prevent reident
    
### give one or a vector of names, hosptial names etc, passphrase (opt) for full random
### blind with no pass pharse seet blind to rnd.
### Blind settings are: "encrypt" or "decrypt" these require passpharses
### next is the rnd that randomly assigns a string of number/letters/characters that are
### a set length (Blind length).  This uses the encrypt_tdtk to make the encrypttion.

                                        # Set the cases for the blinding method

    
    
    #### Need to think the option through.  Is it easier to do Unique names and then LUT for encypt?
    
    

}


                          
