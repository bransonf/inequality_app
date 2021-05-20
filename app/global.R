library(shiny)
# Require: EnvStats
# Require: REAT
# Require: glue

rpareto <- function(n) EnvStats::rpareto(n, location = 1)
rnorm2 <- function(n) rnorm(n, mean = 5)

make_text_out <- function(prefix, value){
  glue::glue("<h4><b>{prefix}</b></h4>{round(value, 3)}")
}