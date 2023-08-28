
This is a fork of the original `metaheuristicOpt` R package, Enhanced Metaheuristic Optimization Algorithms in R. This original package contains a collection of R coded nature inspired metaheuristics. This fork includes custom features made as part of my PhD thesis. The newest updates aim to provide an even more robust, efficient, and flexible toolkit for metaheuristic optimization in R.

## Table of Contents

- [Modifications](#modifications)
- [Installation](#installation)
- [Usage](#usage)
- [Known Bugs (literally)](#known-bugs-literally)
- [Acknowledgements](#acknowledgements)
- [License](#license)

## Modifications

### New Features
1. **Convergence capability**: Includes new options to implement a convergence criterion:
    - Value of convergence criterion - "c_value"
    - Length of repetitions - "c_length"
2. **New metrics**:
    - History of best path
    - Stop iteration
3. **Starting Population**: Starting population may be manually entered, although default is still generateRandom, (now called generateRandom_Orig()). This produces a random starting population within the lower and upper bounds.


## Installation

To install this modified version, run the following command in your R environment:

```R
# Install from GitHub
devtools::install_github("maschepps/metaheuristicOpt")
```

## Usage

### Newest Updates

We included new input and output capabilities. 

#### New Inputs
The inputs are in addition to the options provided by the original package, contained in a list. The last three lines are the newest input updates.

- start_pop = start_pop
- c_length = 500
- c_value  = 1

This means we elect to start our search from a specific starting population (to be discussed). And the search will go until it finds 500 consecutive iterations whose values differs by 1 or less.

```R
results <-  metaOpt(FUN = objective_function,
            optimType = 'MIN',
            algorithm = algos,
            numVar = length(vecUpp),
            rangeVar = rangeV,
            control = list(numPopulation = 40,
                           maxIter = 10000, 
                           start  = start_pop, # Newest update
                           c_length = 5, # Newest Update
                           c_value = 1)) # Newest Update
```
Currently, this starting population must be entered as a matrix where each row represents an individual initial search spot (can be duplicated). The matrix must have the same number of rows as the number of search agents to be used in the following function (numPopulation).

#### New Outputs

The outputs can now be framed in a tidy data frame with all the newest information by using the new function, `extract_results()`.

```R
# Call new output into a data frame
df_results = extract_results(results) # Newest function
```

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

# Define upper and lower bounds for decision variables
# Upper and Lower Bounds

vecLow = rep(-10, 5)
vecUpp = rep(10, 5)
rangeV = matrix(t(data.frame(a = vecLow, b = vecUpp)), nrow = 2)

# Define starting population
## Defaults to original package's generateRandom(), a random value between the lower and upper bounds.
## If you want to define your own, currently, must be exact dimension of nrow (numPopulation) by ncol (dimension of problem)
## Example: Define starting population as upper bound.
start_pop = matrix(rep(vecUpp, 40), nrow = 40, byrow = T)

# Choose algorithms to use
## Can be multiple of same for separate runs of the same algorithm
algos = c('GWO','GWO','HS','HS')

# Call enhanced Algorithm X
results <-  metaOpt(FUN = objective_function,
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

## Known Bugs literally
1. **New functions work with 12/21 originally programmed algorithms. The remaining 9 are untouched.**: 

| **Working Algorithms** | **Non-updated Algorithms** |
| :------------------- | :------------------------ |
|Particle Swarm Optimization (PSO) | Artificial Bee Colony (ABC) |
|Ant Lion Optimizer (ALO) | Bat Algorithm (BA) |
|Clonal Algorithm (CLONALG) | Black Hole Algorithm (BHO) |
| Dragonfly Algorithm (DA) | Cuckoo Search (CS) |
| Firefly Algorithm (FFA) | Cat Swarm Optimization (CSO) |
| Genetic Algorithm (GA) | Differential Evolution (DE) |
| Grasshopper Optimization Algorithm (GOA) | Gravitational Based Search (GBS) |
| Grey Wolf Optimizer (GWO) | Krill Herd (KH) |
| Harmony Search (HS) | Shuffled Frog Leaping (SFL) |
| Moth Flame Optimizer (MFO) |  |
| Sine Cosine Algorithm (SCA) |  |
| Whale Optimization Algorithm (WOA) |  |


## Acknowledgements
This project was done with the help and support of Dr. Weng Kee Wong, UCLA's Department of Biostatistics, and Vladimir Anisimov, Matt Austin, Stephen Gormley, and Behzad Beheshti from Amgen's Center for Design and Analysis.

## License
This project maintains the same license as the original metaheuristicOpt package.
