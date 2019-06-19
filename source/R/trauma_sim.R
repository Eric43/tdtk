
#' Trauma Simulation is a basic simulator of trauma data
#'
#' The goal of this function is to provide a basic simulated data for
#' use in learing TDTK.
#'
#' This function can simulate basic data from certain provided
#' estimates either obtained from state reports, census data or other
#' necessary areas.  This is currently rudimentary and used for proof
#' of concept.  Later on can write a better rejection sameling method
#' based upon trauma data.
#'
#'
#' @param n_size is the numbere of simulated pts to be generated
#' @param p_trauma is a lookup or probability tabl or sample set
#' @param rej_sample (unused) planed bayesian rejection sampling
#' @param sim_type is text of "pt", "zip", or "geocode"
#'
#'
#'
#' 
trauma_sim <- function(data_set = ...,
                       n_records = 1500,
                       rnd_col = c{"Age", "Zip", "ICD", "ISS"),
                       max_rnd = 8,
                       min_rnd = 1)
#### Currently basic funciton meant to randomize a data set
#### Ulitimate goal is to allow for this and fully sim datasets
    

{

library(dplyr) # for case when

                                        # Start with p_trauma table and guesstimate

    p_guess <- c("Mild" = 0.4,
                 "Mod" = 0.3,
                 "sev" = 0.2,
                 "prof" = 0.1) 
        
          


                                        # Main #
    ## do a basic sampling assuming lon, lat is center
    ## and that Mild/mod have lower P as further away
    ## sev and prof are uniform (but shoulb be norm'd
    ## to population density.
    


}
