getwd()

fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## read in zip file 
temp<-tempfile()
download.file(fileURL,temp) ## works in RStudio not R? ##
classes<-c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
dataAll<-read.table(unz(temp,"household_power_consumption.txt"),header=T,sep=";",
                    colClasses=classes,na.strings="?")
unlink(temp)


## subsetting data
chooseDate<-c("1/2/2007","2/2/2007")
data2<-dataAll[dataAll$Date %in% chooseDate,]

## create a new datetime variable
data2$datetime<-as.POSIXct(paste(data2$Date,data2$Time),format="%d/%m/%Y %H:%M:%S")
class(data2$datetime)

# plot1
par(mfrow=c(1,1))

hist(data2$Global_active_power, col='red', main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

# save to png format
png("plot1.png")
hist(data2$Global_active_power, col='red', main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()