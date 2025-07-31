install.packages("dunn.test")
install.packages("report")
install.packages("car")
install.packages("multcomp")
library(dunn.test)
library(report)
library(car)
library(multcomp)

myData<-read.table('surgery.txt',header=T,sep="\t",dec=",")

myData$SES<-factor(myData$SES,labels=c('low','middle','high'))
myData$complic<-factor(myData$complic,labels=c('no','yes'))
myData$comorb<-factor(myData$comorb,labels=c('no','yes'))
myData$depressi<-factor(myData$depressi,labels=c('no','yes'))
myData$diabetes<-factor(myData$diabetes,labels=c('no','yes'))
myData$surgery<-factor(myData$surgery,labels=c('gastric band','gastric bypass'))

myData$BMIpost[21]<-29.41

######1.	Independent samples t-test
par(mfrow=c(1,1))

#to test normality 
#females
qqnorm(myData[myData$sex == "Female",]$BMIpre, main='Females BMIpre')
qqline(myData[myData$sex == "Female",]$BMIpre)
hist(myData[myData$sex == "Female",]$BMIpre, main='Females BMIpre')
shapiro.test(myData[myData$sex == "Female",]$BMIpre)
#reject the null, not normal

#males
qqnorm(myData[myData$sex == "Male",]$BMIpre, main='Males BMIpre')
qqline(myData[myData$sex == "Male",]$BMIpre)
hist(myData[myData$sex == "Male",]$BMIpre, main='Males BMIpre')
shapiro.test(myData[myData$sex == "Male",]$BMIpre)
#do not reject the null, normal

#better to use non parametric 
t.test(BMIpre~sex, data=myData) #reject null, males and females not equal
#t.test(myData$BMIpre, myData$sex)

#check variance
boxplot(BMIpre~sex, data=myData)
leveneTest(BMIpre~sex, data=myData)#better to use levene because it does not assume normality and more robust
var.test(BMIpre~sex, data=myData)
#do not reject null, equal variance

#t-test with equal variance
t.test(BMIpre~sex, data=myData, var.equal = TRUE)
#reject null, females and males not equal

?t.test


#####2. paired t-test 
par(mfrow=c(1,2))

#check normality 
#1)
myData$difference <- myData$BMIpre-myData$BMIpost
qqnorm(myData$difference)

qqline(myData$difference)
hist(myData$difference)
shapiro.test(myData$difference)
#reject null, not normal

#2
t.test(myData$BMIpost, myData$BMIpre, paired = TRUE)
#reject null, the mean difference is not equal to 0 , so not equal mean of groups

#####3. non-parametric test

subDiabetes<-myData[myData$diabetes=="yes",]
table(subDiabetes$sex)

wilcox.test(BMIpre~sex, data=subDiabetes)
#don't reject null

subDiabetes$difference <- subDiabetes$BMIpre-subDiabetes$BMIpost
qqnorm(subDiabetes$difference)
qqline(subDiabetes$difference)
hist(subDiabetes$difference)
shapiro.test(subDiabetes$difference)
#don't reject null ,data is normal
wilcox.test(subDiabetes$BMIpost, subDiabetes$BMIpre, paired = TRUE)
#reject null, there is a significant difference

##############################################################
