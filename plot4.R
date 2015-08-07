
plot4 <- function()
{
    ##read csv data and filter only 2 days of data from it
    data <- read.csv("data/household_power_consumption.txt", sep=";", na.strings = "?")
    
    data$Date = strftime(strptime(data$Date, "%d/%m/%Y"), "%m/%d/%Y")
    
    filteredData = data[data$Date == "02/01/2007" | data$Date == "02/02/2007",]
    
    ##add a new column combining date and time columns to data frame for plotting on x axis
    workingdata = data.frame(filteredData, obstime = 
                                 strptime(paste(filteredData$Date, filteredData$Time), 
                                          format = "%m/%d/%Y %H:%M:%S"))
    
    png(file="plot4.png", width=480, height=480)
    
    ##set 2 x 2 panel for 4 plots
    par(mfrow=c(2,2))
    
    ##plot1
    plot(workingdata$obstime, workingdata$Global_active_power, 
         type="l", xlab="", ylab="Global Active Power")
    
    
    ##plot 2
    plot(workingdata$obstime, workingdata$Voltage, 
         type="l", xlab="datetime", ylab="Voltage")
    
    ##plot 3
    plot(workingdata$obstime, workingdata$Sub_metering_1, 
         type="l", xlab="", ylab="Energy sub metering")
    
    lines(workingdata$obstime, workingdata$Sub_metering_2, col="red")
    lines(workingdata$obstime, workingdata$Sub_metering_3, col="blue")
    
    legend("topright", names(workingdata)[7:9], lty=1, col=c("black", "red", "blue"), 
           cex=0.7, bty="n")
    
    ##plot 4
    plot(workingdata$obstime, workingdata$Global_reactive_power, 
         type="l", xlab="datetime", yaxt="n", ylab="Global_reactive_power")
    
    axis(2, cex.axis = 0.7)
    
    dev.off()
}