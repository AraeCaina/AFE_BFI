library(shiny)
library(psych)
library(lavaan)

A <- paste0("A", 1:5)

C <- paste0("C", 1:5)

E <- paste0("E", 1:5)

N <- paste0("N", 1:5)

O <- paste0("O", 1:5)


shinyServer(function(input, output) {
  
  # Lendo o banco de dados
  data("bfi")
  # Observa o clicar do botão
  observeEvent(input$calcular, {
    
    # Cria uma lista com todos os itens selecionados
    lista_itens <- c(
      input$agreeableness,
      input$conscientiousness,
      input$extraversion,
      input$neuroticism,
      input$openness)
    
    if(input$select == "Completa"){
      db <- bfi[,1:25] # retira as variaveis indesejadas
    } else {
      db <- bfi[,lista_itens] # mantém somente os itens selecionados no checkboxgoupInput
    }
    
    # Transformando o input em texto
    #rotate <- as.character(input$rotacao) 
    
    # Faz a análise fatorial
    fit1 <- fa(db ,nfactors=input$fatores, cor="poly", rotate = input$rotacao)

    # Primeira
    output$primeira <- renderPrint({
      
      print(fit1,sort=FALSE)
    })
    
    # Erro residual
    output$erro <- renderPrint({
      psi <- round(fit1[["residual"]],2)#
      head(psi)
    })
    

    # Cálculo dos alpha

    output$alpha_agreeableness <- renderPrint({
      if(input$select == "Completa"){
        summary(psych::alpha(db[,agreeableness]))
      } else {
        summary(psych::alpha(db[,input$agreeableness]))
      }
    })
    
    output$alpha_conscientiousness <- renderPrint({
      if(input$select == "Completa"){
        summary(psych::alpha(db[,conscientiousness]))
      } else {
        summary(psych::alpha(db[,input$conscientiousness]))
      }
    })
    
    output$alpha_extraversion <- renderPrint({
      if(input$select == "Completa"){
        summary(psych::alpha(db[,extraversion]))
      } else {
        summary(psych::alpha(db[,input$extraversion]))
      }
    })
    
    output$alpha_neuroticism <- renderPrint({
      if(input$select == "Completa"){
        summary(psych::alpha(db[,neuroticism]))
      } else {
        summary(psych::alpha(db[,input$neuroticism]))
      }
    })
    
    output$alpha_openness <- renderPrint({
      if(input$select == "Completa"){
        summary(psych::alpha(db[,openness]))
      } else {
        summary(psych::alpha(db[,input$openness]))
      }
    })
    
   })
})
