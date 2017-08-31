options(shiny.maxRequestSize=30*1024^2)

library(shiny)
library(data.table)
library(NLP)
library(tm)

# Define server configuration
shinyServer(function(input, output) {    
  # Dataset Summary
  output$Original <- renderText({
    Original_Input <- input$obs
    return(Original_Input)
  })
  
  # Step 1
  output$Translated <- renderText({
    Original_Input <- input$obs
    Translated_Input <- Translate_Input(Original_Input)
    return(Translated_Input)
  })
  
  # Step 2
  output$BestGuess <- renderText({
    Original_Input <- input$obs
    Translated_Input <- Translate_Input(Original_Input)
    BestGuess_Output <- "Next word predicted"
    Split_Trans_Input <- Split_Translate_Input(Original_Input)
    Word_Count <- length(Split_Trans_Input)
    
    if(Word_Count==1){
      BestGuess_Output <- Word_Count1(Split_Trans_Input)
    }
    if(Word_Count==2){
      BestGuess_Output <- Word_Count2(Split_Trans_Input)
    }
    if(Word_Count==3){
      BestGuess_Output <- Word_Count3(Split_Trans_Input)
    }
    if(Word_Count > 3){
      Words_to_Search <- c(Split_Trans_Input[Word_Count - 2],
                           Split_Trans_Input[Word_Count - 1],
                           Split_Trans_Input[Word_Count])
      BestGuess_Output <- Word_Count3(Words_to_Search)
    }
    return(BestGuess_Output)
  })
  
  # Display "n" observations
  output$view <- renderTable({
    Original_Input <- input$obs
    Split_Trans_Input <- Split_Translate_Input(Original_Input)
    Word_Count <- length(Split_Trans_Input)
    
    if(Word_Count==1){
      BestGuess_Output <- Word_Count1(Split_Trans_Input)
    }
    if(Word_Count==2){
      BestGuess_Output <- Word_Count2(Split_Trans_Input)
    }
    if(Word_Count==3){
      BestGuess_Output <- Word_Count3(Split_Trans_Input)
    }
    if(Word_Count > 3){
      Words_to_Search <- c(Split_Trans_Input[Word_Count - 2],
                           Split_Trans_Input[Word_Count - 1],
                           Split_Trans_Input[Word_Count])
      BestGuess_Output <- Word_Count3(Words_to_Search)
    }
    
    if(exists("AlternativeGuess", where = -1)){
      AlternativeGuess
    }else{
      XNgramsTable <- data.frame(Word=NA, Likelihood=NA)
    }
    
  })
})

