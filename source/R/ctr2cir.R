
#' Center to circle function basic (ctr2cir)
#'
#' Given a data from or an data set of at least 1 to extract the lon
#' lat and add a ID.  Then the placement of 1-360 degrees around the
#' radius is calculated using the geosphere package.
#'
#' The ctr2cir function differs from the center2circle function in
#' that its more of a minimalist function that just returns a data
#' frame and group ID of the circle points from the lon, lat, radius
#' (rad) and unit of measurement for the radius.  This function is
#' basically the Stack Overflow code.
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
#'
#' @param data.set  Data set that contains at a minimum a lon & lat columns
#' @param rad  radius in miles, meters or kilometers
#' @param unit  unit of measure of the radius
#'
#' @return returns a data frame ID = N in data frame lon and lat of the points of the circle
#'
#' 
#' @export

ctr2cir <- function(data.set = ...,
                    rad = 45,
                    unit = "mi")
{

    library(geosphere)
    library(dplyr) # ? %>% or is margiritrr? I can never get that one right
    

    redius_convert <- function(radius, measure){
#### the goal of this function is to take radius measurements and convert to meters
#### this to allow for calculation of point placment on radius in meters


        mile2meter <- 1609.34 #multiple miles to equal meters m/mi
        feet2meter <- 0.304799242419 #multiple feet to get meters  m/ft
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




##### Map circle functions ####

fn_circle <- function(ID, lon1, lat1, radius){ 

### Code from stackoverflow. Thank you! Last answer was the best.

    data.frame(ID, degree = 1:360) %>%
        rowwise() %>%
        mutate(lon = destPoint(c(lon1, lat1), degree, radius)[1]) %>%
        mutate(lat = destPoint(c(lon1, lat1), degree, radius)[2])
}



  ##################### main ####################

                                        # Making data set
    
    data <- data.set %>%
        filter(!is.na(lon)) %>%
        mutate("ID" = 1:nrow()) %>%
        select(ID, lon, lat)


        
        circle <- apply(data, 1, function(x) fn_circle(x[1],
                                                       x[2],
                                                       x[3],
                                                       radius_convert(radius = rad, measure = unit)))

        circle <- do.call(rbind, circle)

  return(circle)

}
