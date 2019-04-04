
#' Clean tdtk is a function to clean up exported trauma data
#'
#' Given 
#'
#' The clean_tdtk is designed for cleaning data exported using DI
#' driller or equivelent.  It is meant to be used along with read_tdtk
#' or with the readr using standardized column names (col_names)
#'
#' @author Eric W. Olle, \email{eric.olle@@gmail.com}
#' @param data_set is the data set to be cleaned
#' @param blind is NA for no blinding or type of blinding to be called
#'     by blind_tdtk()
#' @param time_zone is the time zone of data collecion to allow for
#'     conversion of the date/time data to apprpriate type
#' @param na_rm is set to T or F depending on if the data set needs
#'     rows of NA's removed
#' @param zip_geo is T/F on if to add the zip code geo-coding data
#'
#' @return a clean and possibly blinded data set
#'
#' @examples
#'
#' @export

clean_tdtk <- function (data_set = ...,
                        blind = NA, 
                        time_zone = "EST",
                        na_rm = TRUE,
                        zip_geo = FALSE)
{
## May need to change the arr.date.time to Arr_date for consistiency


    # Main 

    if (na_rm = TRUE){
        trauma_data <- trauma_data %>% filter(Reduce(`+`, lapply(., is.na)) != ncol(.))
    }

    data_set$Arr.Date.Time <-mdy_hm(data_set$Arr.Date.Time, tz = time_zone)

    if (blind(is.na)){
        data_set <- data_set %>%
            mutate(ISS_cat = map_chr(ISS, iss_cat)) %>%
            mutate(Zip_num = as.numeric(map_chr(Zip, zip_clean))) %>%
            mutate(ICD_10grp = map_chr(ICD_10_txt, icd_cat)) %>%
            mutate(Init_disp = map_chr(ER_Disp, disp_cat)) 
                   
            

    trauma_data %>% case_when(is.na(blind)){

        } 
    

        if (zip_geo){
            
            data_set <- merge(data_set, zipcode, by='zip')
        }
        











        

case_when(is.na(blind)){
    
        


case_when(blind = 

    ISS catagory

trauma_data <- mutate(trauma_data, ISS_cat = map_chr(ISS, ISS.cat)) 

#### Extracting and adding Zip code from chr to numeric

TraumaPtsByZipCode <- mutate(TraumaPtsByZipCode, Zip.num = as.numeric(map_chr(Zip, Zip.clean)))


TraumaPtsByZipCode <- mutate(TraumaPtsByZipCode, zip = extract_numeric(Zip.num))

#Adding ICD_10 grouping (Function need to be written for ICD 10 number too)

TraumaPtsByZipCode <- mutate(TraumaPtsByZipCode, ICD_10grp = map_chr(ICD_10_txt, ICD_10.cat)) 

#### Adding Dispensation based upon intial ER visit

TraumaPtsByZipCode <- mutate(TraumaPtsByZipCode, Initial_disp = map_chr(ER_Disp, Disp.cat))

#### Merging the geocodeded zipcode data


#### Visualizing the data set

head(trauma_data, n = 4)


}

