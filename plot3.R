
## The below code creates a 3 line plot from the Sub-Metering values 

## Function to read the data (skipping data that isn't for 1/2/2007 or 2/2/2007)
## and converting the Date column to a Date and Time to a Datetime
readData <- function() {
    consump <- read.csv(pipe('egrep "(^[1-2]/2/2007|^Date)" "household_power_consumption.txt"'), 
                        sep = ";", na.strings = "?")
    consump$Time <- strptime(paste(consump$Date, consump$Time), "%d/%m/%Y %H:%M:%S")
    consump$Date <- as.Date(consump$Date , "%d/%m/%Y")
    consump
}

## Function to create an image of the line plot
makePlot <- function(consump) {
    png(file = "plot3.png")
    with(consump, {
        plot(Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
        lines(Time, Sub_metering_2, col = "red")
        lines(Time, Sub_metering_3, col = "blue")
    })
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lty = 1, col = c("black", "red", "blue"))
    dev.off()
}

consump <- readData()
head(consump)
summary(consump)
makePlot(consump)



