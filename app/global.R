library(shiny)
library(data.table)
# Require: EnvStats
# Require: REAT
# Require: glue

rpareto <- function(n) EnvStats::rpareto(n, location = 1)
rnorm2 <- function(n) rnorm(n, mean = 5)

make_text_out <- function(prefix, value){
  glue::glue("<h4><b>{prefix}</b></h4>{round(value, 3)}")
}

# Prioritarian Functions
Plorenz <- function(x=1, y, plot=FALSE){
  dt = data.table(x = x, y = y, slope = y/x)[order(slope)]
  dt[,cx := cumsum(x)]
  dt[,cnx := cumsum(x/sum(x))]
  dt[,cy := cumsum(y)]
  dt[,cny := cumsum(y/sum(y))]
  dt[,need := cx * slope - cy] # Need to get everyone to this slope
  dt[,cnn := cumsum(need/sum(need))]
  if(plot) dt = rbind(data.table(cnx=0, cny=0), dt, fill=TRUE)
  return(dt[])
}

Pallocate <- function(dt, avail, plot=TRUE){
  dt <- data.table::copy(dt) # need to make a copy as to not modify in place
  og_dist = dt[,sum(y)]
  slope_to_achieve = dt[need <= avail, max(slope)]
  dt[need <= avail, y := x * slope_to_achieve]
  remainder = dt[, avail - sum(y) + og_dist]
  dt[need <= avail, y := y + (x / sum(x)) * remainder]
  
  return(dt[,Plorenz(x, y, plot)])
}