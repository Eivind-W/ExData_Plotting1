plot4 <- function(dataset) {
      
      subset <- load_dataset(dataset)
      png("plot4.png")
      par(mfrow=c(2,2))
      
      plot(subset$DateTime,
           subset$Global_active_power,
           type="l",
           ylab = "Global Active Power (kilowatts)",
           xlab = "")
      
      plot(subset$DateTime,
           subset$Voltage,
           type="l",
           ylab = "Voltage",
           xlab = "datetime")
      
      plot(subset$DateTime,
           subset$Sub_metering_1,
           type="l",
           ylab = "Energy sub metering",
           xlab = "")
      lines(subset$DateTime,
            subset$Sub_metering_2,
            type="l",
            col="Red")
      lines(subset$DateTime,
            subset$Sub_metering_3,
            type="l",
            col="purple3")
      legend("topright",
             legend=c("Sub_metering_1",
                      "Sub_metering_2",
                      "Sub_metering_3"),
             col = c("Black","Red","purple3"),
             lty = "solid",
             bty = "n")
      
      plot(subset$DateTime,
           subset$Global_reactive_power,
           type="l",
           ylab = "Global_reactive_power",
           xlab = "datetime")
      dev.off()
      
      
}

load_dataset <- function(dataset) {
      
      # load the dataset
      dataset <-  read.csv("household_power_consumption.txt",
                           header=TRUE,
                           sep=";",
                           na.strings="?",
                           colClasses = c("character",
                                          "character",
                                          "numeric",
                                          "numeric",
                                          "numeric",
                                          "numeric",
                                          "numeric",
                                          "numeric",
                                          "numeric")
      )
      
      # fix datevalues in dataset
      dataset$DateTime <- as.POSIXlt(paste(dataset$Date,dataset$Time,sep=" "),
                                     format="%d/%m/%Y %H:%M:%S")
      dataset$Date <- as.Date(dataset$Date,format="%d/%m/%Y")
      
      #load subset of data
      selection <- dataset$Date >= as.Date("2007-02-01") & dataset$Date <= as.Date("2007-02-02")
      subset <- dataset[selection,]
      subset #return selected subset
}