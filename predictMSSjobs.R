
# Load Libraries ----------------------------------------------------------


library(dplyr)
library(caret)


# Load Model --------------------------------------------------------------


load("mss.RData")




# Test Data Format--------------------------------------------

#Required data format

#          remedy_customer_id           industry      rule_name      src_geo    dst_geo                 event_vendors
#         JPID000969        Financial Services     ProbesAndScans      JP      JP        IBM Internet Security Systems


# Data Cleaning -----------------------------------------------------------


#where ever there is a ',' in the src_geo- means there are multiple regions for origination of attack
#first convert the field to character

newdata$src_geo=as.character(newdata$src_geo)

#find entries with ',' in between

commarecords=grep(",",x = newdata$src_geo)

#replace all of these enteries by 'multiple'

newdata$src_geo[commarecords]="MULTIPLE"


#put the src_geo back as factor

newdata$src_geo=factor(newdata$src_geo)

#work similarly on the destination geo

#where ever there is a ',' in the dst_geo- means there are multiple regions for origination of attack

#first convert the field to character

newdata$dst_geo=as.character(newdata$dst_geo)

#find entries with ',' in between

commarecords=grep(",",x = newdata$dst_geo)

#replace all of these enteries by 'multiple'

newdata$dst_geo[commarecords]="MULTIPLE"

#convert all predictors to factor

newdata$dst_geo=factor(newdata$dst_geo)
newdata$event_vendors=as.factor(newdata$event_vendors)
newdata$rule_name=as.factor(newdata$rule_name)
newdata$remedy_customer_id=as.factor(newdata$remedy_customer_id)
newdata$industry=as.factor(newdata$industry)


# Create Sample Record  ---------------------------------------------------


newdata=testalert[sample(nrow(testalert),1,replace = FALSE),]

#this sample test data will be used for predictions

# Run Prediction Algorithm ------------------------------------------------


suppressPackageStartupMessages(analyst.suggest(newdata))

#we have to build rules around the prediction analysis for creating a recommendation engine