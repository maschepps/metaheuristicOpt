#############################################################################
#
#  This file is a part of the R package "metaheuristicOpt".
#
#  Author: Iip
#  Co-author: -
#  Supervisors: Lala Septem Riza, Eddy Prasetyo Nugroho
#   
#
#  This package is free software: you can redistribute it and/or modify it under
#  the terms of the GNU General Public License as published by the Free Software
#  Foundation, either version 2 of the License, or (at your option) any later version.
#
#  This package is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
#  A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
#############################################################################

# this function will generate the random number with defined boundary
# @param numPopulation number population / number row
# @param dimension number variable / number column
# @param lowerBound lower bound for each variable
# @param upperBound upper bound for each variable

generateRandom <- function(numPopulation, dimension, lowerBound, upperBound, start_pop1){
	result <- matrix()
	if(length(lowerBound)==1){
		result <- matrix(runif(numPopulation*dimension, lowerBound, upperBound), nrow=numPopulation, ncol=dimension)

	}else{
		result <- matrix(nrow=numPopulation, ncol=dimension)
		for (i in 1:dimension){
			# result[,i] = runif(numPopulation, lowerBound[i], upperBound[i])
		  result = start_pop1
		}
	}
	return(result)
}

# this function will generate the random number with defined boundary
# @param numPopulation number population / number row
# @param dimension number variable / number column
# @param lowerBound lower bound for each variable
# @param upperBound upper bound for each variable

generateRandom_orig <- function(numPopulation, dimension, lowerBound, upperBound){
  result <- matrix()
  if(length(lowerBound)==1){
    result <- matrix(runif(numPopulation*dimension, lowerBound, upperBound), nrow=numPopulation, ncol=dimension)
    
  }else{
    result <- matrix(nrow=numPopulation, ncol=dimension)
    for (i in 1:dimension){
      result[,i] = runif(numPopulation, lowerBound[i], upperBound[i])
      # result[,i] = upperBound[i]
    }
  }
  return(result)
}


# this function is for calculating the fitness
# @param FUN objective function
# @param optimType type optimization
# @param popu population of candidate

calcFitness <- function(FUN, optimType, popu){
	fitness <- c()
	for (i in 1:nrow(popu)) {
		fitness[i] <- optimType*FUN(popu[i,])
	}
	return(fitness)
}

# this function is for calculating the best fitness
# @param FUN objective function
# @param optimType type optimization
# @param popu population of candidate

calcBest <- function(FUN, optimType, popu){
	fitness <- calcFitness(FUN, optimType, popu)
	best <- popu[which.max(fitness),]
	return(best)
}

# this function used to check the boundary for each dimension/variable
# @param position is vector of position
# @param lowerBound lower bound for each variable
# @param upperBound upper bound for each variable

checkBound <- function(position, lowerBound, upperBound){
	check1 <- position > upperBound
	check2 <- position < lowerBound

	result <- (position*(!(check1+check2)))+upperBound*check1+lowerBound*check2
	return(result)
}

# function to get index resulting roulette whell selection method
# @param weight vector of double

rouletteWhell <- function(weight){
	# handle negative number
	if(any(weight<0)){
		c <- -weight[which.min(weight)]
		weight <- weight+c+1
	}
	# count the cumulative sum
	accumulation <- cumsum(weight)
	# pick a random number
	r <- runif(1)*accumulation[length(accumulation)]

	# index to pick [default value is 1]
	result <- 1
	for (i in 1:length(accumulation)){
		if(accumulation[i] > r){
			result <- i
			break
		}
	}
	return(result)
}

# example of test function sphere
sphere <- function(X){
	X <- sum(X^2)
	return(X)
}

# example of test function schwefel
schwefel <- function(X){
	X <- sum(-X*sin(sqrt(abs(X))))
	return(X)
}

# example of test function rastrigin
rastrigin <- function(X){
	X <- sum((X^2)-10*cos(2*pi*X)+10)
	return(X)
}

# example of test function for determing the centilever beam
# the real problem
centileverBeam <- function(X){
	FX <- 0.6224*sum(X)
	x3 <- X^3
	up <- c(61,37,19,7,1)
	part <- sum(up/x3) - 1
	decision <- max(part,0)
	res <- FX + (10e+17*decision)
	return(res)
}

## p-1 p-2 p-3

MAE <- function(dataHarga, X){
	value <- dataHarga[,4] ## get value
	dataHarga <- dataHarga[,1:3] ## get feature
	dataHarga <- cbind(dataHarga, rep(1, nrow(dataHarga)))
	matrix_of_x <- matrix(rep(X,nrow(dataHarga)), nrow = nrow(dataHarga), byrow = TRUE)
	result <- rowSums(dataHarga*matrix_of_x)
	# calculating MAE
	result <- mean(abs(result-value))
	return(result)
}


## Extract results
extract_results = function(a1){
  ##Long-term convergence results graph - Figure 2
  max_length <- max(unlist(lapply(a1$curve_result,length)))
  nm_filled <- lapply(a1$curve_result,function(x) {ans <- rep(NA,length=max_length);
  ans[1:length(x)]<- x;
  return(ans)})
  # nm_filled = unlist(a1$curve_result)
  # nm_matrix = matrix()
  tj_filled <- lapply(a1$trajectory,function(x) {ans <- rep(NA,length=max_length);
  ans[1:length(x)]<- x;
  return(ans)})
  tj_matrix = matrix(unlist(a1$trajectory), ncol = nrow(dataStudy), byrow = T)
  
  time_df = a1$timeElapsed[,1]
  convergence_results = do.call(rbind, nm_filled) %>%
    data.frame() %>%
    cbind(time_df) %>%
    # pivot_longer(!X1, names_to = 'iteration', values_to = 'criteria', names_prefix = '_') %>%
    pivot_longer(-c(time_df), 
                 names_to = 'iteration', 
                 values_to = 'criteria', 
                 names_prefix = '_') %>%
    mutate(iteration2 = as.numeric(substr(iteration, 2, 4)))
  convergence_results = convergence_results[complete.cases(convergence_results),]
  #Change to dataframe
  tj_mat2 = data.frame(tj_matrix) %>%
    round()
  extras = data.frame(running_cost = apply(round(tj_mat2), 1, GC),
                      running_PoS  = apply(round(tj_mat2), 1, FPoS),
                      numSites     = rowSums(round(tj_mat2)),
                      numCountries = rowSums(round(tj_mat2) > 0))
  tj_mat2 = cbind(extras, tj_mat2)
  # tj_mat2$numSites = rowSums(round(tj_mat2))
  # tj_mat2$numCountries = rowSums(round(tj_mat2) > 0)
  # b = cbind(convergence_results, tj_matrix)
  b = cbind(convergence_results, tj_mat2)
  # b = rbind(b, b)
  startPos = c(which(b$iteration == 'X2'), nrow(b))
  # startPos[1] = startPos[1] - 1
  startPos[length(startPos)] = startPos[length(startPos)] + 1
  diff(startPos)
  # b$algo_run = rep(c(1:each_times), times = c(diff(startPos)))
  b$algo = rep(c(algos), times = c(diff(startPos)))
  # rep_run = rep(c(1:each_times), length(unique(algos)))
  rep_run = 1:length(algos)
  b$run = rep(c(rep_run), times = c(diff(startPos)))
  return(b)
}
