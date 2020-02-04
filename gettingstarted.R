# You can find a version of this file with output and notes at:
# https://nuitrcs.github.io/r-first-steps/gettingstarted.html

# Tell R where our files are;
# Better to use Projects though to set the path;
# The r-first-steps.Rproj file is a project file
# File > Open Project... > select the .RProj file
setwd("workshop_files/")


# Read the data in and give it the name gossis;
# Data definitions in "WiDS Datathon 2020 Dictionary.csv"
# Data from: Global Open Source Severity of Illness Score (GOSSIS),
# GOSSIS Consortium at MIT, https://gossis.mit.edu/
gossis <- read.csv("gossis_subset.csv")


# run some checks on the data set
names(gossis)  # names of the variables (columns)

dim(gossis)  # number of rows, columns

View(gossis)  # open up the data viewer to see the data


# Look at key variable: hospital_death
table(gossis$hospital_death)  # count of different values

prop.table(table(gossis$hospital_death))  # proportion instead of count

# Look at gender
table(gossis$gender)


# Check for missing values across variables
summary(gossis)


# Use a package to help us summarize:
# https://github.com/dcomtois/summarytools
library(summarytools)  # normally put this at the top of your file

dfSummary(gossis)  # prints in console

view(dfSummary(gossis, valid.col = FALSE))  # Opens in Viewer pane

view(descr(gossis, transpose=TRUE, stats="common"))  # Opens in Viewer pane


# Remove rows with missing gender
gossis <- gossis[!is.na(gossis$gender),]


# Gender and Death
prop.table(table(gossis$gender, gossis$hospital_death), 
           margin=2)  # margin is how to take proportion (by column here)

ctable(gossis$gender, gossis$hospital_death)  ## from summarytools

# T-test of difference in death rate by gender:
# variable to test ~ grouping variable
t.test(gossis$hospital_death ~ gossis$gender)


# Plot
library(ggplot2)  # normally put this at the top of your file

ggplot(gossis, aes(x=hospital_death)) +  # what data and variables to use
  geom_bar()  # what type of plot to make

ggplot(gossis, aes(x=hospital_death)) +  
  geom_bar() + 
  facet_wrap(gender ~ .)  # make a separate plot for each gender


# Make a better plot

# make the two variables categorical with better labels
gossis$gender <- factor(gossis$gender, 
                        levels=c("M", "F"), 
                        labels=c("Male", "Female"))
gossis$hospital_death <- factor(gossis$hospital_death, 
                                levels=c(0, 1),
                                labels=c("No", "Yes"))

# style and label the plot
ggplot(gossis, aes(x=hospital_death)) +  
  geom_bar(aes(y=stat(prop), group=1)) +  # change to plot proportion instead of count
  facet_wrap(gender ~ .)  +
  labs(x="Patient Death", y="Proportion of Cases", title="Hospital Deaths by Gender") + # labels
  scale_y_continuous(limits = c(0,1)) +  # y-axis limits
  theme_minimal() +  # base styling
  theme(panel.grid.major.x = element_blank(),  # remove vertical grid lines
        panel.grid.minor.x = element_blank(),  # remove vertical grid lines
        strip.text = element_text(size=12, hjust=0))  # style Male and Female labels

