dataDirectory <- "D:/DropBox/Dropbox/@Alex_Tutoriaux/" 
data <- read.csv(paste(dataDirectory, 'regression.csv', sep=""), header = TRUE)

plot(data, pch=16)
model <- lm(Y ~ X , data)

# make a prediction for each X 
predictedY <- predict(model, data)

# display the predictions
points(data$X, predictedY, col = "blue", pch=4) 

# This function will compute the RMSE
rmse <- function(error)
{
  sqrt(mean(error^2))
}

error <- model$residuals  # same as data$Y - predictedY
predictionRMSE <- rmse(error)   # 5.703778 


