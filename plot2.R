##################################################################
## This scripts creates a plot2.png file that represent household
## energy usage (Global active power in kw vs Date_Time) over a
## 2-day period in February, 2007
##
## This script:
## 1. Reads data from 2007-02-01 and 2007-02-02 included in the
## household_power_consumption.txt file
## (source:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip )
## 2. Creates a scatter plot of Global Active Power (Kilowatts)
## vs Date and time
##
## Inputs:
## household_power_consumption.txt
##
## Output:
## plot2.png
##################################################################

create_plot2 <- function (){
  filename <- "household_power_consumption.txt"
  ## Read the data from 2007-02-01 and 2007-02-02
  columnNames <- names(
    read.csv(filename,
             header = TRUE,
             nrows = 1,
             sep = ";")
  )
  ## Set the column types
  columnClasses <- c("character", #Date
                     "character", #Time
                     "numeric",   #Global_active_power
                     "numeric",   #Global_reactive_power
                     "numeric",   #Voltage
                     "numeric",   #Global_intensity
                     "numeric",   #Sub_metering_1
                     "numeric",   #Sub_metering_2
                     "numeric"    #Sub_metering_3
  )
  ## Read the data
  data <- read.table(filename,
                     sep = ";",
                     header = FALSE,
                     skip = 66637,
                     nrows = 2880,
                     col.names = columnNames,
                     colClasses = columnClasses,
                     na.strings = "?"
  )

  ## Merge the columns Date and Time into one and parse it as Date Time types
  date_time<- strptime(paste(data$Date, data$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

  ## Start plot:
  png("plot2.png",width = 480, height = 480, units = "px")

  plot(date_time, data$Global_active_power,
       ylab = "Global Active Power (kilowatts) ",
       type = "l", xlab = ""
       )

  ## Close plot
  dev.off()
}
