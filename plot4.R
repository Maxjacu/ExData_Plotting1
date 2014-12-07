#Load lubridate 
library("lubridate")

#Update Workspace set_wd()
df <- read.csv("household_power_consumption.txt", sep = ";", stringsAsFactors=FALSE) ## Read from txt

#convert Date to DateTime with lubridate
df$DateTime <- dmy_hms(paste(df$Date[], df$Time[]), tz = "EST")

#Subset to DateTime first and second of febuary 2007
df.subset <- df[year(df$DateTime) == 2007 & month(df$DateTime) == 2 &(mday(df$DateTime) == 1 | mday(df$DateTime) == 2),]
rm(df) ## Close unused df
df.subset[3][df.subset[3]=="?"] <- NA ## Rename '?' to NA
df.subset[3]<- as.numeric(df.subset[,3], rm.na=TRUE)
df.subset[4]<- as.numeric(df.subset[,4], rm.na=TRUE)

## plot4
par(mfrow=c(2,2))
plot(df.subset$DateTime, df.subset$Global_active_power, ylab="Global Active Power", xlab="", type="l")
plot(df.subset$DateTime, df.subset$Voltage, xlab="", ylab="Voltage", type="l")
plot(df.subset$DateTime, df.subset$Sub_metering_1, ylab="Energy sub metering", xlab="", type="l")
lines(df.subset$DateTime, df.subset$Sub_metering_2, xlab="", type="l", col="red")
lines(df.subset$DateTime, df.subset$Sub_metering_3, xlab="", type="l", col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),col=c("black","red","Blue"),lty=c(1,1,1))
plot(df.subset$DateTime, df.subset$Global_reactive_power, ylab="Global_reactive_power", xlab="", type="l")

#Save to png
dev.copy(png, file = "plot4.png")  ## Copy my plot to a PNG file
dev.off() ## Close
