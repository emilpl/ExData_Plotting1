## Exploratory Data Analysis Course - Project 1
##
## This script loads only the relevant part of the dataset provided for the project. 
## It then constructs the plot 1 for the project. 

# Read data (only the first part, containing the header and the desired dates)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   quote="", comment.char="", nrows = 70000, stringsAsFactors=FALSE)

# Convert the first column to Date format
data[,1] <- as.Date(data[,1], "%d/%m/%Y")

# Select subset of data between February 1st and 2nd of 2007
data_sel <- subset(data, (data[,1] > "2007-01-31") & (data[,1] < "2007-02-03"))

# Convert the data types of columns 3:9 to numeric. colClasses parameter in read.table did not work 
# because of the symbol "?" in some rows. 
data_sel[,3:(dim(data_sel)[2])] <- apply(data_sel[,3:(dim(data_sel)[2])], 2, function(x) as.numeric(x))

# Create Plot1 and save it as plot1.png in the current Work directory

png(filename="./plot1.png")

hist(data_sel$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowats)", ylim = c(0,1200), col = "red")

dev.off()