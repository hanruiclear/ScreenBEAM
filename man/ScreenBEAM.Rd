% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/ScreenBEAM.R
\name{ScreenBEAM}
\alias{ScreenBEAM}
\title{Gene-level meta-analysis of high-throughput functional genomics (RNAi or CRISPR) screens via Bayesian Hierarchical Modeling}
\usage{
ScreenBEAM(input.file, control.samples, case.samples,
  data.type = c("microarray", "NGS"), control.groupname = "control",
  case.groupname = "treatment", gene.columnId = 2,
  do.normalization = FALSE, filterLowCount = FALSE, filterBy = "control",
  count.cutoff = 4, nitt = 15000, burnin = 5000, ...)
}
\arguments{
\item{input.file}{input file in tab-separated format, with the first two columns as sh/sgRNA id, gene id, followed by samples}

\item{control.samples}{column names of control samples}

\item{case.samples}{column names of case/treated samples}

\item{data.type}{data type, eith microarray or NGS
param control.groupname group name for control samples, control as default}

\item{case.groupname}{group name for control samples, treatment as default}

\item{gene.columnId}{which column is for gene id, 2 as default}

\item{do.normalization}{whether to do normalization on the data or not, default is FALSE. If TRUE, scale normalization will be applied to NGS data and quantile normalization will applied to microarray data.}

\item{filterLowCount}{for NGS data only, whether to filter out low count sh/sgRNAs}

\item{filterBy,count.cutoff}{if filterLowCount as true, filterBy which group (control as default) at which threhsold (4 as default)}

\item{nitt}{number of MCMC iterations, 15000 as default}

\item{burnin}{number of burnin for MCMC sampling, 5000 as default}
}
\value{
A data.frame table with the following columns: gene (gene id), n.sh_sgRNAs.raw (number of sh/sgRNAs targeting this gene before data filtering), n.sh_sgRNAs.passFilter (number of sh/sgRNAs targeting this gene after data filtering),B (coefficient of the gene-level effect or fixed effects in the mixture model, indicating the gene-level effects),z (z-score of the gene-level effect),pval (p-value of gene-level effect),FDR (False Discovery Rate),B.sd (standard deviation of gene-level coefficient)
}
\description{
ScreenBEAM is an R package to do gene-level meta-anlaysis of high-throughput functional genomics RNAi or CRISPR screening data. Both microarray and NGS data are supported.
}
\examples{
library(ScreenBEAM)
#NGS data
r<-ScreenBEAM(

  ###input format
  input.file=system.file("extdata", "microarray.example.tsv", package = "ScreenBEAM")
  ,
  control.samples=c('T0_A','T0_B','T0_C')
  ,
  case.samples=c('T16_A','T16_B','T16_C')
  ,
  control.groupname='T0'
  ,
  case.groupname='T16'
  ,

  ###data pre-processing
  data.type='NGS'
  ,
  do.normalization=TRUE
  ,
  filterLowCount=TRUE
  ,
  filterBy = 'control'
  ,
  count.cutoff=4
  ,

  ###Bayesian computing
  nitt=1500,#number of MCMC iterations, use small number here for testing, please use larger number in real data, 15000 is default
  burnin=500#number of burnin in MCMC sampling, 5000 is default

)

###microarray data
r<-ScreenBEAM(

  ###input format
  input.file=system.file("extdata", "microarray.example.tsv", package = "ScreenBEAM")
  ,
  control.samples=c('T0_A','T0_B','T0_C')
  ,
  case.samples=c('T16_A','T16_B','T16_C')
  ,
  control.groupname='T0'
  ,
  case.groupname='T16'
  ,

  ###data pre-processing
  data.type='microarray'
  ,
  do.normalization=FALSE
  ,

  ###Bayesian computing
  nitt=1500,#number of MCMC iterations, use small number here for testing, please use larger number in real data, 15000 is default
  burnin=500#number of burnin in MCMC sampling, 5000 is default

)

head(r)


###save your results
#write.csv(r,file=file.path('results.ScreenBEAM.csv'),row.names=FALSE,na='')
}
\author{
Jiyang Yu
}
\references{
Yu J, Silva, J, Califano A. ScreenBEAM: a Novel Meta-Analysis Algorithm for Functional Genomics Screens via Bayesian Hierarchical Modeling. Bioinformatics (In revision), 2015.
}

