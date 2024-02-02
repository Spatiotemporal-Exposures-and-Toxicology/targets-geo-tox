# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
# library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  packages = c("GeoToxPackage", "tibble","httk","MASS","fields","ggplot2") # packages that your targets need to run
  # format = "qs", # Optionally set the default storage format. qs is fast.
  #
 
)



# Run the R scripts in the R/ folder with your custom functions:
source("my_target_funs.R")


# TODO: Need to check on internal dose calculation - not sure if the matrix algebra
# is correct
list(
  tar_target(MVN_exposures, sim_mvn_exposure()),
  tar_target(ICE_conc_resp_data, get_ice_data()),
  tar_target(hill_2param_fit, get_hill_fit(ICE_conc_resp_data)),
  tar_target(hill_model_params, extract_hill_params(hill_2param_fit)),
  tar_target(simulate_weight, get_sim_weight()),
  tar_target(simulate_age, get_sim_age()),
  tar_target(simulate_IR, simulate_inhalation_rate(simulate_age)),
  tar_target(internal_dose, calc_internal_dose(MVN_exposures,simulate_IR)), # Used GeoTox function directly (i.e. not a function wrapper)
  tar_target(chem_casrn, get_chem_casrn(ICE_conc_resp_data)),
  tar_target(sim_css, simulate_css(chem_casrn, simulate_age, simulate_weight)),
  tar_target(invitro_equivalent, calc_invitro_concentration(internal_dose, sim_css)),
  tar_target(mixture_response, calc_concentration_response(hill_model_params, invitro_equivalent)),
  tar_target(plot_mixture, plot_mix(mixture_response))
)
