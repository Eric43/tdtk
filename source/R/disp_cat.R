#' Dispensation category function
#'
#' Given a disp column will break up into basic groups that stay in
#' the hospital, discharged, mortality or other.
#'
#' The goal of this function is to take a dispensation and reduce the
#' number of factors to basic groups. Initially, started with four
#' groups (i.e. Stay in Hospital, Morgue, transfer or home).
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
#' @references 
#'
#' @keywords dispensation, simplification
#'
#' @param disp is the dispensation of the patient
#'
#' @return Text to simplify patient dispensation.
#'
#' @examples \dontrun{
#'   ### to call using purr::### map_chr(peds.hvmc$ISS, ISS.cat)
#'}
#'
#' @export

disp_cat <- function (disp = "Floor"){
  # This function takes dispositions defied in provided data set
  # and turns them into categorizes:



    if (is.na(disp)){
        cat <- "not determined"

    }else if ((disp == "Floor" ||
               disp == "Intensive Care Unit" ||
               disp == "Neonatal/Pediatric Care Unit") ||
               disp == "Observation Unit" ||
               disp == "Operating Room" ||
               disp == "Step-Down Unit")
    {
        cat <- "Stay In Hospital"

    }else if (disp =="Morgue (DEATH)") {
        cat <- "Mortality"

    } else if (disp =="Acute Care Facility" ||
               disp == "Burn Center" ||
               disp == "Another Type of Inpatient Facility Not Defined Elsewhere"){
        cat <- "Transfer"

    } else{
        cat <- "Home/Routine Discharge"
    }



    return(cat)
}


# ---------------------------- #
# spell checked 31 jan
