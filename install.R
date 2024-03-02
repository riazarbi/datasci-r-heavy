list.of.packages <- c(
# inspect code performance
    "profvis",
# interactivity
    "leaflet",
    "leaflet.extras",
    "leafpop",
    "leaftime",
    "rhandsontable",
    "highcharter",
    "av",
    "gganimate",
# geoprocessing
    "fasterize",
    "geojsonlint",
    "spatstat",
    "stars",
    "lwgeom",
# graphics extras
    "ggExtra",
    "sparkline",
    "processx",
    "webshot",
# process mining
    "bupaR",
    "edeaR",
    "eventdataR",
    "processmapR",
    "processmonitR",
    "processanimateR",
# parallel processing
    "doParallel",
# presentation
    "flexdashboard",
    "bookdown",
    "gt",
# training 
    "nycflights13",
    "gapminder",
    "Lahman",
# h2o dependencies 
    "h2o",
# automation
    "blastula",
    "tidyRSS",
# munging 
    "janitor",
    "googlesheets4",
    "xlsx",
    "snakecase",
    "widyr",
# actual stats \
    "caTools",
# database \
    "RPostgres",
# text mining \
   "textdata",
   "tidytext",
# timeseries \
   "timetk")
 
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

# use posit binary linux packages
options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])))
options(repos="https://packagemanager.rstudio.com/all/__linux__/focal/latest", Ncpus=3)
source("https://docs.posit.co/rspm/admin/check-user-agent.R")
Sys.setenv("NOT_CRAN" = TRUE)

# Install packages
if(length(new.packages)) install.packages(new.packages)

# Custom packages
devtools::install_github("homerhanumat/bpexploder")
remotes::install_github("rstudio/webshot2", dependencies = TRUE)
