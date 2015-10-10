#Read in entire dataset
elec.data <- read.table('household_power_consumption.txt',sep = ";", 
                        header = TRUE, stringsAsFactors = FALSE)

#Remove all dates not equal to 1st of 2nd of February, 2007
elec.data <- elec.data[which(elec.data$Date %in% c('1/2/2007','2/2/2007')),]
dateTime <- paste(elec.data$Date,elec.data$Time)

#convert Time column to posixct variable wiht date and time
elec.data$Time <- as.POSIXct(strptime(dateTime,format = '%d/%m/%Y %H:%M:%S'))

#convert remaining rows to numeric
elec.data[,3:9] <- sapply(elec.data[,3:9],as.numeric)

png(filename = 'plot1.png', width = 480, height = 480)

#Plot 1
hist(elec.data$Global_active_power, col = 'red', 
     xlab = 'Global Active Power (kilowatts)', 
     main = 'Global Active Power',
     cex.axis = .75, cex.lab = .75, cex.main = .75)

dev.off()
