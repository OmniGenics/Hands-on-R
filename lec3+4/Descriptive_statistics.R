install.packages("corrplot")
install.packages("RColorBrewer")
library(corrplot)
library(RColorBrewer)

# Data reading
# Read in the dataset and analyze the read‐in dataset using str(myData).
myData<-read.table('patient-data-cleaned.txt',header=T,sep="\t",dec=",")
str(myData)

# The variable Grade is a categorical variable,
#but was read in as a numeric. Convert this variable to a factor and assign the value labels
#“low”, ”middle” and “high” to the 3 levels of the variable.
myData$Grade<-factor(myData$Grade,labels=c('low','middle','high'))

# Define the variables Died, Overweight, Smokes as factors. For all these factors, a zero means “no”
#and a 1 means “yes”. Assign these value labels through the function factor() and check the change using str() 
#or using the RStudio “Environment” quadrant.
myData$Died<-factor(myData$Died,labels=c("no","yes"))
myData$Overweight<-factor(myData$Overweight,labels=c("no","yes"))
myData$Smokes<-factor(myData$Smokes,labels=c("Non-Smoker","Smoker"))
str(myData)

#You can summarize your data using summary()
summary(myData)
myData$Height=as.numeric(myData$Height)
myData$Weight=as.numeric(myData$Weight)
myData$BMI=as.numeric(myData$BMI)
myData$Count=as.numeric(myData$Count)
str(myData)
summary(myData)

#For a categorical variable a frequency table is more appropriate, using table(myData$sex)
table(myData$Sex)

#Calculate the following: mean, median, minimum, maximum, first and third quartile for the age, using separate commands. 
mean(myData$Age,na.rm=TRUE)
median(myData$Age,na.rm=TRUE)
min(myData$Age,na.rm=TRUE)
max(myData$Age,na.rm=TRUE)
quantile(myData$Age,na.rm=TRUE,c(0.25,0.75))

#Calculate the mean age for females and  males (summary statistics by group)
tapply(myData$Age,list(sex=myData$Sex),mean,na.rm=T)

#Calculate thecorrelation coefficient between weights and Heights
# correlation coefficient
cor(myData$Weight,myData$Height, use="complete.obs")

# default correlation = Pearson
# extra argument for Spearman
cor(myData$Weight,myData$Height, use="complete.obs",method="spearman")
cormat=cor(myData[,c("Weight","Height","BMI", "Age")])
corrplot(cormat, method="color",col=brewer.pal(n=8, name="RdBu"),tl.col="black",tl.srt=45)


###### 3. Graphics ######
#########################
#Generate a bar chart of a categorical variable for the sex
barplot(table(myData$Sex), xlab="Sex",ylab="Frequency")

#Generate a bar chart graph with mean age in males and females
barplot(tapply(myData$Age,list(sex=myData$Sex),mean,na.rm=T),
        xlab="Sex",ylab="Mean age")

#Make a histogram of a continuous variable “age”
hist(myData$Age,xlab="Age",main="Distribution of Age")

#Make a scatterplot of 2 continuous variables Heights and weights (using formula notation Y~X)
#with different colors for each Grade‐value, Add the three regression lines for each of the 3 Grade groups
plot(myData$Height,myData$Weight,xlab="Length",ylab="Weight",
     main="Scatterplot")
plot(Weight~Height, data=myData) 

# scatterplot with different colors for 3 groups
# first draw plot with only 'low' category
plot(myData$Height[myData$Grade=="low"],myData$Weight[myData$Grade=="low"],xlab="Length",ylab="Weight",main="Scatterplot")
# then add points from high and middle SES
points(myData$Height[myData$Grade=="middle"],myData$Weight[myData$Grade=="middle"],col=2)
points(myData$Height[myData$Grade=="high"],myData$Weight[myData$Grade=="high"],col=3)
# then add 3 separate regression lines
abline(lm(myData$Weight[myData$Grade=="low"]~myData$Height[myData$Grade=="low"]))
abline(lm(myData$Weight[myData$Grade=="middle"]~myData$Height[myData$Grade=="middle"]),col=2)
abline(lm(myData$Weight[myData$Grade=="high"]~myData$Height[myData$Grade=="high"]),col="blue")

#Make a boxplot of age  and a separate boxplots per group we use the formula‐notation (Y~X)
boxplot(myData$Age,main="Age")
boxplot(Age~Sex,data=myData,main="Boxplot per sex")

### 4. Outlier detection ####
outliers<-boxplot(myData$Count,plot=FALSE)$out
outliers
myData[myData$Count%in% outliers,]

### 5. Testing for normality ###
qqnorm(myData$BMI)
qqline(myData$BMI)
hist(myData$BMI)
shapiro.test(myData$BMI)