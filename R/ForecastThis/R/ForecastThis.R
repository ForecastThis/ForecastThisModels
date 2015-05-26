#' Re-train a ForecastThisDSX Predictive Model
#' 
#' \code{retrain} returns an object of class \code{trained.model}.
#' @param train.set, a data frame used retrain the downloaded model.
#' @param offline.model, path to a jar model file downloaded from ForecastThisDSX
#' @return \code{trained.model}, an object of class trained.model, useful to make predictions.
#' @import rJava
#' @export
retrain <- function( train.set = NULL, offline.model = NULL){  
  
  if(is.null(train.set) )
    stop('No train data set specified.')
  else if(!is.data.frame(train.set))
    train.set <- as.data.frame(train.set)    
  
  if(is.null(offline.model))
    stop('No path specified for the downloaded ForecastThisDSX model.')  
  
  if(is.character(offline.model)) {
    .jaddClassPath(offline.model)
    offline.model <- .jnew("com.forecastthis.offline.interpreters.rInterpreter")
  }
  
  x <- toJava(train.set)
  .jcall(offline.model, "V", "trainFromR", x)
    
  return(offline.model)
}

#' Get Predictions using a ForecastThisDSX Predictive Model
#' 
#' \code{predict} generates predictions for a test data set, using a ForecastThisDSX predictive model.
#' @param test.set, data frame containing the test set for which we want to make predictions
#' @param trained.model, either the path to a jar model file downloaded from ForecastThisDSX or
#'  an object of class \code{trained.model}.
#' @return \code{test.results}, data frame with the predicted probabilities for each value of the target variable.
#' @import rJava
#' @export
predict <- function( test.set = NULL, trained.model = NULL){
  
  if(is.null(test.set))
    stop('No test data set specified.')
  
  if(!is.data.frame(test.set))
    test.set <- as.data.frame(test.set)    
  
  if(is.null(trained.model))
    stop('No trained model specified.')
  if(typeof(trained.model) == "character") {
    .jaddClassPath(trained.model)
    trained.model <- .jnew("com.forecastthis.offline.interpreters.rInterpreter")
  }
  else if(typeof(trained.model) != "S4")
    stop("trained.model is neither a path to a jar file or an S4 object")
  
  x <- toJava(test.set)
  
  test.results <- NULL
    
  
  message(.jcall(trained.model, "S", "predictFromR", x))
  test.results$predictions <- data.frame(.jcall(trained.model, "[[D", "getForeignPredictions", simplify=T))
  colnames(test.results$predictions) <- .jcall(trained.model, "[S", "getTargetNames") 
  trained.model <- NULL
  
  return(test.results)
}


#' Clear a ForecastThisDSX Model
#' @param trained.model, an object of class \code{trained.model}
#' @return \code{success}, boolean indicating whether object was successfully cleared
#' @import rJava
#' @export
release <- function(trained.model = NULL) {
  
  if(is.null(trained.model))
    stop('No trained model specified.')
  if(typeof(trained.model) == "character") {
    .jaddClassPath(trained.model)
    trained.model <- .jnew("com.forecastthis.offline.interpreters.rInterpreter")
  }
  else if(typeof(trained.model) != "S4")
    stop("trained.model is neither a path to a jar file or an S4 object")
  

  success <- .jcall(trained.model, "Z", "doClear")
  trained.model <- NULL
  return(success)
}
  
