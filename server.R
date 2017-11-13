#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(tidytext)
library(SnowballC)
library(wordcloud)
library(stringr)

source("R/twitter_search.R")
source("R/load_datasets.R")

# Define server logic required to draw a histogram
shinyServer(function(session, input, output) {
  
  updateSelectizeInput(session, 'job_titles', choices = unique(job_titles$title), server = TRUE)
  
  data <- eventReactive(
    input$btn_run,
    if(input$dataset == 'Twitter Local'){
      provided_data
    } else {
      search_tweets("Job Vacancy", n = input$num_tweets, token = twitter_token, type = "mixed")
    }
  )
  
  data_mut <- reactive({
    url_pattern <- "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"
    
    temp_data <- data()
    
    temp_data %>%
      mutate(ContentURL = str_extract(text, url_pattern)) %>%
      mutate(text = gsub(url_pattern,"", text, ignore.case= TRUE, perl = TRUE)) 
  })
  
  wc_data <- reactive({
    data_mut() %>%
      select(status_id,text) %>%
      na.omit %>%
      unnest_tokens(word, text) %>%
      anti_join(stop_words, by = "word") %>%
      mutate(word = wordStem(word)) %>%
      distinct %>%
      group_by(word) %>%
      tally %>%
      ungroup %>%
      arrange(desc(n)) %>% 
      filter(word != "job")
  }
  )
  
  output$chart <- renderPlot(
    {
      
      job_titles %>% 
        mutate(jtproc = wordStem(jtproc)) %>% 
        left_join(wc_data(), ., by=c("word" = "jtproc")) %>% 
        na.omit() %>%
        group_by(title) %>% 
        summarise(n_title = n()) %>% 
        ungroup %>%
        arrange(desc(n_title)) %>%
        .[1:10,] %>%
        ggplot(aes(x=title, y = n_title)) +
        geom_bar(stat = "identity") +
        coord_flip() +
        theme_bw() + 
        xlab("Job Description") +
        ylab("Count") +
        ggtitle("Top 10 Job Categories in Tweets")
    }
  )
  
  output$distPlot <- renderPlot({
    ggplot()
  })
  
  output$distPlot <- renderPlot({
    
    # create data frame
    rt <- data_mut() %>%
      mutate(created_at = as.Date(created_at,format = "%d/%m/%Y")) %>%
      group_by(created_at) %>%
      summarise(ntweets=n()) 
  
    # draw the histogram with the specified number of bins
    ggplot(rt, aes(x=created_at, y=ntweets)) +
        geom_point() +
        geom_line()+
        ggtitle("Time series of Tweets") +
        xlab("Tweet date")+
        ylab("No of tweets") 
      
    
  })

  output$wordcloud <- renderPlot({
    wordcloud(wc_data()$word,wc_data()$n, min.freq = 1, max.words= 100)
  })
  
  
  output$my_table <- renderDataTable({
    
    # create data frame
    temp_100 <- data_mut() 
    
    temp_100 %>%
      select(Link = ContentURL, Tweet = text, Time = created_at)
    
  }, options = list(pageLength = 4))
  
  
})
