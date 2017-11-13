#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shinydashboard)
library(shinyjs)

dashboardPage(
dashboardHeader(title = "Social Media Job App"),
dashboardSidebar(
  selectInput("dataset","Select Dataset:", c("Twitter Local","Twitter Api")),
  numericInput("num_tweets", "Number of Tweets:", 100),
  actionButton("btn_run", "Run")
),
dashboardBody(
  fluidRow(
       box(plotOutput("distPlot")),
       box(plotOutput("wordcloud"))
      ),
  fluidRow(
    box(plotOutput('chart')),
    box(dataTableOutput('my_table'))
  )
    )
  )
