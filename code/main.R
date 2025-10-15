########################
######### MAIN #########
########################

# This file manages all the separate files and serves as a main file setting up the infrastructure

# 0. Set-up ---------------------------------------------------------------

# packages used/needed

libs <- c(
  # General #
  "dplyr",        
  "tidyr", 
  "ggplot2",
  
  # Data manipulation #
  "data.table",   # backbone of the workflow
  "ipumsr",       # download CPS data
  "haven",        # read CEX files (.dta/.sas7bdat)
  "janitor",      # clean variable names
  "stringr",      # string operations
  "lubridate",    # date handling
  
  # EDA #
  "fixest"        # regression / local projections later
)

# Load each library quietly
invisible(lapply(libs, function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
  suppressPackageStartupMessages(library(pkg, character.only = TRUE))
}))


# 1. Data import and manipulation -----------------------------------------

source("1_data_manip.R")
