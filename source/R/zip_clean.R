#' Function cleans up zipcodes that contain extra information.
#'
#' Given a zip code or a vector of zipcodes, the function extracts the
#' zip code and then returns a clean zip code.  Blinding will remove
#' the last n char as determined by blind_chr
#'
#' @param zip a single of a vector of zipcodes with junk in fields.
#'     Very basic
#' @param blind currently non functional but returns logical var to
#'     tell function to blind
#' @param blind_chr the characters exactly n and type to replace the
#'     last n digits
#'
#' @return cleaned zips
#'
#' @examples \dontrun{
#' zip_test  <- "37692 x"
#'
#' zip_clean(zip_test) # Basic function
#'
#' }
#'
#' @export


zip_clean <- function(Zip = ... , blind = FALSE, blind_chr = "00"){

    library(stringr)

  ### to call using purr::### map_chr

    if (is.na(Zip)){
        clean.zip <- NA
    }else if (str_detect(Zip,"Unknown|unk|unknown")){
        clean.zip  <- NA
    }else if (blind){
        clean.zip  <- str_sub(Zip, 1, 5) # need to regex it
    } else {
        clean.zip  <- str_sub(Zip, 1, 5) # need to regex
    }

    if (blind){
        clean.zip <- paste(c(str_sub(clean.zip,  end = -(nchar(blind_chr) + 1)),
                             blind_chr), collapse = "")
    }


  return(clean.zip)
}


