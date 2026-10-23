# If you don't have them, install the required packages
# install.packages("e1071")
# install.packages("RTextTools")

library(e1071)
library(RTextTools)

# Load the data from the csv file
dataDirectory <- "D:/ClassifyTextWithR/" # put your own folder here
data <- read.csv(paste(dataDirectory, 'sunnyData.csv', sep=""), header = TRUE)

# Create the document term matrix
dtMatrix <- create_matrix(data["Text"]) 

# Configure the training data
container <- create_container(dtMatrix, data$IsSunny, trainSize=1:11, virgin=FALSE) 

# train a SVM Model
model <- train_model(container, "SVM", kernel="linear", cost=1)
 
# new data
predictionData <- list("sunny sunny sunny rainy rainy", "rainy sunny rainy rainy", "hello", "", "this is another rainy world") 

# create a prediction document term matrix 
predMatrix <- create_matrix(predictionData, originalMatrix=dtMatrix) 

# create the corresponding container
predSize = length(predictionData);
predictionContainer <- create_container(predMatrix, labels=rep(0,predSize), testSize=1:predSize, virgin=FALSE) 

# predict
results <- classify_model(predictionContainer, model)
results
 