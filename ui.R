# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
# Application : Word Prediction App Interface 
# by          : Simon Kong
# date        : 21 Apr 2016

# setwd('C:/Users/sy.kong/Documents/GitHub/shiny/capstone2')

suppressPackageStartupMessages(c(
        library(shiny),
        library(tm),
        library(stringr)))

shinyUI(pageWithSidebar(
  # Application title
  headerPanel("Word Prediction Application","Data Science Capstone Project"),
  sidebarPanel(
    wellPanel(
      textInput('text', "Type Your Words",""),
      h5('Please press \'Submit\' to see the word prediction result.'),
      h5('(Example:\'i am looking\' or \'hope to see\')'),
      actionButton("submit","Submit")
    )
  ),
  
  mainPanel(
    h3('Word Prediction Result'),
    h5('The main objective of application is to predict the next word likely to come next.
       Please allow around 15 seconds for the app to load.
       Wait a few seconds after submit your words. Input only English words.'),
    h4('You had entered'),
    verbatimTextOutput("enteredWords"),
    h4('Predicted next word:'),
    verbatimTextOutput("predictedWord"),
    h5('Thank you and hope your enjoy using the simple application'),
    h5('Additional document can be found at https://rpubs.com/simon00001/')
    )
  )
)