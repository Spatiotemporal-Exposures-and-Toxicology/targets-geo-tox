# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
# library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  packages = c("GeoToxPackage", "tibble","httk","MASS","fields") # packages that your targets need to run
  # format = "qs", # Optionally set the default storage format. qs is fast.
  #
 
)



# Run the R scripts in the R/ folder with your custom functions:
source("my_target_funs.R")

# source("other_functions.R") # Source other scripts as needed.

# Replace the target list below with your own:
list(
  tar_target(MVN_exposures, sim_mvn_exposure()),
  tar_target(ICE_conc_resp_data, get_ice_data()),
  tar_target(hill_2param_fit, get_hill_fit(ICE_conc_resp_data)),
  tar_target(hill_model_params, extract_hill_params(hill_2param_fit)),
  tar_target(simulate_weight, get_sim_weight()),
  tar_target(simulate_age, get_sim_age()),
  tar_target(simulate_IR, simulate_inhalation_rate(simulate_age))
)
