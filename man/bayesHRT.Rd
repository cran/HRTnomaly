\name{bayesHRT}
\Rdversion{1.1}
\alias{bayesHRT}
\encoding{UTF-8}

\title{Calculate Cellwise Flags for Anomaly Detection Using Bayesian Testing}

\description{
The function uses the predictive posterior distribution based on emprical likelihoods to determine if a data entry is an outlier on not.
The function takes a long-format \code{data.frame} object as input and returns it with two appended vectors.
The first vector contains the posterior probabilities as numbers between zero and one, and the second vector provides 
a set of logical values indicating whether the data entry is an outlier (\code{TRUE}) or not (\code{FALSE}).
}

\usage{
bayesHRT(a, prior = NULL)
}

\arguments{
  \item{a}{A long-format \code{data.frame} object with survey data. For details see information on the data format.}
  \item{prior}{A numerical value or vector of cell-level prior probabilites of observing an outlier. It is \code{NULL} by default. If false, the function searchers for a column named \code{"prior"} within the dataset. If such column is not provided in the dataset, a \code{0.5} non-informative value is used for all cells.}
}

\details{
The argument \code{a} is proivded as an object of class \code{data.frame}.
This object is considered as a long-format \code{data.frame}, and it must have at least five columns with the following names:
\describe{
  \item{\code{"strata"}}{a \code{character} or \code{factor} column containing the information on the stratification.}
  \item{\code{"unit_id"}}{a \code{character} or \code{factor} column containing the ID of the statistical unit in the survey sample(x, size, replace = FALSE, prob = NULL).}
  \item{\code{"master_varname"}}{a \code{character} column containing the name of the observed variable.}
  \item{\code{"current_value_num"}}{a \code{numeric} the observed value, i.e., a data entrie}
  \item{\code{"pred_value"}}{a \code{numeric} a value observed on a previous survey for the same variable if available. If not available, the value can be set to \code{NA} or \code{NaN}. When working with longitudinal data, the value can be set to a time-series forecast or a filtered value.}
  \item{\code{"prior"}}{a \code{numeric} a value of prior probabilities of observign an outlier for the cell. If this column is omitted in the dataset provided, the function will use the values provided through the argument \code{prior}.}}
The \code{data.frame} object in input can have more columns, but the extra columns would be ignored in the analyses.
However, these extra columns would be preserved in the system memory and returned along with the results from the cellwise outlier-detection analysis.

The use of the R-packages \code{dplyr}, \code{purrr}, and \code{tidyr} is highly recommended to simplify the conversion of datasets between long and wide formats.
}

\value{The long-format \code{data.frame} is provided as input data and contains extra columns i.e., anomaly flags and outlier posterior predictive distribution.}

\author{Luca Sartore \email{drwolf85@gmail.com}}

\examples{
# Load the package
library(HRTnomaly)
set.seed(2025L)
# Load the 'toy' data
data(toy)
# Detect cellwise outliers
res <- bayesHRT(toy[sample.int(100), ], prior = 0.5)
}

\keyword{outliers}
\keyword{distribution}
\keyword{probability}
