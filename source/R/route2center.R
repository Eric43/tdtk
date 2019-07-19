
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
#'     town name) to allow for geocode.  Stick to naming convention
#'     zip or name  still finalizing column names for data set.
#' @param center_name name of the center for destination of the routh
#' @param ctr_lon longitude of the center
#' @param ctr_lat latitude of the center
#' @param zip T/F on to use name (i.e. town or hopital) or zip code
#'
#' @export
#'


route2center <- function (data_set = ...,
                          center_name = NA,
                          ctr_lon = ...,
                          ctr_lat = ...,
                          zip = FALSE){
    ## add a check for center name !(is.na)
    ## add a check for names


    library(ggmap) # for geocodeing

    ## giveing a dataset with column of $name

    routes <- data.frame(...) ### just init blank data frome.

    ## Trying to allow for different route interatoins
    ## Using a hospital name center and then a from name
    ## i.e. another hospital or nursing home with a name
    ## Other option is to us a lon,lat for the hospital center
    ## and then use zipcode as route start point.
    ## next potential is to use from zip to center named
    ## finally looing at lon,lat center with zip 
    
    
    if (!(is.na(center_name) && !zip){
        routes <- mutate(route(from = data_set$name,
                               to = center_name,
                               mode = "driving",
                               structure = "route"))
    }
    else if (is.na(center_name && zip){
        routes <- mutate(route(from = data_set$name,
                               to = c("lon" = ctr_lon,
                                      "lat" = ctr_lat),
                               mode = "driving",
                               structure = "route"))
        
    }
    else if (is.na(center_name) && !zip){
        routes <- mutate(route(from = c(data_set$lon,
                                        data_set&lat),                         
                               to = center_name,
                               mode = "driving"
                               structure = "route"))
    }
    else if (!is.na(center_name) && zip)
        routes <- mutate(route(from = data_set$zip,
                               to = center_name,
                               mode = "driving",
                               structure = "route"))
    else (stop("not able to process the routes"))

    return(routes)# a datafrom of routes to be plotted
    
}

