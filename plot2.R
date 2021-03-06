library("data.table")

# Reads in data from file then subsets data for specified dates
powerDT <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Change column types
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Create PNG output
png("plot2.png", width=480, height=480)

# Plot 2
plot(x = powerDT[, dateTime], y = powerDT[, Global_active_power], type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Flush PNG file
dev.off()