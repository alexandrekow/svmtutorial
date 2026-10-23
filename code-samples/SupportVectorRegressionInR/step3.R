library(e1071)

dataDirectory <- "D:/DropBox/Dropbox/@Alex_Tutoriaux/" 
data <- read.csv(paste(dataDirectory, 'regression.csv', sep=""), header = TRUE)

rmse <- function(error)
{
  sqrt(mean(error^2))
}


plot(data, pch=16)
 

# linear model ==============================================
model <- lm(Y ~ X , data)
  
predictedY <- predict(model, data) 
points(data$X, predictedY, col = "blue", pch=4)   


error <- model$residuals  # same as data$Y - predictedY
predictionRMSE <- rmse(error)   # 5.703778 
# end of linear model =======================================


plot(data, pch=16)

# svr model ==============================================
if(require(e1071)){ 
  model <- svm(Y ~ X , data)
  
  predictedY <- predict(model, data)
   
  points(data$X, predictedY, col = "red", pch=4)
  
  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  # so we compute the error like this
  error <- data$Y - predictedY  
  svrPredictionRMSE <- rmse(error)  # 3.157061 
} 

# end of svr model =======================================