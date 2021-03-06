## Exploratory Data Analysis Course - Project 1
##
## This script loads only the relevant part of the dataset provided for the project. 
## It then constructs the plot4 for the project. 

# Read data (only the first part, containing the header and the desired dates)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   quote="", comment.char="", nrows = 70000, stringsAsFactors=FALSE)

# Merge the first two columns to get the full date-time. 
date_time <- paste(data[,1], data[,2])
date_time <- strptime(date_time, "%d/%m/%Y %H:%M:%S")

# Convert the first column to Date-Time format
data[,1] <- as.Date(data[,1], "%d/%m/%Y")

# Select subset of data and date_time between February 1st and 2nd of 2007
data_sel <- subset(data, (data[,1] > "2007-01-31") & (data[,1] < "2007-02-03"))
time_sel <- date_time[(data[,1] > "2007-01-31") & (data[,1] < "2007-02-03")]

# Convert the data types of columns 3:9 to numeric. colClasses parameter in read.table did not work 
# because of the symbol "?" in some rows. 
data_sel[,3:(dim(data_sel)[2])] <- apply(data_sel[,3:(dim(data_sel)[2])], 2, function(x) as.numeric(x))

# Create plot4 and save it as plot4.png in the current Work directory

png(filename="./plot4.png")

par(mfcol = c(2,2))
plot(time_sel, data_sel$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")

plot(time_sel, data_sel$Sub_metering_1, xlab = "", ylab = "Energy Sub Metering", type = "l")
lines(time_sel, data_sel$Sub_metering_2, col = "red", type = "l")
lines(time_sel, data_sel$Sub_metering_3, col = "blue", type = "l")
legend("topright", lty=1, col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(time_sel, data_sel$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

plot(time_sel, data_sel$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")

dev.off()