# Correlated Multivariate Normal Exposure
#' sim_mvn_exposure
#'
#' @param n 
#' @param k 
#' @param seed 
#'
#' @return y_chems A multivariate normaml space-time random field
#' @export
#'
#' @examples
sim_mvn_exposure <- function(n = 1000, k = 10, seed = 1){
  
  # Correlation function for pollutants
  sigma_x <- exp(-fields::rdist(sample(1:k))/5)
  
  y_chems <- exp(mvrnorm(n,rep(0,k),sigma_x)) # correlated predictors 
  
  return(y_chems)
}

# ICE DATA
#' get_ice_data
#'
#' @return y_conc_resp ICE data split into a list by CASRN
#' @export
#'
#' @examples
get_ice_data <- function(){
  ice_conc_resp <- split(as.data.frame(geo_tox_data$ice), ~casn)
  # Let's just assume our chems are the first 10
  
  y_conc_resp <- ice_conc_resp[1:10]
  
  return(y_conc_resp)
}


# Hill Model fit
#' get_hill_fit
#'
#' @param ice_cr_data 
#'
#' @return hill model fit for each chemical
#' @export
#'
#' @examples
get_hill_fit <- function(ice_cr_data){
  
  ice_cr_data |> 
    lapply(function(df){
      fit_hill(df$logc, df$resp)
    })
}


#' get_sim_age
#'
#' @return simulated age
#' @export
#'
#' @examples
get_sim_age <- function(){
  x <- data.frame(AGEGRP = 0:18, TOT_POP = c(sum(1:18), 1:18))
  simulate_age(x)
}


#' get_sim_weight
#'
#' @param n 
#'
#' @return
#' @export
#'
#' @examples
get_sim_weight <- function(n = 1000){
  y_weight_status <- sample(c("Normal","Obese"), n, replace = TRUE, 
                            prob = c(0.7,0.3))
  return(y_weight_status)
}


