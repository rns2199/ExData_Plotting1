
## The below code creates 4 plots from the displaying various consumption metrics 

## Function to read the data (skipping data that isn't for 1/2/2007 or 2/2/2007)
## and converting the Date column to a Date and Time to a Datetime
readData <- function() {
    consump <- read.csv(pipe('egrep "(^[1-2]/2/2007|^Date)" "household_power_consumption.txt"'), 
                        sep = ";", na.strings = "?")
    consump$Time <- strptime(paste(consump$Date, consump$Time), "%d/%m/%Y %H:%M:%S")
    consump$Date <- as.Date(consump$Date , "%d/%m/%Y")
    consump
}

# Function to create plot 1
makePlot1 <- function(consump) {
    with(consump, plot(Time, Global_active_power, type = "l", xlab = "",
         ylab = "Global Active Power"))
}

# Function to create plot 2
makePlot2 <- function(consump) {
    with(consump, plot(Time, Voltage, type = "l", xlab = "datetime"))
}

# Function to create plot 3
makePlot3 <- function(consump) {
    with(consump, {
        plot(Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
        lines(Time, Sub_metering_2, col = "red")
        lines(Time, Sub_metering_3, col = "blue")
    })
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lty = 1, box.lty = 0, col = c("black", "red", "blue"))
}

# Function to create plot 4
makePlot4 <- function(consump) {
    with(consump, plot(Time, Global_reactive_power, type = "l", xlab = "datetime"))
}

# Function to create an image of the four plots
makePlot <- function(consump) {
    png(file = "plot4.png")
    par(mfrow = c(2, 2), mar=c(5, 4, 4.5, 2), cex = 0.8)
    makePlot1(consump)
    makePlot2(consump)
    makePlot3(consump)
    makePlot4(consump)
    dev.off()
}

consump <- readData()
makePlot(consump)




