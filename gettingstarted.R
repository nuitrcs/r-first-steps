
# Read the data in
gossis <- read.csv("gossis_subset.csv")


# run some checks
names(gossis)

dim(gossis)

View(gossis)


# Look at key variable: hospital_death
table(gossis$hospital_death)

prop.table(table(gossis$hospital_death))

# Look at gender
table(gossis$gender)


# Check for missing values across variables
summary(gossis)


# Use a package to help us summarize:
library(summarytools)  # normally put this at the top of your file

dfSummary(gossis)

view(dfSummary(gossis, valid.col = FALSE))

view(descr(gossis, transpose=TRUE, stats="common"))


# Remove rows with missing gender
gossis <- gossis[!is.na(gossis$gender),]


# Gender and Death
prop.table(table(gossis$gender, gossis$hospital_death), margin=2)

ctable(gossis$gender, gossis$hospital_death)  ## from summarytools

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

