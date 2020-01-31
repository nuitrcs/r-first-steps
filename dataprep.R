# This script subsets the full data file for the session.
# Original data downloaded from https://www.kaggle.com/c/widsdatathon2020/data

library(readr)
library(dplyr)

# Prepping the data
data_dict <- read_csv("WiDS Datathon 2020 Dictionary.csv")


gossis <- read_csv("training_v2.csv")

gossis %>%
  select(encounter_id, patient_id, hospital_id, hospital_death,
         age, bmi, elective_surgery, ethnicity, gender, height, weight,
         hospital_admit_source, icu_stay_type, icu_type, pre_icu_los_days) %>%
  write_csv("gossis_subset.csv")
