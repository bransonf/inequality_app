FROM rocker/r-ver:4.0.1

MAINTAINER Branson Fox <bransonf@wustl.edu>

# system dependencies
# -
  
# install R libraries
RUN R -e "install.packages(c('shiny', 'EnvStats', 'REAT', 'glue'))"

# install non-CRAN libraries
# -

# copy app and data (need to modify data to update)
RUN mkdir /app
COPY app /app

EXPOSE 3920

CMD ["R", "-e", "shiny::runApp('/app', port = 3920, host = '0.0.0.0')"]