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

png(filename = 'plot4.png', width = 480, height = 480)

#Plot 4

par(mfrow = c(2,2),cex = .8)

#Subplot 1
x <- elec.data$Time
y <- elec.data$Global_active_power

plot(x, y, type = 'l',xlab = '',
     ylab = 'Global Active Power')

#Subplot 2
x <- elec.data$Time
y <- elec.data$Voltage

plot(x, y, type = 'l',xlab = 'datetime',
     ylab = 'Voltage')

#Subplot 3
x <- elec.data$Time
y_1 <- elec.data$Sub_metering_1
y_2 <- elec.data$Sub_metering_2
y_3 <- elec.data$Sub_metering_3

plot(x, y_1, type = 'l', col = 'black',xlab = '',ylab = 'Energy sub metering')
lines(x, y_2, type = 'l', col = 'red')
lines(x, y_3, type = 'l', col = 'blue')
legend("topright", colnames(elec.data[7:9]), lty = c(1,1,1),
       col = c('black','red','blue'), bty = 'n',
       y.intersp = .8, text.width = 85000)

#Subplot 4
x <- elec.data$Time
y <- elec.data$Global_reactive_power

plot(x, y, type = 'l',xlab = 'datetime',
     ylab = 'Global_reactive_power')

dev.off()

dev.off(dev.list()["RStudioGD"])