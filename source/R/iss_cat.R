
#' Injury severity score categorization function
#'
#' Give an injury severity score it determines category
#'
#' The goal of this function is to describe the patients Injury
#' Severity Score (ISS).  Bolorunduro et al (2011) provided for basic
#' categories of: Mild, Moderate, Severe and Profound.
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
#' 
#' @references Bolorunduro OB et al (2011) J Surgical Res
#'     2011 Mar 166 40
#' 
#' @keywords injury score
#'
#' @param iss_score
#'
#' @return category of the ISS score as per Bolorunduro et al.
#'
#' @examples\dontrun{
#'
#' # Single Call
#'
#' iss_cat(8)
#' 
#' # Call using purr::
#' 
#' map_chr(peds.hvmc$ISS, ISS.cat)
#'
#'}
#'
#' @export



# ---------------------------- #
iss_cat <- function (iss_score = 0){



  if (is.na(iss_score)){
    cat <- "not determined"
  }else if (iss_score >= 0 && iss_score < 9){
    cat <- "mild"
  }else if (iss_score >= 9 && iss_score < 16) {
    cat <- "moderate"
  } else if (iss_score >=16 && iss_score < 25){
    cat <- "severe"
  } else{
    cat <- "profound"
  }



  return(cat)
}


                                        #_____________________________#

# spell checked 31 jan
