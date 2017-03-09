#TEST 1
#Creating reference class with Nvec and Nmetric as data memebers of type numeric and list respectively
sampleInfoClass <- setRefClass("sampleInfoClass", fields = list(Nvec = "numeric", Nmetric = "list"))

#TEST 2
#Creating refernce class whose object contains list of objects of class sampleInfoClass
sampleInfoCollectionClass <- setRefClass("sampleInfoCollectionClass", fields = list(samInfobj = "list"))

#TEST 3
#Creating method that takes Function as parameter.You can also pass other parameters to the function
sampleInfoCollectionClass$methods(
  NumtoMetric = function(FUN, ...) {
    metric_name <- as.character(match.call()$FUN)
    #applying the function to the numeric vector in each sampleInfoClass object and adding the result to
    #the list of calculated metrics for the same sampleInfoClass object.
    for (i in samInfobj)
    {
      if (is.null(i$Nmetric[[metric_name]])) {
        i$Nmetric[[metric_name]] <- FUN(i$Nvec, ...)
      }
      else {
        i$Nmetric[[metric_name]] <-
          c(i$Nmetric[[metric_name]], FUN(i$Nvec, ...))
      }
    }
  }
)

#TEST 4
#Method for plotting the bar plot
sampleInfoCollectionClass$methods(
  plot_bar = function(metric_name, plotter, ...) {
    flag <- TRUE
    #Traversing the object of class sampleInfoCollectionClass and extracting
    #data to data.frame
    for (i in samInfobj) {
      if (flag) {
        df_for_plot <- data.frame(i$Nmetric[metric_name])
        flag <- FALSE
      }
      else{
        df_for_plot <- rbind(df_for_plot, i$Nmetric[metric_name])
      }
    }

    #passing data.frame to plotting function
    plotter(df_for_plot[[metric_name]], ...)
  }
)

#TEST 5
sampleInfoCollectionClass$methods(
  to_html = function(metric_name, plotter, ...) {
    #Traversing the object of class sampleInfoCollectionClass and extracting
    #data to data.frame
    flag <- TRUE
    for (i in samInfobj) {
      if (flag) {
        df_for_plot <- data.frame(i$Nmetric[metric_name])
        flag <- FALSE
      }
      else{
        df_for_plot <- rbind(df_for_plot, i$Nmetric[metric_name])
      }
    }
    # creating .html file path
    con <- file.path(getwd(), paste(metric_name, "html", sep = "."))
    #creating plot and saving it as .png file
    png(file.path(getwd(), paste(metric_name, "png", sep = ".")))
    plotter(df_for_plot[[metric_name]], ...)
    dev.off()
    # Inserting plot image to the HTML file
    R2HTML::HTMLInsertGraph(paste(metric_name, "png", sep = "."), append = F, file = con)
    #displaying the .html file
    file.show(con)
  }
)
