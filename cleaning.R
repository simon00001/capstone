# This is module for a Shiny web application.
#
# Application : Word Prediction module 
# by          : Simon Kong
# date        : 21 Apr 2016

suppressPackageStartupMessages(c(
        library(shiny),
        library(tm),
        library(stylo),
        library(stringr)))

# Loading N-gram for bi, tri and four-gram table
quadData <- readRDS(file="./data/quadData.RData")
triData <- readRDS(file="./data/triData.RData")
biData <- readRDS(file="./data/biData.RData")

# Cleaning model for input text text pre-processing before calling predict module
dataCleaner<-function(text){
        cleanText <- tolower(text)
        cleanText <- removePunctuation(cleanText)
        cleanText <- removeNumbers(cleanText)
        cleanText <- str_replace_all(cleanText, "[^[:alnum:]]", " ")
        cleanText <- stripWhitespace(cleanText)
        return(cleanText)
}

# cleaning module for input text as English text
cleanText <- function(text){
        textInput <- dataCleaner(text)
        textInput <- txt.to.words.ext(textInput, 
                                      language="English.all", 
                                      preserve.case = TRUE)
        
        return(textInput)
}

# Prediction next word module pre-formating before processing
nextWordPrediction <- function(wordCount,textInput){
        # if sentences more or equal to 3 words, take the last 3 words for prediction
        if (wordCount>=3) {
                textInput <- textInput[(wordCount-2):wordCount] 
        }
        else if(wordCount==2) {
                textInput <- c(NA,textInput)   
        }
        else {
                textInput <- c(NA,NA,textInput)
        }
        
        
# Word prediction main module call 
# If no word prediction found in Quad-gram table, then back-off call to tri-gram, follows by bi-gram
  
        wordPrediction <- as.character(quadData[quadData$unigram==textInput[1] & 
                                                          quadData$bigram==textInput[2] & 
                                                          quadData$trigram==textInput[3],][1,]$quadgram)
        
        if(is.na(wordPrediction)) {
                wordPrediction1 <- as.character(triData[triData$unigram==textInput[2] & 
                                                                   triData$bigram==textInput[3],][1,]$trigram)
                
                if(is.na(wordPrediction)) {
                        wordPrediction <- as.character(biData[biData$unigram==textInput[3],][1,]$bigram)
                }
        }
        print(wordPrediction)
        
}