
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
trauma_sim <- function(n_size = 2000,
                       p_trauma = ..., # a look up table of trauma P's
                       rej_sample = FALSE,
<<<<<<< HEAD
                       sim_type = "pt",
                       lon = ...,
                       lat = ...) # pt = patient
=======
                       sim_type = "pt")
>>>>>>> 2a71c7fbd531a6aa74fa75ff756f09d778662ac7
{

library(dplyr) # for case when

                                        # Start with p_trauma table and guesstimate

    p_guess <- c("Mild" = 0.4,
                 "Mod" = 0.3,
                 "sev" = 0.2,
                 "prof" = 0.1) 
        



                                        # Main #
    
    

}
