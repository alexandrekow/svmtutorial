library(e1071)

dataDirectory <- "D:/DropBox/Dropbox/@Alex_Tutoriaux/" 
data <- read.csv(paste(dataDirectory, 'regression.csv', sep=""), header = TRUE)

rmse <- function(error)
{
  sqrt(mean(error^2))
}


plot(data)


# linear model ==============================================
model <- lm(Y ~ X , data)

predictedY <- predict(model, data) 
points(data$X, predictedY, col = "blue", pch=4)   


error <- model$residuals  # same as data$Y - predictedY
predictionRMSE <- rmse(error)   # 5.703778 
# end of linear model =======================================


plot(data)

# svr model ==============================================
if(require(e1071)){
  
  
  model <- svm(Y ~ X , data)
  
  predictedY <- predict(model, data)
  
  points(data$X, predictedY, col = "red", pch=17)
  
  
  error <- data$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  svrPredictionRMSE <- rmse(error)  # 3.157061 
  
    
  tuneResult <- tune(svm, Y ~ X,  data = data, 
                ranges = list(epsilon = seq(0,1,0.1), cost = 2^(2:9))
  ) 
  print(tuneResult) # best performance: MSE = 8.371412, RMSE = 2.89  epsilon  1e-04   cost 4
   
  # Draw the first tuning graph 
  plot(tuneResult) 
    
  # On the first tuning graph, we can see that the graph is darker on the leftside when epsilon is small,
  # so we adjust the tuning to go in this direction 
  
  # Draw the second tuning graph
  tuneResult <- tune(svm, Y ~ X,  data = data, 
                     ranges = list(epsilon = seq(0,0.2,0.01), cost = 2^(2:9))
  ) 
  
  print(tuneResult) 
  plot(tuneResult)
  
  plot(data, pch=16)
  tunedModel <- tuneResult$best.model
  tunedModelY <- predict(tunedModel, data) 
  
  points(data$X, predictedY, col = "red", pch=4)
  lines(data$X, predictedY, col = "red", pch=4)
  
  points(data$X, tunedModelY, col = "blue", pch=4)
  lines(data$X, tunedModelY, col = "blue", pch=4)
  
  error <- data$Y - tunedModelY  
  
  # this value can  be different because the best model is determined by cross-validation over randomly shuffled data 
  tunedModelRMSE <- rmse(error)  # 2.219642 
} 


# end of svr model =======================================




