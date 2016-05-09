loans = read.csv("loans.csv")

# problem 1.1
loansTable = table(loans$not.fully.paid)
prop.table(loansTable)

