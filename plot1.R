#plot1.R plots the assignment plot1 into a plot1.png file into the working directory
#it is assumend that the data file is in the working directory

#read the data
#the estimate for the size of the data is ~ 150MB
#this is large but the RAM today is > 1 GB
#will be reading the whole data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.string = "?")

#find the rows you want to subset
# days: 1-Feb-2007 and 2-Feb-2007
#the format of date column is : day/month/year
#"1/2/2007" selects also  "11/2/2007"...need to specify the begining of the line with ^
index <- grep("^1/2/2007|^2/2/2007", data$Date)
length(index) #there are 2880 rows that meet the criteria

#subset the origina data frame
feb1 <- data[index,]

#chek for NA
l <- is.na(feb) # and then table(l) -> gives 25920 FALSE = (2880*9), so no NA entries
#do complete cases just in case that the data changes
feb <- feb1[complete.cases(feb1),] 

#convert in Date and Time into date format
DateTime <- paste(feb$Date, feb$Time, sep = " ")
DateTime <- strptime(DateTime, "%d/%m/%Y %H:%M:%S")

#add a new column to the date frame with date formated time
feb <- cbind(feb, DateTime)

#make the histogram and print it in pnd file
png("plot1.png")#png default height is 480 and default width is 480 pixels, no need to specify explicitly
hist(feb$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.off()


