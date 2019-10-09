library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(dplyr)
library(caret)
library(e1071)
library(partykit)
require(ggplot2)
library(ggmosaic)
library(Metrics)
library(ggthemes)


heart <- read.csv("heart_disease_dataset.csv")



heart <- heart %>% 
  mutate(disease=factor(disease, level=c(0,1), labels=c("yes", "no")),
         sex=factor(sex, level=c(0,1), labels=c("female", "male")),
         cp=factor(cp, level=c(1,2,3,4), labels=c("typical angina","atypical angine","non-anginal pain","asymptomatic")),
         fbs=factor(fbs, level=c(0,1), labels=c("otherwise","> 120 mg/dl")),
         restecg=factor(restecg, level=c(0,1,2), labels=c("normal", "abnormality", "hypertrophy")),
         exang=factor(exang, level=c(0,1), labels=c("no", "yes")),
         
         slope=factor(slope, level=c(1,2,3), labels=c("upsloping", "flat", "downsampling")),
         
         ca=as.factor(ca),
         thal=factor(thal, level=c(3,6,7), labels=c("normal", "fixed defect", "reversable defect")))


t <- list(
  family = "sans serif",
  size = 14,
  color = 'blue')

selectX <- names(heart)
selectY <- names(heart)

selectSex <- sort(unique(heart$sex))
selectCP <- sort(unique(heart$cp), decreasing = F)
selectFbs <- sort(unique(heart$fbs), decreasing = F)
selectRestecg<- sort(unique(heart$restecg), decreasing = F)
selectExang<- sort(unique(heart$exang), decreasing = F)
selectSlope<- unique(heart$slope)
selectCa<- sort(unique(heart$ca), decreasing = F)
selectThal<- sort(unique(heart$thal), decreasing = F)

library(rsample)
set.seed(765)
idx <- initial_split(data = heart, prop = 0.80, strata = "disease")
heart_train <- training(idx)
heart_test <- testing(idx)

##,##
model_bayes <- readRDS("model_bayes_save.rds")
bayes_pred <- predict(model_bayes, heart_test)
cm_bayes <- confusionMatrix(bayes_pred, heart_test$disease, positive = "yes")


model_tree <-readRDS("model_tree_save.rds")

tree_pred <- predict(model_tree, heart_test)
cm_tree <- confusionMatrix(tree_pred, heart_test$disease, positive = "yes")

# bayes_predict <- predict(model_bayes, newdata = data.frame(age,sex,cp, trestbps, chol, fbs, restecg, thalach, exang, oldpeak, slope, ca, thal))

# tree_predict <- predict(model_tree, newdata = data.frame(age,sex,cp, trestbps, chol, fbs, restecg, thalach, exang, oldpeak, slope, ca, thal))
selectSex <- unique(heart$sex)