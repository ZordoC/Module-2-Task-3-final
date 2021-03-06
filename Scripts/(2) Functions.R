#### Train and Test Set function ####


TrainAndTestSets <- function(label,p,data,seed){
  set.seed(seed)
  
  inTrain <- createDataPartition(y= label, p = p , list = FALSE)
  training <- data[inTrain,]
  testing <- data[-inTrain,]
  
  
  list(trainingSet=training,testingSet = testing)
  
}


# EP <- PPfunction(EP)
# EP <- RmOut(EP)
# corr_all <- cor(EP)
# 
# corrplot(corr_all)





#### Training Functions ####


TrainingFunction <- function(method,formula,data,tune=4,c=1000,gamma=0.0001)
  {
  
  fitcontrol <-  trainControl(method = "repeatedcv", repeats = 4)
  
  if(method == "rf") {
    
    Model <- train(formula, data = data,method = method, trcontrol = fitcontrol , tunelenght = tune)  
  }

  else if (method == "knn"){
    
    
    
    Model <- train(formula, data = data,method = method, trcontrol = fitcontrol , tunelenght = tune,
                   preProcess = c("center", "scale"))  # OR "RANGE"
  
    
    }
  
   
  else if (method == "svm"){ 
     
    # preprocess externally
    
    Model <- svm(formula, data = data,cost=c , gamma = gamma)
  
    
    }

    return(Model)
  }


#### Al 3 models at once ####

TrainAll3Models <- function (formula,data)
  {

  Model <- vector(mode="list", length=length(methods))

      methods <- c("rf","svm","knn")
        
      for(i in 1:length(methods))
          {    
      
            Model[[i]] <- TrainingFunction(methods[i],formula,data,5)

               

      }
    Model
      
    
      
      
}

# 
# CompareMetrics <- function(Models,data)
#   {
#   
#   
#   {
#     comp_model <- c()
#     
#     
#     methods <- c("rf","svm","knn")
#     
#     for(i in 1:length(methods))
#     {    
#       
#       Model <- TrainingFunction(methods[i],formula,data,5)
#       
#       
#       prediction  <- predict(Model,)
#     
#       metric <- (Model,)
#       
#       comp_model <- cbind(metric,comp-model)
#       
#       
#       }
#     
#     
#     
#     
#     
#   }
#  } 
  
  
  
  




# 
# 
# Models<- TrainAll3Models(Volume~.,EP)
# 
# 
# PredictionRf <- predict(Models[1],List$testingSet)
# 
# postResample(PredictionRf,List$testingSet$Volume)
# PredictionRf
# List$testingSet$Volume
