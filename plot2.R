
plot2 <- function()
{
    ##read csv data and filter only 2 days of data from it
    data <- read.csv("data/household_power_consumption.txt", sep=";", na.strings = "?")
    
    data$Date = strftime(strptime(data$Date, "%d/%m/%Y"), "%m/%d/%Y")
    
    filteredData = data[data$Date == "02/01/2007" | data$Date == "02/02/2007",]
    
    ##add a new column combining date and time columns to data frame for plotting on x axis
    workingdata = data.frame(filteredData, obstime = 
                                 strptime(paste(filteredData$Date, filteredData$Time), 
                                          format = "%m/%d/%Y %H:%M:%S"))
    
    png(file="plot2.png", width=480, height=480)
      
    ##plot graph of time vs minute average Global Active Power
    plot(workingdata$obstime, workingdata$Global_active_power, 
                 type="l", xlab="", ylab="Global Active Power (kilowatts)")
    
    dev.off()
}