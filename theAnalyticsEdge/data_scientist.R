ds = read.csv('data_scientist.csv')
str(ds)
summary(ds)
ds[which.min(ds$salary), ]
ds[which.max(ds$salary), ]


hist(ds$salary)

certified = subset(ds, ds$status=='CERTIFIED')

hist(certified$salary)

?hist
