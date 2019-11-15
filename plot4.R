# remove everything from environment
rm(list=ls(all=TRUE))

# Read and set the data
#read data
data <- read.delim("C:/Users/czafe/Desktop/R lessons/plotting/exdata_data_household_power_consumption/household_power_consumption.txt", 
                   header = TRUE, sep = ";", na.strings = "?", 
                   colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# filter out these dates 2007-02-01 and 2007-02-02 to make the data size smaller and keep relevant data
data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# for time we need to combine date and time, else it will use today's date
DateTime <- paste(data$Date, data$Time)
data <- cbind(DateTime, data)
data$DateTime <- as.POSIXct(data$DateTime)

# Plot 4
par(mfrow = c(2,2))
plot(data$Global_active_power ~ data$DateTime, type = "l", ylab = "Global Active Power", xlab = "")

plot(data$Voltage ~ data$DateTime, type = "l", ylab = "Voltage", xlab = "datetime")

plot(data$Sub_metering_1 ~ data$DateTime, type = "l", col = "black", ylab = "Energy sub metering", xlab = "")
lines(data$Sub_metering_2 ~ data$DateTime, type = "l", col = "red")
lines(data$Sub_metering_3 ~ data$DateTime, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), lwd = c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(data$Global_reactive_power ~ data$DateTime, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

# Save as png 
dev.copy(png, "C:/Users/czafe/Desktop/R lessons/plotting/plot4.png", width = 480, height = 480, units = "px")
dev.off()
