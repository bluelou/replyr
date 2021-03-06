% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DebugFn.R
\name{DebugFnWE}
\alias{DebugFnWE}
\title{Wrap function to capture arguments and environment of exception throwing function call for later debugging.}
\usage{
DebugFnWE(saveDest, fn, ...)
}
\arguments{
\item{saveDest}{path to save RDS or function to pass argument to for saving.}

\item{fn}{function to call}

\item{...}{arguments for fn}
}
\value{
wrapped function that captures state on error.
}
\description{
Wrap fn, so it will save arguments and environment on failure.
}
\examples{

saveDest <- paste0(tempfile('debug'),'.RDS')
f <- function(i) { (1:10)[[i]] }
df <- DebugFnWE(saveDest, f)
# correct run
df(5)
# now re-run
# capture error on incorrect run
tryCatch(
   df(12),
   error = function(e) { print(e) })
# examine details
situation <- readRDS(saveDest)
str(situation)
# fix and re-run
situation$args[[1]] <- 6
do.call(situation$fn, situation$args, envir=situation$env)
# clean up
file.remove(saveDest)

}
\seealso{
\code{\link{DebugFn}}, \code{\link{DebugFnW}},  \code{\link{DebugFnWE}}, \code{\link{DebugPrintFn}}, \code{\link{DebugFnE}}, \code{\link{DebugPrintFnE}}

Idea from: https://gist.github.com/nassimhaddad/c9c327d10a91dcf9a3370d30dff8ac3d
}

