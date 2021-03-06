plot2 <- function(dataset) {
      
      subset <- load_dataset(dataset)
      par(mfrow=c(1,1))
      plot(subset$DateTime,
           subset$Global_active_power,
           type="l",
           ylab = "Global Active Power (kilowatts)",
           xlab = "")
      dev.copy(png,file="plot2.png")
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