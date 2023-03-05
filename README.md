
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mfair: Matrix Factorization with Auxiliary Information in R

<!-- badges: start -->
<!-- badges: end -->

Methods for matrix factorization to leverage auxiliary information based
on the paper MFAI. The name of the package `mfair` comes from “Matrix
Factorization with Auxiliary Information in R”.

## Installation

You can install the development version of `mfair` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("YangLabHKUST/mfair")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
set.seed(20230306)
library(mfair)
library(MASS)

# Simulate data
N <- 100
M <- 100
K_true <- 2L

PVE_Z <- 0.8
PVE_Y <- 0.5

X1 <- runif(N, min = -10, max = 10)
X2 <- runif(N, min = -10, max = 10)
X <- cbind(X1, X2)

FX1 <- X1 / 2 - X2
FX2 <- (X1^2 - X2^2 + 2 * X1 * X2) / 10
FX <- cbind(FX1, FX2)

beta1 <- var(FX1) * (1 / PVE_Z - 1)
Z1 <- mvrnorm(n = 1, mu = FX1, Sigma = beta1 * diag(N))
beta2 <- var(FX2) * (1 / PVE_Z - 1)
Z2 <- mvrnorm(n = 1, mu = FX2, Sigma = beta2 * diag(N))
Z <- cbind(Z1, Z2)

W <- matrix(rnorm(M * K_true), nrow = M, ncol = K_true)

Y <- Z %*% t(W)
Y_var <- var(as.vector(Y))
epsilon <- sqrt(Y_var * (1 / PVE_Y - 1))
Y_obs <- Y + matrix(rnorm(N * M, sd = epsilon), nrow = N, ncol = M)

# Create MFAIR object
mfairObject <- createMFAIR(Y_obs, X, K_max = K_true)

# Fit the MFAI model
# mfairObject <- fitGreedy(mfairObject)
```

## Development

The package is developed by Zhiwei Wang (<zhiwei.wang@connect.ust.hk>).

## Contact Information

Please feel free to contact Zhiwei Wang (<zhiwei.wang@connect.ust.hk>),
Prof. Mingxuan Cai (<mingxcai@cityu.edu.hk>), or Prof. Can Yang
(<macyang@ust.hk>) with any inquiries.
