# metaheuristicOpt
:exclamation: This is a read-only mirror of the CRAN R package repository.  metaheuristicOpt — Metaheuristic for Optimization  
# Fork of metaheuristicOpt: Enhanced Metaheuristic Optimization Algorithms in R

This is a fork of the original `metaheuristicOpt` R package. This fork includes custom features made as part of my PhD thesis. The package aims to provide an even more robust, efficient, and flexible toolkit for metaheuristic optimization in R.

## Table of Contents

- [Modifications](#modifications)
- [Installation](#installation)
- [Usage](#usage)
- [Documentation](#documentation)
- [Examples](#examples)
- [Citation](#citation)
- [Acknowledgements](#acknowledgements)
- [License](#license)

## Modifications

### New Features
1. **Convergence capability**: Includes new options convergence length, "c_length", and convergence criterion value, "c_value".
2. **Starting Population**: Starting population may be manually entered, although default is still generateRandom, (now called generateRandom_Orig()). This produces a random starting population within the lower and upper bounds.
3. **New metrics**:
    - History of best path
    - Stop iteration

## Installation

To install this modified version, run the following command in your R environment:

```R
# Install from GitHub
devtools::install_github("maschepps/metaheuristicOpt_fork")
```

## Usage

### Basic Example
Here's a basic example showcasing the usage of enhanced Algorithm X:

```R
# Load the package
library(metaheuristicOpt)

# Define your objective function
objective_function <- function(xx) {
  # Your objective function here
    d <- length(xx)
	
  sum <- sum(xx^2 - 10*cos(2*pi*xx))
	
  y <- 10*d + sum
  return(y)
}
rastrigin <- function(x) {
  A <- 10
  n <- length(x)
  result <- A * n
  
  for(i in 1:n) {
    result <- result + (x[i]^2 - A * cos(2 * pi * x[i]))
  }
  
  return(result)
}


# Define upper and lower bounds for decision variables
# Upper and Lower Bounds

vecLow = rep(-10, 5)
vecUpp = rep(10, 5)
rangeV = matrix(t(data.frame(a = vecLow, b = vecUpp)), nrow = 2)

# Define starting population
## Defaults to original package's generateRandom(), a random value between the lower and upper bounds.
## If you want to define your own, currently, must be exact dimension of nrow (numPopulation) by ncol (dimension of problem)
## 
start_pop = matrix(rep(vecUpp, 40), nrow = 40, byrow = T)

# Choose algorithms to use
## Can be multiple of same
algos = c('GWO','GWO','HS','HS')

# Call enhanced Algorithm X
results <-  metaOpt(FUN = cost_90,
            optimType = 'MIN',
            algorithm = algos,
            numVar = length(vecUpp),
            rangeVar = rangeV,
            control = list(numPopulation = 40,
                           maxIter = 10000, 
                           start  = start_pop,
                           c_length = 5,
                           c_value = 1))
                           
# Call new output into a data frame
df_results = extract_results(results)
```
### Bugs (literally)
1. **Does not work with all 21 originally programmed algorithms**: Resolved a bug affecting the convergence of Algorithm Y.
ABC still uses generateRandomABC


### Performance Improvements
1. **Reduced Time Complexity**: Algorithm Z's time complexity reduced from O(n^2) to O(n log n).


