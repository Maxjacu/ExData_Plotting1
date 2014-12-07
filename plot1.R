#Load lubridate 
library("lubridate")

#Update Workspace set_wd()
#Read from txt
df <- read.csv("household_power_consumption.txt", sep = ";", stringsAsFactors=FALSE)

#convert Date to DateTime with lubridate
df$DateTime <- dmy_hms(paste(df$Date[], df$Time[]), tz = "EST")

#Subset to DateTime first and second of febuary 2007
df.subset <- df[year(df$DateTime) == 2007 & month(df$DateTime) == 2 &(mday(df$DateTime) == 1 | mday(df$DateTime) == 2),]
df.subset[3][df.subset[3]=="?"] <- NA
df.subset[3]<- as.numeric(df.subset[,3], rm.na=TRUE)
df.subset[4]<- as.numeric(df.subset[,4], rm.na=TRUE)

## plot1 Histogram
hist(df.subset$Global_active_power, col="red", xlab="Global active power (kilowatts)", main="Global Active Power")
#Save to png
dev.copy(png, file = "plot1.png")  ## Copy my plot to a PNG file
dev.off() 
