
library(shiny)

# User Interface Definition
shinyUI(fluidPage(
  
  # Web Interface Title.
  titlePanel("Word Prediction Algorithm"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("obs", "Enter a word to predict next probable word:"),
      
      helpText("Note: This algorithm will predict the most probable next word, using the word that the user entered."),
      
      submitButton("Prediction")
    ),
    
    mainPanel(
      h6("You enter the following word:"),
      textOutput("Original"),
      br(),
      h6("Your word has been reformated to the following:"),
      textOutput("Translated"),
      br(),
      br(),
      h3("Most Probable Next Word:"),
      div(textOutput("BestGuess"), style = "color:blue"),
      br(),
      h3("The algorithm predict the next probable word using the following data analysis:"),
      tableOutput("view")
    )
  )
))

