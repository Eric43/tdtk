
#' Encryp tdtk is an encryption function designed to provide basic
#' protection for potential PHI.  This is basic for encrypting files
#' that may or may not contain HIPAA protected PHI to proveid an
#' encrypted passphrase protected data set
#'
#' Given a data set and a secret password or passphrase this function
#' will.  
#' 
#' The encrypt tdtk is designed to act as a basic encryption method
#' for the data set that may or may not contain PHI.  It is possible
#' but not tested that a script could be written in a EHR server side
#' scenario (Docker?) to queery, blind and encrpyt pritr to sending
#' the data to the researcher/trauma medical director.
#' 
#' Function was inspired and the encryption code was obtained from:
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
#' @param blind is a T/F that will fully blind the data set (Not working)
#'
#' @param password is a password or passphrase used for the
#'     generation of the key for data encryption.  Keep this secret
#'     and do not share it or save to a variable
#'
#' @param file_name is the name for the file to be encrypted and saved
#'     or decrypted
#'
#' @param save_file is T/F of if the encrypted file is saved, returned
#'     or nother
#'
#' @param return_encrypt instead of saving the file it returns the
#'     encrypted information to be used as needed by the end
#'     user. NOTE will consider just using the save_file T/F as a auto
#'     setting to either save or teturn so this function does somethin
#'     usefull instead of encryptin g data set and return nothing or
#'     save nothing.
#'
#' @return a saved encrypted RDS file with a secret passphrase or a
#'     decrypted RDS file from a prior tdtk data set
#'
#' @examples
#'
#' /dontrun{
#'
#' wv_trauma <- read_csv("./wv_trauma.csv")
#' 
#' #saving data
#' 
#' encryp_tdtk(data_set = wv_trama,
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

encrypt_tdtk <- function(data_set = ...,
                         blind = FALSE,
                         password = NA,
                         file_name = NA,
                         save_file = FALSE,
                         return_encrypt = TRUE) #Decryption is reading
{

    library(openssl)
    library(dplyr)
    library(magrittr)


#### do file name stuff

#### Not a fan of two different return possibles but easiest way to
#### throw decrpty/read into one function for intial ease of use
    
#### end file name


    
#### ____Required Functions_______ ####


#### ____Checking basic params_______ ####
    
    param_check <- function(password,
                            file_name)
    {        
        
        
        if (is.na(password) ||
            len(password) < 6 ||
            (is.na(file_name) && save_file)){

            warning("Password is not usable, long enough, or file name is not included")
            check <- FALSE
                
        }
        else if (!is.na(password)){
            check <- TRUE
        }
        
        return(check)
    
    }

#### _____Converting password to key______ ####

### Pass2key is needed in other functions.  May copy or put as
### general utility outside of the source?
    
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


    
    if(param_check()){
        
       encrypt_data <- aes_chc_encrypt(data_set, key = pass2key(password))
        
        if(save_file){
            
            file_name <- paste(file_name, "crypt", Sys.Date(), sep = "_")
            
            saveRDS(encrypt_data, file_name)
            
            print(paste("File was saved in working directory as: ", file_name))
        }
        
    }
    else{
        warning("Parameters passed not correct to encrypte and save")
    }





    
    if (return_encrypt) {
        
        return(encrypted_data)
    }
    else if (!(return_encrypt) && !(save_file) { 
        return(warning("File encrypted but not returned or saved."))
    }
    else {
        return(print("The encrypt_tdtk function complete."))
    
    }
}
    
                      
