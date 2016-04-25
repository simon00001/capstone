# This is the Server definition of a Shiny web application.
#
# Application : Word Prediction App 
# by          : Simon Kong
# date        : 21 Apr 2016

# setwd('C:/Users/sy.kong/Documents/GitHub/shiny/capstone2')

suppressPackageStartupMessages(c(
        library(shiny),
        library(tm),
        library(stringr)))

source("./cleaning.R")

# Loading n-gram freq dictionary table for bi, tri & quad-gram data
quadData <- readRDS(file="./data/quadData.RData")
triData <- readRDS(file="./data/triData.RData")
biData <- readRDS(file="./data/biData.RData")


shinyServer(function(input, output) {
        wordPrediction <- reactive({
                text <- input$text
                textInput <- text
                textInput <- cleanText(text)
                wordCount <- length(textInput)
                wordPrediction <- nextWordPrediction(wordCount,textInput)})
        output$predictedWord <- renderPrint(wordPrediction())
        output$enteredWords <- renderText({ input$text }, quoted = FALSE)
})