
#' Center to circle function list (center2circle)
#'
#' Given a data from or an data set of at least 1 to extract the lon
#' lat and add a ID.  Then the placement of 1-360 degrees around the
#' radius is calculated using the geosphere package.  The information
#' is then placed into a list and then returned.
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
#' @references \url{https://stackoverflow.com/questions/34183049
#' /plot-circle-with-a-certain-radius-around-point-on-a-map-in-ggplot2}
#' @references add geosphere reference
#' @seealso \code{\link{ctr2cir}}
#'
#' @param lon is the longitude of the center
#' @param lat is the latitude of the center
#' @param name is a basic unique id that can be name or number used
#'     for group id
#' @param geo_id is the name use to look up the lon, lat via geo code
#' @param rad is the radius of the circle
#' @param unit unit of measure of the radius
#'
#' @seealso \code{ctr2cir.R}
#'
#' @return returns a list with necessary attributes and the data frame of circle points
#'
#' @examples/donotrun{
#' #Do not run
#' using wv_trauma.csv
#' 
#' circle.60 <- ctr2cir(data.set = wv_trauma, rad = 60, unit = "mi")
#'
#' # Running with lapply
#' 
#' #XXX ADD!!!!
#' 
#' #End not run
#' 
#'}
#' @export

###############################################

center2circle <- function(lon = NA,
                          lat = NA,
                          name = NA,
                          geo_id = NA,
                          rad = ...,
                          unit = ...){
   


#### This function to convert center and radius to circumference of circle
#### was created by using the code from stack overflow.


                                        # required packages

     library(geosphere)

                                        # Functions


                                        #  Conversion function


    redius_convert <- function(radius, measure){
#### the goal of this functin is to take radisu measurements and convert to meters
#### this to allow for calucatioon of radius


    mile2meter <- 1609.34 #multiple miles to equal meters m/mi
    feet2meter <- 0.304799242419 #multipley feet to get meters  m/ft
    km2meter <- 1000 #multiply by km to get m m/km

                                        # conversion

        if  (measure == "m"){
            conv <- radius
        }

        else if (measure == "km"){
            conv <- km2meter * radius
        }
        else if ( measure == "mi"){
            conv <- mile2meter * radius
        }
                                        # return the converted value
        return(conv)

    }

#### End conversion

                                        # Internally required function or fn_circle

    fn_circle <- function(name, lon1, lat1, radius){

####  Stack overflow code used here....Thank you! Last answer was best.

        data.frame(name, degree = 1:360) %>%
            rowwise() %>%
            mutate(lon = destPoint(c(lon1, lat1), degree, radius)[1]) %>%
            mutate(lat = destPoint(c(lon1, lat1), degree, radius)[2])
    }



#### End Functions



#### Start of center2circle function ####

                                        # set basic data structure

      circle_list <- list("name" = name,
                          "geo_id" = geo_id,
                          "lon" = lon,
                          "lat" = lat,
                          "rad" = rad,
                          "unit" = unit,
                          "circle" = data.frame())


                                        # Main Function


    circle_list[["circle"]] <- fn_circle(name, lon, lat, radius = redius_convert(radius = rad, measure = unit))

    return(circle_list)

}

                                        #_________________________________#

#spell checked 31 jan
