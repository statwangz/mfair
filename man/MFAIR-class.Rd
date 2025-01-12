% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mfairObject.R
\docType{class}
\name{MFAIR-class}
\alias{MFAIR-class}
\title{Each MFAIR object has a number of slots which store information. Key slots to access are listed below.}
\value{
MFAIR class.
}
\description{
Each MFAIR object has a number of slots which store information. Key slots to access are listed below.
}
\section{Slots}{

\describe{
\item{\code{Y}}{A matrix or Matrix::dgCMatrix. The main data matrix of N samples and M features.}

\item{\code{X}}{A data.frame. The auxiliary information data frame of N samples and C covariates.}

\item{\code{Y_sparse}}{Logical. Whether the main data matrix Y is stored in the sparse mode.}

\item{\code{Y_center}}{Logical. Whether the main data matrix Y is centered.}

\item{\code{Y_mean}}{Numeric. Mean of the main data matrix Y if centered. Zero if not.}

\item{\code{Y_missing}}{Logical. Whether the main data matrix Y is partially observed.}

\item{\code{n_obs}}{integer. Total number of observed entries in Y.}

\item{\code{N}}{An integer. Number of rows (samples) of Y, also the number of rows (samples) of X.}

\item{\code{M}}{An integer. Number of columns (features) of Y.}

\item{\code{C}}{An integer. Number of columns (auxiliary covariates) of X.}

\item{\code{K_max}}{An integer. Please note that increasing K_max does not ensure that the actual K also increases since K_max is just an upper bound, and the model will automatically infer K below K_max under the default setting. If you want to fit the model with larger rank K, please set the \code{null_check} argument as FALSE, or make sure that K_max is large enough and the \code{tol_snr} argument in the fitting function \code{fitGreedy()} is small enough simultaneously in the fitting function \code{fitGreedy()}.}

\item{\code{K}}{An integer. The inferred rank of Y.}

\item{\code{Z}}{An N * K matrix. Estimated loading matrix, corresponding to the inferred posterior mean of Z in the MFAI model.}

\item{\code{a_sq}}{A matrix containing posterior variance of Z with k-th column corresponding to the k-th loading. For fully observed Y, all N elements of one specific loading share the same posterior variance, then a_sq is a 1 * K matrix. For Y with missing data, elements of one specific loading have different posterior variances, then a_sq is an N * K matrix.}

\item{\code{W}}{An M * K matrix. Estimated factor matrix, corresponding to the inferred posterior mean of W in the MFAI model.}

\item{\code{b_sq}}{A matrix containing posterior variance of W with k-th column corresponding to the k-th factor. For fully observed Y, all M elements of one specific factor share the same posterior variance, then b_sq is a 1 * K matrix. For Y with missing data, elements of one specific factor have different posterior variances, then b_sq is an M * K matrix.}

\item{\code{tau}}{Numeric. A vector of length K, containing the precision parameter for each pair of loading/factor.}

\item{\code{beta}}{Numeric. A vector of length K, containing the precision parameter for each loading Z_k.}

\item{\code{FX}}{An N * K matrix representing the prior mean of Z, corresponding to F(X) in the MFAI model.}

\item{\code{tree_0}}{An 1 * K matrix containing tree_0 with k-th column corresponding to the k-th factor. Tree_0 is defined as the mean of mu vector in each factor.}

\item{\code{tree_lists}}{A list of length K, containing K fitted functions and each function is represented as a list of trees, i.e., the k-th list corresponds to function F_k(.) in the MFAI model.}

\item{\code{initialization}}{A list. Initialization of the fitted model.}

\item{\code{learning_rate}}{Numeric. The learning rate in the gradient boosting part.}

\item{\code{tree_parameters}}{A list of options that control details of the rpart algorithm.}

\item{\code{project}}{Character. Name of the project (for record keeping).}
}}

