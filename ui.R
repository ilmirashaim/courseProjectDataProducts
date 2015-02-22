require(shiny)

shinyUI(fluidPage(
    titlePanel("Economic and public health consequences of severe weather events accross the USA"),
    
    tabsetPanel(
        tabPanel("App",
            sidebarLayout(
                sidebarPanel(
                    sliderInput("Year", "Year to be displayed:", 
                            min=1950, max=2011, value=2011,  step=1,
                            format="###0",animate=TRUE),
                    selectInput("Prop", "What to display:",
                            c("Fatalities"="fatalities",
                              "Injuries"="injuries",
                              "Property damage" ="propertyDamage",
                              "Crop damage" = "cropDamage"), 
                            selected = "fatalities",
                            multiple = FALSE)
                ),
                mainPanel(
                    h3(textOutput("year")),
                    h5(textOutput("all")), 
                    htmlOutput("gvis")
                )
            )
        ),
        tabPanel("About",
                 p("This app is based on U.S. National Oceanic and Atmospheric Administration's (NOAA) ", 
                   a("storm database", href="https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf"),
                   ". This databases contains main characteristics of major storms and weather events across the United States including ",
                   "the number of fatalities and injuries, the size of property and crop damage."),
                 p("The data were collected for each state for period from 1950 to 2011."),
                 p("I have preprocessed data (the ",
                   a("code", href="https://github.com/ilmirashaim/courseProjectDataProducts/blob/master/aggregate.R"),
                   " of preprocessing is not in app code). The preprocessed data is available ",
                   a("here", href="https://dl.dropboxusercontent.com/u/72511223/aggregatedStormData.csv"),
                   ". The original data is ",
                   a("here", href="https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"), "."),
                 p("You can choose a year and one of four characteristics (fatalities, injuries, property damage, crop damage).",
                   " The sum of this property will be shown by color for each state. The total sum will be shown at the top of map."),
                 p("There is no predictive algorithm in the app, but i think it is a good data visualisation.",
                   "Moreover it can help you to decide where to live to avoid some injuries and damage because of the weather events.")
                 )
    )
))
