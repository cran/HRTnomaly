\name{bootHRT}
\Rdversion{1.1}
\alias{bootHRT}
\encoding{UTF-8}

\title{Calculate Cellwise Flags for Anomaly Detection Using Bayesian Bootstrap}

\description{
The function uses Bayesian bootstrap to determine if a data entry is an outlier on not.
The function takes a long-format \code{data.frame} object as input and returns it with two appended vectors.
The first vector contains the anomaly scores as numbers between zero and one, and the second vector provides 
a set of logical values indicating whether the data entry is an outlier (\code{TRUE}) or not (\code{FALSE}).
}

\usage{
bootHRT(a, contamination = 0.08, boot_max_it = 1000L)
}

\arguments{
  \item{a}{A long-format \code{data.frame} object with survey data. For details see information on the data format.}
  \item{contamination}{A number between zero and one used as a threshold when identifying outliers from the fuzzy scores. 
  By default, the algorithm will identify approximately 8\% of the data entries as anomalies.}
  \item{boot_max_it}{An integer number determining the iterations performed by Bayesian bootstrap algorithm. It is set to \code{1000} by default.}
}

\details{
The argument \code{a} is proivded as an object of class \code{data.frame}.
This object is considered as a long-format \code{data.frame}, and it must have at least five columns with the following names:
\describe{
  \item{\code{"strata"}}{a \code{character} or \code{factor} column containing the information on the stratification.}
  \item{\code{"unit_id"}}{a \code{character} or \code{factor} column containing the ID of the statistical unit in the survey sample(x, size, replace = FALSE, prob = NULL).}
  \item{\code{"master_varname"}}{a \code{character} column containing the name of the observed variable.}
  \item{\code{"current_value_num"}}{a \code{numeric} the observed value, i.e., a data entrie}
  \item{\code{"pred_value"}}{a \code{numeric} a value observed on a previous survey for the same variable if available. If not available, the value can be set to \code{NA} or \code{NaN}. When working with longitudinal data, the value can be set to a time-series forecast or a filtered value.}}
The \code{data.frame} object in input can have more columns, but the extra columns would be ignored in the analyses.
However, these extra columns would be preserved in the system memory and returned along with the results from the cellwise outlier-detection analysis.

The use of the R-packages \code{dplyr}, \code{purrr}, and \code{tidyr} is highly recommended to simplify the conversion of datasets between long and wide formats.
}

\value{The long-format \code{data.frame} is provided as input data and contains extra columns i.e., anomaly flags and outlier indicators columns. The samples from the posterior distribution of the contamination threshold are attached as an attribute vector of length \code{B} named \code{"thresholds"}.}

\author{Luca Sartore \email{drwolf85@gmail.com}}

\examples{
# Load the package
library(HRTnomaly)
set.seed(2025L)
# Load the 'toy' data
data(toy)
# Detect cellwise outliers
res <- bootHRT(toy, boot_max_it = 10)
}

\keyword{outliers}
\keyword{distribution}
\keyword{probability}
