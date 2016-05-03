
# Get the current directory
  getwd()
  ls()
# Read the csv file
  mvt = read.csv("mvtWeek1.csv")
# Structure of the dataset
  str(mvt)
# Statistical summary
  summary(mvt)

  table(mvt$Arrest)
Alley =  mvt[mvt$LocationDescription == "ALLEY", ]
str(Alley)

# Now, let's convert these characters into a Date object in R. In your R console, type
DateConvert = as.Date(strptime(mvt$Date, "%m/%d/%y %H:%M"))
summary(DateConvert)
mvt$Month = months(DateConvert)
mvt$Weekday = weekdays(DateConvert)
mvt$Date = DateConvert

table(mvt$Month)
min(table(mvt$Month))

table(mvt$Weekday)
max(table(mvt$Weekday))

table(mvt$Month, mvt$Arrest)
  
hist(mvt$Date, breaks=100)

boxplot(mvt$Date ~ mvt$Arrest)

table(mvt$Year)
?table
year_arrest = table(mvt$Year, mvt$Arrest)
?prop.table
prop.table(year_arrest, 1)

sort(table(mvt$LocationDescription))

Top5 = mvt[mvt$LocationDescription == "GAS STATION" | 
             mvt$LocationDescription == "STREET" | 
             mvt$LocationDescription == "PARKING LOT/GARAGE(NON.RESID.)" | 
             mvt$LocationDescription == "ALLEY" | 
             mvt$LocationDescription == "DRIVEWAY - RESIDENTIAL", ]
str(Top5)

table(Top5$LocationDescription)
Top5$LocationDescription = factor(Top5$LocationDescription)
table(Top5$LocationDescription)
top5table = table(Top5$LocationDescription, Top5$Arrest)
prop.table(top5table, 1)

table(Top5[Top5$LocationDescription == "GAS STATION",]$Weekday)
table(Top5[Top5$LocationDescription == "DRIVEWAY - RESIDENTIAL",]$Weekday)


IBM = read.csv("IBMStock.csv")
GE= read.csv("GEStock.csv")
ProcterGamble = read.csv("ProcterGambleStock.csv")
CocaCola = read.csv("CocaColaStock.csv")
Boeing = read.csv("BoeingStock.csv")

IBM$Date = as.Date(IBM$Date, "%m/%d/%y")
GE$Date = as.Date(GE$Date, "%m/%d/%y")
CocaCola$Date = as.Date(CocaCola$Date, "%m/%d/%y")
ProcterGamble$Date = as.Date(ProcterGamble$Date, "%m/%d/%y")
Boeing$Date = as.Date(Boeing$Date, "%m/%d/%y")

mean(IBM$StockPrice)
fivenum((GE$StockPrice))
?fivenum
fivenum((CocaCola$StockPrice))
fivenum((Boeing$StockPrice))
sd(ProcterGamble$StockPrice)

plot(CocaCola$Date, CocaCola$StockPrice, col = 'red')
lines(ProcterGamble$Date, ProcterGamble$StockPrice,  col="blue", lty=2)
?lines
abline(v=as.Date(c("2000-03-01")), lwd=2)

plot(CocaCola$Date[301:432], CocaCola$StockPrice[301:432], type="l", col="red", ylim=c(0,210))
lines(IBM$Date[301:432], IBM$StockPrice[301:432], col="blue")
lines(GE$Date[301:432], GE$StockPrice[301:432], col="black")
lines(ProcterGamble$Date[301:432], ProcterGamble$StockPrice[301:432], col="green")
lines(Boeing$Date[301:432], Boeing$StockPrice[301:432], col="purple")
abline(v=as.Date(c("1997-09-01")), lwd=2)
abline(v=as.Date(c("1997-11-30")), lwd=2)

tapply(IBM$StockPrice, months(IBM$Date), mean)
mean(IBM$StockPrice)

tapply(GE$StockPrice, months(GE$Date), mean)
tapply(CocaCola$StockPrice, months(CocaCola$Date), mean)

CPS = read.csv("CPSData.csv")
table(CPS$Industry)
sort(table(CPS$Industry))
sort(table(CPS$State)) 

table(CPS$Citizenship)
prop.table(table(CPS$Citizenship))

hispanic = CPS[CPS$Hispanic == 1, ]
sort(table(hispanic$Race))

summary(CPS)


table(CPS$Region, is.na(CPS$Married))
prop.table(table(CPS$Region, is.na(CPS$Married)), 1)
prop.table(table(CPS$Sex, is.na(CPS$Married)), 1)
prop.table(table(CPS$Citizenship, is.na(CPS$Married)), 1)


?prop.table
prop.table(table(CPS$State, is.na(CPS$MetroAreaCode)), 1)
prop.table(table(CPS$Region, is.na(CPS$MetroAreaCode)), 1)

tapply(is.na(CPS$MetroAreaCode), CPS$State, mean)
sort(tapply(is.na(CPS$MetroAreaCode), CPS$State, mean))

MetroAreaMap = read.csv("MetroAreaCodes.csv")
CountryMap = read.csv("CountryCodes.csv")

CPS = merge(CPS, MetroAreaMap, by.x="MetroAreaCode", by.y="Code", all.x=TRUE)
summary(CPS$MetroArea)
sort(summary((CPS$MetroArea)))

sort(tapply(CPS$Hispanic, CPS$MetroArea, mean))

sort(tapply((CPS$Race == "Asian"), CPS$MetroArea, mean))

sort(tapply(CPS$Education == "No high school diploma", CPS$MetroArea, mean))
sort(tapply(CPS$Education == "No high school diploma", CPS$MetroArea, mean, na.rm=TRUE))

CPS = merge(CPS, CountryMap, by.x="CountryOfBirthCode", by.y="Code", all.x=TRUE)
summary(CPS$Country)
sort(summary(CPS$Country))
typeof(CPS)

sort(tapply(CPS$Country != "United States", CPS$MetroArea, mean))
tapply(CPS$Country != "United States", CPS$MetroArea, mean, na.rm= TRUE)

sort(tapply(CPS$Country == "India", CPS$MetroArea, sum, na.rm= TRUE))
sort(tapply(CPS$Country == "Brazil", CPS$MetroArea, sum, na.rm= TRUE))
sort(tapply(CPS$Country == "Somalia", CPS$MetroArea, sum, na.rm= TRUE))


