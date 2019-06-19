
#' Crypto TDTK is an encryption|decryption function designed to
#' provide basic protectiion for potential PHI.
#'
#' Given a data set and a secret password or passphrase this function
#' will
#' 
#' The blind_name is a function designed with the ability to blind and
#' remove names as well as save a look up file IFF needed.  This
#' function was inspired and the encryption code was obtained from:
#'
#' https://stackoverflow.com/questions/52851725/
#' how-to-protect-encrypt-r-objects-in-rdata-files-due-to-eu-gdpr
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
#'
#' 
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
#' @param derypt if this is TRUE will look to read a file, attempt to
#'     decrypt it using the included password and return the data set.
#'
#' @return a saved encrypted RDS file with a secret passphrase or a
#'     decrypted RDS file from a prior tdtk dataset
#'
#' @examples
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
#'
#' 
#'
#' #reading crypt file
#'
#' wv_trauma_decrypt <- crypto_tdtk(data_set = readRDS("./wv_trauma_crypt.Rds",
#' decrypte = TRUE)
#' 
#' }
#'
#' 
#' @export
#'

crypto_tdtk <- function(data_set = ...,
                      blind = FALSE,
                      password = NA,
                      file_name = NA,
                      decrypt = FALSE) #Decryption is reading
{

    library(openssl)
    library(dplyr)

#### do file name stuff

#### Not a fan of two different retrun possiblies but easiest way to
#### throw decrpty/read into one function for intial ease of use
    
#### end file name


    if (is.na(password) ||
        len(password) < 6 ||
        is.na(file_name)){ # Check passpharse
        stop("Password is not usable, long enoug, or file name is not included")
    }


    key <- password %>%
        charToRaw() %>%
        sha256()
    
    if (!(decrypt)){#I not reading in then
        
        encrypt_data <- aes_chc_encrypt(data_set, key = key)

        file_name <- paste(file_name, "crypt", Sys.Date(), sep = "_")

        saveRDS(encrypt_data, file_name)

        return(print(paste("File was saved in working directory as: ", file_name)))
    }

    else (decrypt){#reading in teh data
        
        encrypt_data <- readRDS(file_name)

        return(unserialize(aes_cbc_derypt(encrypt_data, key = key)))          

    }
    
    
}
    
                      
