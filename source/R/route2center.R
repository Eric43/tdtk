
#' Route(s) to center to show routes to center point
#'
#' The goal of this function is to provide a basic overlay of the
#' simulated routes taken to the trauma center to show patient travel
#' distrvutions.
#'
#' This function was inspired by the maps generated in the South
#' Carolina Trauma Center state report and provides and excellent
#' graphic overview of the patients travel needs in rewlationship to
#' the center.  In addition when combined with the center2circle.R
#' function can show how many our outside the estimated ground travel
#' time of 1 hr usign a 45 m radius circle.
#'
#' @param data_set is a single or collection geo_ids (i.e. zip code r
#'     town name) to allow for geocode
#'
#' 
#' @param center_name longitude of center for tdtk the center would be
#'     the final hospital (LV I or II for tertirary care)
#'
#' @export
#'


route2center <- function (data_set = ...,
                          center_name = NA){
    ## add a check for center name !(is.na)
    ## add a check for names


    library(ggmap) # for geocodeing

    routes <- data.frame(name = data_set$name)
    
    routes <- mutate(route(from = routes$name,
                           to = center_name,
                           mode = "driving",
                           structure = "route"))

    return(routes)
}

