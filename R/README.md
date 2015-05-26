# R wrapper for ForecastThis models

## Installation
1. Download [the latest R wrapper release](https://github.com/jacek-rzrz/ForecastThisModels/releases/download/1.0.0/ForecastThisModels-R-1.0.0.tar.gz)
2. Install the wrapper package by executing `R CMD INSTALL ForecastThisModels-R-1.0.0.tar.gz` in your terminal or open Rstudio and click `Tools -> Install Packages...`, select `Install from: Package Archive File (.tar.gz)` and point to the downloaded file.

## System requirements
1. R (>= 3.0.0)
2. Java Runtime Environment (>= 8)

## Troubleshooting
1. Predictions fail with `Unsupported major.minor version 52.0`
This means R is using a JRE/JDK version older than 8. Make sure Java 8 is installed on you machine and reconfigure R by executing this command: `R CMD javareconf`

## Quickstart
Assuming that you have downloaed model.jar and you would like to make predictions for data from data.csv, this R code should get you started:
```
require(ForecastThis)

data <- read.csv('data.csv', stringsAsFactors=F, sep=",")
model <- 'model.jar'
predictions <- predict(data, model)
```
Note: you may need to tweak `read.csv` arguments to help R parse your data correctly!

Explore more inside Rstudio: `??ForecastThis`
