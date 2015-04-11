getwd()

fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## read in zip file 
temp<-tempfile()
download.file(fileURL,temp) ## this line only works in RStudio not R if you want to reproduce. Don't know why ##

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

# plot4
par(mfrow=c(2,2))
# then plot all four figures in one page

## topleft figure
tick1<-as.POSIXct("1/2/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")
tick2<-as.POSIXct("2/2/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")
tick3<-as.POSIXct("3/2/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")

with(data2,plot(datetime, Global_active_power,type="l",
                ylab="Global Active Power (kilowatts)",
                xlim=c(tick1,tick3),xlab=""
))

## topright figure
with(data2, plot(datetime, Voltage,type="l"))

## bottomleft figure
attach(data2)
upperlim<-max(max(Sub_metering_1),max(Sub_metering_2),max(Sub_metering_3))
lowerlim<-min(min(Sub_metering_1),min(Sub_metering_2),min(Sub_metering_3))
detach(data2)

with(data2, plot(datetime, Sub_metering_1, type="l",col="black",
                 ylab="Energy sub metering" , 
                 ylim=c(lowerlim,upperlim), xlim=c(tick1, tick3), xlab=""                 
))

lines(x=data2$datetime, y=data2$Sub_metering_2,col="red")
lines(x=data2$datetime, y=data2$Sub_metering_3,col="blue")
legend("topright", lty=1, col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n", cex=0.75) #cex is used to control size

## bottomright figure
with(data2,plot(datetime, Global_reactive_power,type="l"))

## save to png format
png("plot4.png")

par(mfrow=c(2,2))
# then plot all four figures in one page

## topleft figure
tick1<-as.POSIXct("1/2/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")
tick2<-as.POSIXct("2/2/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")
tick3<-as.POSIXct("3/2/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")

with(data2,plot(datetime, Global_active_power,type="l",
                ylab="Global Active Power (kilowatts)",
                xlim=c(tick1,tick3),xlab=""
))

## topright figure
with(data2, plot(datetime, Voltage,type="l"))

## bottomleft figure
attach(data2)
upperlim<-max(max(Sub_metering_1),max(Sub_metering_2),max(Sub_metering_3))
lowerlim<-min(min(Sub_metering_1),min(Sub_metering_2),min(Sub_metering_3))
detach(data2)

with(data2, plot(datetime, Sub_metering_1, type="l",col="black",
                 ylab="Energy sub metering" , 
                 ylim=c(lowerlim,upperlim), xlim=c(tick1, tick3), xlab=""                
))

lines(x=data2$datetime, y=data2$Sub_metering_2,col="red")
lines(x=data2$datetime, y=data2$Sub_metering_3,col="blue")
legend("topright", lty=1, col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n", cex=0.75) #cex is used to control size

## bottomright figure
with(data2,plot(datetime, Global_reactive_power,type="l"))

dev.off()
