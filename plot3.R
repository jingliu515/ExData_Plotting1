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

# plot3
par(mfrow=c(1,1))

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
       cex=1) #cex is used to control size

# save to png format
png("plot3.png")

with(data2, plot(datetime, Sub_metering_1, type="l",col="black",
                 ylab="Energy sub metering" , 
                 ylim=c(lowerlim,upperlim), xlim=c(tick1, tick3), xlab=""           
))

lines(x=data2$datetime, y=data2$Sub_metering_2,col="red")
lines(x=data2$datetime, y=data2$Sub_metering_3,col="blue")
legend("topright", lty=1, col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       cex=1) #cex is used to control size

dev.off()

