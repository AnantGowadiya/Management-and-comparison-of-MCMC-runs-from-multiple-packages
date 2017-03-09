# Management-and-comparison-of-MCMC-runs-from-multiple-packages

#Anant Gowadiya
#run these commands to test the solution
#creating object of sampleInfoClass
a <- sampleInfoClass(Nvec = 5, Nmetric = list(c(1, 2, 3), c(4, 5)))
c <- sampleInfoClass(Nvec = 6, Nmetric = list(sum = c(11, 21, 31), c(41, 51)))

#creating object of sampleInfoCollectionClass
b <- sampleInfoCollectionClass(samInfobj = list(a,c))

#testing method that computes a scalar metric from a numeric vector
b$NumtoMetric(sum)

#plotting a bar plot
b$plot_bar(metric_name = "sum", barplot, col = "light green",xlab="sum")

![bar plot](https://github.com/AnantGowadiya/Management-and-comparison-of-MCMC-runs-from-multiple-packages/blob/master/mean.png)

#Generating an Html page to display the bar plot
b$to_html(metric_name = "sum", barplot, col = "light green",xlab="sum")
