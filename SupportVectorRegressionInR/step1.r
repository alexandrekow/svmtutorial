# Load the data from the csv file
dataDirectory <- "D:/DropBox/Dropbox/@Alex_Tutoriaux/"  
data <- read.csv(paste(dataDirectory, 'regression.csv', sep=""), header = TRUE)

# Plot the data 
plot(data, pch=16)

# Create a linear regression model
model <- lm(Y ~ X, data)

# Add the fitted line
abline(model)
