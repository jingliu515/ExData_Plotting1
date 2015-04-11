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

## plot2
par(mfrow=c(1,1))

tick1<-as.POSIXct("1/2/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")
tick2<-as.POSIXct("2/2/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")
tick3<-as.POSIXct("3/2/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")

with(data2,plot(datetime, Global_active_power,type="l",
                ylab="Global Active Power (kilowatts)",
                xlim=c(tick1,tick3),xlab=""
))

# save to png format
png("plot2.png")

with(data2,plot(datetime, Global_active_power,type="l",
                ylab="Global Active Power (kilowatts)",
                xlim=c(tick1,tick3),xlab=""
))

dev.off()