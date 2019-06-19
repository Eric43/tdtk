
#' Decrypt TDTK is a read/ decryption function designed to work in
#' conjuction withthe encrypt tdtk function to provide some basic
#' protection (if needed) for data analysis using PHR
#'
#' Given a data set and a secret password or passphrase this function
#' will either read and decrypt a file or decrypt a dataset
#' 
#' The decrypt tdtk function leverages the openssl package to provide
#' a basic level of cryptograpy to allow individual trauma director or
#' systems to protect specific infomrmation to require passpharses or
#' keys.
#'
#' 
#' https://stackoverflow.com/questions/52851725/
#' how-to-protect-encrypt-r-objects-in-rdata-files-due-to-eu-gdpr
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
#' 
#' @param data_set is the data set to be cleaned
#' 
#' @param 
#'
#' @param password is a passwork or passpharase used for the
#'     generation of the key for data encryption.  Keep this secret
#'     and do not share it or save to a varivle
#'
#' @param file_name is the name for the file to be encrypted and saved
#'     or decrypted
#'
#' @param read_file if this is TRUE will look to read a file, attempt to
#'     decrypt it using the included password and return the data set.
#'
#' @return a saved encrypted RDS file with a secret passphrase or a
#'     decrypted RDS file from a prior tdtk dataset
#'
#' g@examples
#'
#' /dontrun{
#'
#' wv_trauma <- read_csv("./wv_trauma.csv")
#' 
#' #saving data
#' 
#' crypto_tdtk(data_set = wv_trama,
#' password = "Take me home...",
#' file_name = "wv_trauma") *Note Add the crypt in paste fx
#'
#' # This will take wv_trauma and save in the working dirctory an
#' # encrypted form using the passpharse.  Try it with a different
#' # phassphars.
#' @export
#'

decrypt_tdtk <- function(data_set = ...,
                         blind = FALSE,
                         password = NA,
                         file_name = NA,
                         read_file = FALSE) 
{

    library(openssl)
    library(dplyr)

#### do file name stuff

    
    
#### ____Required Functions_______ ####


#### ____Checking basic params_______ ####
    
    param_check <- function(password,
                            file_name)
    {        
        
        
        if (is.na(password) ||
            len(password) < 6 ||
            (is.na(file_name) && save_file)){

            warning("Password is not usable, long enoug, or file name is not included")
            check <- FALSE
                
        }
        else if (!is.na(password)){
            check <- TRUE
        }
        
        return(check)
    
    }

#### _____Converting password to key______ ####

    pass2key <- function(password)
        
    {
        library(openssl)
        library(dplyr)
        
        key <- password %>%
            charToRaw() %>%
            sha256()
        
        return(key)
    }







####____Main____####

    if (read_file){
        encrypt_file <-  readRDS(file_name)
    }
    else {
        encrypt_file <- data_set
    }


    return(unserialize(aes_cbc_derypt(encrypt_file, key = pass2key(password))))    
}
