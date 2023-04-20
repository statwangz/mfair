
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mfair: Matrix Factorization with Auxiliary Information in R

<!-- badges: start -->
<!-- badges: end -->

Methods for matrix factorization to leverage auxiliary information based
on the paper [MFAI: A scalable Bayesian matrix factorization approach to
leveraging auxiliary
information](https://doi.org/10.48550/arXiv.2303.02566). The name of the
package `mfair` comes from **Matrix Factorization with Auxiliary
Information in R**.

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
#> Loading required package: rpart

# Simulate data
# Set the data dimension and rank
N <- 100
M <- 100
K_true <- 2L

# Set the proportion of variance explained (PVE)
PVE_Z <- 0.8
PVE_Y <- 0.5

# Generate auxiliary information X
X1 <- runif(N, min = -10, max = 10)
X2 <- runif(N, min = -10, max = 10)
X <- cbind(X1, X2)

# F(X)
FX1 <- X1 / 2 - X2
FX2 <- (X1^2 - X2^2 + 2 * X1 * X2) / 10
FX <- cbind(FX1, FX2)

# Generate loadings Z (= F(X) + noise)
sig1_sq <- var(FX1) * (1 / PVE_Z - 1)
Z1 <- FX1 + rnorm(n = N, mean = 0, sd = sqrt(sig1_sq))
sig2_sq <- var(FX2) * (1 / PVE_Z - 1)
Z2 <- FX2 + rnorm(n = N, mean = 0, sd = sqrt(sig2_sq))
Z <- cbind(Z1, Z2)

# Generate factors W
W <- matrix(rnorm(M * K_true), nrow = M, ncol = K_true)

# Generate the main data matrix Y_obs (= Y + noise)
Y <- Z %*% t(W)
Y_var <- var(as.vector(Y))
epsilon_sq <- Y_var * (1 / PVE_Y - 1)
Y_obs <- Y + matrix(
  rnorm(N * M,
    mean = 0,
    sd = sqrt(epsilon_sq)
  ),
  nrow = N, ncol = M
)

# Create MFAIR object
mfairObject <- createMFAIR(Y_obs, X, K_max = K_true)

# Fit the MFAI model
mfairObject <- fitGreedy(mfairObject, sf_para = list(verbose_loop = FALSE))
#> Set K_max = 2!
#> After 1 iterations Stage 1 ends!
#> After 43 iterations Stage 2 ends!
#> Factor 1 retained!
#> After 1 iterations Stage 1 ends!
#> After 40 iterations Stage 2 ends!
#> Factor 2 retained!

# Prediction based on the low-rank approximation
Y_hat <- predict(mfairObject)
#> The main data matrix Y has no missing entries!

# Root-mean-square-error
sqrt(mean((Y_obs - Y_hat)^2))
#> [1] 12.22526

# Predicted/true matrix variance ratio
var(as.vector(Y_hat)) / var(as.vector(Y_obs))
#> [1] 0.471485

# Prediction/noise variance ratio
var(as.vector(Y_hat)) / var(as.vector(Y_obs - Y_hat))
#> [1] 0.9884637
```

`mfair` can also handle the matrix with missing entries:

``` r
# Split the data into the training set and test set
n_all <- N * M
training_ratio <- 0.5
train_set <- sample(1:n_all, n_all * training_ratio, replace = FALSE)
Y_train <- Y_test <- Y_obs
Y_train[-train_set] <- NA
Y_test[train_set] <- NA

# Create MFAIR object
mfairObject <- createMFAIR(Y_train, X, K_max = K_true)

# Fit the MFAI model
mfairObject <- fitGreedy(mfairObject, sf_para = list(verbose_loop = FALSE))
#> Set K_max = 2!
#> After 1 iterations Stage 1 ends!
#> After 68 iterations Stage 2 ends!
#> Factor 1 retained!
#> After 1 iterations Stage 1 ends!
#> After 66 iterations Stage 2 ends!
#> Factor 2 retained!

# Prediction based on the low-rank approximation
Y_hat <- predict(mfairObject)

# Root-mean-square-error
sqrt(mean((Y_test - Y_hat)^2, na.rm = TRUE))
#> [1] 12.88825

# Predicted/true matrix variance ratio
var(as.vector(Y_hat), na.rm = TRUE) / var(as.vector(Y_obs), na.rm = TRUE)
#> [1] 0.4311948

# Prediction/noise variance ratio
var(as.vector(Y_hat), na.rm = TRUE) / var(as.vector(Y_obs - Y_hat), na.rm = TRUE)
#> [1] 0.8554015
```

For more documentation and examples, please visit our package
[website](https://yanglabhkust.github.io/mfair/).

## Citing our work

If you find the `mfair` package or any of the source code in this
repository useful for your work, please cite:

> Wang, Z., Zhang, F., Zheng, C., Hu, X., Cai, M., and Yang, C. (2023).
> MFAI: A scalable Bayesian matrix factorization approach to leveraging
> auxiliary information. arXiv preprint arXiv:2303.02566. URL:
> <https://doi.org/10.48550/arXiv.2303.02566>.

## Development

The package is developed by Zhiwei Wang (<zhiwei.wang@connect.ust.hk>).

## Contact Information

Please feel free to contact Zhiwei Wang (<zhiwei.wang@connect.ust.hk>),
Prof. Mingxuan Cai (<mingxcai@cityu.edu.hk>), or Prof. Can Yang
(<macyang@ust.hk>) if any inquiries.
