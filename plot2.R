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

## plot2
plot(df.subset$DateTime, df.subset$Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="l")

#Save to png
dev.copy(png, file = "plot2.png")  ## Copy my plot to a PNG file
dev.off() ## Close
