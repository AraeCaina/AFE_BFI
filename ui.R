library(shiny)
library(shinydashboard)

A <- paste0("A", 1:5)

C <- paste0("C", 1:5)

E <- paste0("E", 1:5)

N <- paste0("N", 1:5)

O <- paste0("O", 1:5)
  
dashboardPage(
  dashboardHeader(title = 'AFE - BFI'),
  # Sidebar ----
  dashboardSidebar(
    br(), # pula linha
    # Checkbox dos fatores
    box( # Caixa
      title = "Agreeableness",
      background = "black",
      collapsible = TRUE,
      collapsed = TRUE, # Iniciar com ele fechado
      width = 12, # largura
      checkboxGroupInput(
        inputId = "agreeableness",
        label = "",
        choices = A,
        selected = A
      )
    ),
    box(
      title = "Conscientiousness",
      background = "black",
      collapsible = TRUE,
      collapsed = TRUE,
      width = 12,
      checkboxGroupInput(
        inputId = "conscientiousness",
        label = "",
        choices = C,
        selected = C
      )
    ),
    box(
      title = "Extraversion",
      background = "black",
      collapsible = TRUE,
      collapsed = TRUE,
      width = 12,
      checkboxGroupInput(
        inputId = "extraversion",
        label = "",
        choices = E,
        selected = E
      ),
    ),
    box(
      title = "Neuroticism",
      background = "black",
      collapsible = TRUE,
      collapsed = TRUE,
      width = 12,
      checkboxGroupInput(
        inputId = "neuroticism",
        label = "",
        choices = N,
        selected = N
      )
    ),
    box(
      title = "Openness",
      background = "black",
      collapsible = TRUE,
      collapsed = TRUE,
      width = 12,
      checkboxGroupInput(
        inputId = "openness",
        label = "",
        choices = O,
        selected = O
      )
    ),
    actionButton("calcular", "Pronto para análise!")
  ),
  # Body ----
  dashboardBody(
    fluidRow(
      column(4,
       selectInput(
          "select",
          label = "Utilizar qual base para análise?", 
          choices = c("Completa", "Parcial"), 
          selected = "Completa"
        )
      ),
      column(4,
        selectInput(
          "rotacao",
          label = "Qual rotação?", 
          choices = c("none", "varimax", "oblimin"), 
          selected = "none"
        )
      ),
      column(4,
        sliderInput(
          "fatores",
          label = "N fatores",
          min = 1, 
          max = 10,
          value = 5)
      )
    ),
    fluidRow(
      tabBox(width = 12,
        tabPanel(
          "Completa",
          verbatimTextOutput("primeira")
        ),
        tabPanel(
          "Erro",
          verbatimTextOutput("erro")
        ),
        tabPanel(
          "Alpha de Cronbach",
          h3("Agreeableness"),
          verbatimTextOutput("alpha_agreeableness"),
          h3("Conscientiousness"),
          verbatimTextOutput("alpha_conscientiousness"),
          h3("Extraversion"),
          verbatimTextOutput("alpha_extraversion"),
          h3("Neuroticism"),
          verbatimTextOutput("alpha_neuroticism"),
          h3("Openness to experience"),
          verbatimTextOutput("alpha_openness")
        )
      )
    )
  )
)