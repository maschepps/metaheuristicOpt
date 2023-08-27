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
1. **Increased Output**: Included history of best performing search per algorithm.
1. **Convergence criterion**: Improved performance and stability for Algorithm X.
2. **Starting Population**: Added tools for statistical analysis of optimization results.

### Bugs
1. **Does not work with all algorithms**: Resolved a bug affecting the convergence of Algorithm Y.

### Performance Improvements
1. **Reduced Time Complexity**: Algorithm Z's time complexity reduced from O(n^2) to O(n log n).

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
objective_function <- function(x) {
  # Your objective function here
}

# Define upper and lower bounds for decision variables
# Upper and Lower Bounds

vecLow = rep(0, 5)
vecUpp = rep(10, 5)
rangeV = matrix(t(data.frame(a = vecLow, b = vecUpp)), nrow = 2)

# Define starting population
## Must be exact dimension of nrow (numPopulation) by ncol (dimension of problem)

start_pop = matrix(rep(vecUpp, 40), nrow = 40, byrow = T)


# Choose algorithms to use
# Can be multiple of same
algos = c('GWO','GWO','HS','HS')

# Call enhanced Algorithm X
results <-  metaOpt(FUN = objective_function,
            optimType = 'MIN',
            algorithm = algos,
            numVar = length(vecUpp),
            rangeVar = rangeV,
            control = list(numPopulation = 40,
                           maxIter = 10000, 
                           start  = start,
                           c_length = 5,
                           c_value = 1))
```
## Bugs

### Not every algorithm is compatible with all the newest additions

# ABC still uses generateRandomABC



