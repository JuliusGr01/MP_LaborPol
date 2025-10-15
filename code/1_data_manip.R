########################################
######### 1. Data Manipulation #########
########################################


# 1.1 Importing IPUMS-CPS  ------------------------------------------------

# set IPUMS key & define CPS-ORG extract

# ipumsr::set_ipums_api_key("59cba10d8a5da536fc06b59dbd6733bf3d664f87aed7f89c71d49510", save = TRUE)

full_sample <- get_sample_info(collection = "cps")

# setting the right sample
samples_basic <- full_sample %>%
  filter(!str_detect(description, "ASEC")) %>%   # keep only Basic Monthly (drop ASEC)
  pull(name)

us_def <- define_extract_micro(
  collection  = "cps",
  description = "CPS Basic Monthly for employment–MP response",
  samples = samples_basic,
  variables   = c(
    "YEAR","MONTH","AGE","EMPSTAT",
    "OCC2010","OCC","WTFINL",
    "SEX","EDUC","STATEFIP"   # optional controls
  )
)

# submitting the extract and downloading when ready
us_sub   <- submit_extract(us_def)       # queues the job on IPUMS
us_sub <- wait_for_extract(us_sub)
us_files <- download_extract(us_sub)     # downloads .dat + .xml when ready

# reading the data
cps <- read_ipums_micro(us_files) |> as.data.table()



# 1.2 Adding RTI from Author and D. ---------------------------------------


