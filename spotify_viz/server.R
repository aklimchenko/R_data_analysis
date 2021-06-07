# Server Logic for spotify visualization

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # function to get the foreign market
    pull_market <- reactive({
        foreign_markets %>%
        filter(market_code == input$market_code, popularity >=10) %>%
        arrange(desc(popularity))
    })
    
    # function to show box plot
    output$market_code <- renderPlot(
        pull_market() %>% mutate( bin=cut_width(popularity, width=10, boundary=0)) %>%
            ggplot( aes(x=bin, y=followers) ) +
            geom_boxplot(color = "black", fill="#1DB954") +
            theme(panel.grid.minor = element_line(colour="white", size=0.5)) +
            theme(panel.grid.major = element_line(colour="#191414", size=0.5)) +
            #  theme(panel.background = element_rect(fill = "#191414"))
            scale_y_continuous(trans='log10') +
            xlab("Popularity") +
            ylab("Followers")
    )  
    
    # display the market table
    output$table <- renderDataTable(artists %>%
        filter(market_code == input$market_code))
    
})    
    
'''    
    artists_delay <- reactive({
        artists %>%
            filter(origin == input$origin & foreign == input$foreign) %>% 
            group_by(popularity) %>%
            summarise(n = n(),
                      # number of times artist appears in the foreign market
                      departure = mean(dep_delay),
            )
    })
    
    
    output$count <- renderPlot(
        artists_delay() %>%
            ggplot(aes(x = popularity, y = n)) +
            geom_col(fill = "lightblue") +
            ggtitle("Number of foreign markets")
    )
    
    
    output$delay <- renderPlot(
        
        artists_delay()  %>% pivot_longer(
            arrival:departure,
            names_to = "Artist",
            values_to = "delay"
        ) %>% ggplot() + 
            geom_col(
                aes(x=carrier, y = delay, fill=type),
                position = "dodge"
            )
    )
    
    output$table <- renderDataTable(artists %>% 
        filter(origin == input$origin & foreign == input$foreign))
    
    
})
'''