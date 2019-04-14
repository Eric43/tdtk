#' Catagorizes a basic bins for grouping and report generation
#'
#' Original function was designed for pediatric age binning this
#' iteration will look at all but subdivision of the pediatric
#' population will depend on the type of center.
#'
#' Very basic function at this point need verification of adult bins.
#' age cut-off recommendations and attempt to have large enough bin
#' cohort size to decrease probability of individual determination.
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
#' @references \url{https:\\ <Enter git hub or other reference>}
#' @seealso \code{\link{age_catagory_old.R}}
#' @keywords age, acs
#'
#' @param age is a patient age number of year in decimal
#' @param age_group is a text valuse for "adult, combo, blind or peds"
#'
#' @return returns the age bin.
#'
#' @examples \dontrun{
#'
#'> age_cat(22)
#'#[1] "20's"
#'
#'> age_cat(44)
#'#[1] "40's"
#'
#'> age_cat(44, age_group = "blind")
#'#[1] "18 to under 60"
#'
#'> age_cat(44, age_group = "combo")
#'#[1] "40's"
#'
#'}
#'
#'
#'
#' @export


                                        # ---------------------------- #

# Age catagorization

age_cat <- function (age = 0,
                     age_group = "adult" ){

                                        # Packages

    library(dplyr) # for case_when()

                                        # Main function

    if (age_group == "peds"){
        cat <-  case_when(
            age %in% 0.0:4.9 ~ "0 to 4.9",
            age %in% 5.0:12.9 ~ "5 to 12.9",
            age %in% 13.0:17.9 ~ "13 to 17.9"
            age %in% 18.0:120 ~ "not pediatric") #17.9 or 18???
    }
    else if (age_group == "combo"){
        cat <- case_when(
            age %in% 0.0:4.9 ~ "0 to 4.9",
            age %in% 5.0:14.9 ~ "5 to 14.9",
            age %in% 15.0:19.9 ~ "15 to 19.9",
            age %in% 20.0:29.9 ~ "20's",
            age %in% 30.0:39.9 ~ "30's",
            age %in% 40.0:49.9 ~ "40's",
            age %in% 50.0:59.9 ~ "50's",
            age %in% 60.0:59.9 ~ "60's",
            age %in% 60.0:69.9 ~ "70's",
            age %in% 80.0:120 ~ "Over 80")
    }
    else if (age_group == "adult"){
        cat <- case_when(
            age %in% 0.0:4.9 ~ "0 to 4.9",
            age %in% 5.0:12.9 ~ "5 to 12.9",
            age %in% 13.0:19.9 ~ "13 to 19.9",
            age %in% 20.0:29.9 ~ "20's",
            age %in% 30.0:39.9 ~ "30's",
            age %in% 40.0:49.9 ~ "40's",
            age %in% 50.0:59.9 ~ "50's",
            age %in% 60.0:59.9 ~ "60's",
            age %in% 60.0:69.9 ~ "70's",
            age %in% 80.0:120 ~ "Over 80")
    }
    else if (age_group == "blind"){
        cat <-  case_when(
            age %in% 0.0:17.9 ~ "Under 18",
            age %in% 18:59.9 ~ "18 to under 60",
            age %in% 60:120 ~ "Over 60")
    }


    return(cat)

}



