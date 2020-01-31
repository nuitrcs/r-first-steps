# Exercise Answers

# load library
library(ggplot2)

# Load the data
gossis <- read.csv("gossis_subset.csv")


# Average of the height variable:
# na.rm = exclude missing values in computing the mean
mean(gossis$height, na.rm=TRUE)  

# YOUR TURN: take the average of the age variable:
mean(gossis$age, na.rm=TRUE) 


# Correlation between age and BMI?
# use="pairwise.complete" means to only compute based on observations where 
# neither variable is missing
cor(gossis$age, gossis$bmi, use="pairwise.complete")

# YOUR TURN: compute the correlation between height and weight
cor(gossis$height, gossis$weight, use="pairwise.complete")


# YOUR TURN: Death and Ethnicity
# Look back at the sesion materials.  
# Make a table of gossis$hospital_death with gossis$ethnicity
table(gossis$ethnicity, gossis$hospital_death)

# YOUR TURN: make the same table above with proportions instead.
# HINT: prop.table()
prop.table(table(gossis$ethnicity, gossis$hospital_death), margin=1)

# YOUR TURN: check which proportions you computed above (row, column, overall)
# Make sure you used an appropriate setting for comparing across ethnic groups
# margin=0 is entire table
# margin=1 is rows
# margin=2 is columns

# Used margin=1 above because have ethnicity in the rows


# YOUR TURN: Make a scatter plot of height and weight
# Replace ___ with the names of the variables
ggplot(gossis, aes(x=height, y=weight)) + 
  geom_point()


# Hmm, not very helpful.  Let's try something better:
# Fill in the variables again
ggplot(gossis, aes(x=height, y=weight)) + 
  geom_hex()

