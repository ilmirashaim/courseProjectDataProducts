library(lubridate)
library(plyr)

#reading the data
fileName <- "repdata-data-StormData.csv.bz2"
if(!file.exists(fileName)){
    download.file(
        "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2",
        destfile = fileName, 
        method="curl"
    )
}
raw <- read.csv(fileName, stringsAsFactors = FALSE)

#defining a year using the beginning datt
raw$date <- mdy_hms(raw$BGN_DATE)
raw$year <- year(raw$date)

#aggregating
dataByYearAndState <- ddply(raw, c("STATE", "year"), summarise,
                            fatalities=sum(FATALITIES), injuries=sum(INJURIES), propertyDamage=sum(PROPDMG), cropDamage=sum(CROPDMG))
dataByYearAndState <- rename(dataByYearAndState, replace=c("STATE"="state"))
write.csv(dataByYearAndState, file="aggregatedStrormData.csv")