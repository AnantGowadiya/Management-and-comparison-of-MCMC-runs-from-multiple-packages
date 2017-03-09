# Management-and-comparison-of-MCMC-runs-from-multiple-packages


##Anant Gowadiya
##Run these commands to test the solution
##Creating object of sampleInfoClass
a <- sampleInfoClass(Nvec = sample(4), Nmetric = list(c(1, 2, 3), c(4, 5)))

b <- sampleInfoClass(Nvec = 5 , Nmetric = list(mean = c(11, 21, 31), c(41, 51)))

c <- sampleInfoClass(Nvec = runif(n = 5, min = 1, max = 10))

##Creating object of sampleInfoCollectionClass
d <- sampleInfoCollectionClass(samInfobj = list(a, b, c))

##Testing method that computes a scalar metric from a numeric vector
d$NumtoMetric(mean)

##Plotting a bar plot
d$plot_bar(metric_name = "mean",barplot,col= "light green",xlab = "mean")

![bar plot](https://github.com/AnantGowadiya/Management-and-comparison-of-MCMC-runs-from-multiple-packages/blob/master/mean.png)
##Generating an Html page to display the bar plot
d$to_html(metric_name = "mean",barplot,col= "light green",xlab = "mean")
