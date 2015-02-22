library(googleVis)
library(shiny)
library(RCurl)

url="https://dl.dropboxusercontent.com/u/72511223/aggregatedStormData.csv"
data <- getURL(url, ssl.verifypeer=0L, followlocation=1L)
data <- read.csv(text=data)

shinyServer(function(input, output) {
    
    myYear <- reactive({
        input$Year
    })
    
    myProp <- reactive({
        input$Prop
    })
    
    myData <- reactive({
        subset(data, year == myYear())
    })

    output$year <- renderText({
        paste(myPropName(), " in ", myYear())
    })
    
    myPropName <- renderText({
        divide<-sub(pattern="([A-Z])", x = myProp(), replacement = " \\1")
        upper <- paste(toupper(substring(divide, 1,1)), substring(divide, 2), sep="")
    })
    
    output$gvis <- renderGvis({
        gvisGeoChart(myData(),
                     locationvar="state", colorvar=myProp(),
                     options=list(region="US", displayMode="regions", 
                                  resolution="provinces"
                     )) 
        
    })
    
    output$all <- renderText({
        paste("Total = ", sum(myData()[, c(myProp())]))
    })
})