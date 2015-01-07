
## The below code creates a line plot from the Global Active Power values 

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
    png(file = "plot2.png")
    with(consump, plot(Time, Global_active_power, type = "l", xlab = "",
                       ylab = "Global Active Power (kilowatts)"))
    dev.off()
}

consump <- readData()
head(consump)
summary(consump)
makePlot(consump)


