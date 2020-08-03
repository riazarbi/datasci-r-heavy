FROM riazarbi/datasci-r-8020:focal

LABEL authors="Riaz Arbi,Gordon Inggs"

USER root

# BASE BACKAGES =============================================================
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    cmake \
    make \
    gcc \
    cargo \
    libsodium-dev \
    libcairo2-dev \
    libudunits2-dev \
    libgdal-dev \ 
    libgeos++-dev \
    libproj-dev \
    libx11-dev \
    libgl-dev \
    libglu-dev \
    libfreetype6-dev \
    libnode-dev \
    libjq-dev \
    libprotobuf-dev \
    protobuf-compiler \
    #python-gdal \
    gdal-bin \
    aria2 \
    libpython2-dev \
    libavfilter-dev \
    libgsl-dev \
    libfftw3-dev \
    libxml2-dev \
 # Install chromium browser 
 && apt-get --fix-broken install \
 && apt-get install -y gdebi-core libappindicator3-1 libgbm1 libgtk-3-0 libxcursor1 \
 && wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
 && dpkg -i google-chrome-stable_current_amd64.deb \
 && rm -rf google-chrome-stable_current_amd64.deb \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* 

# RPACKAGES =================================================================

ARG r_packages="\
# inspect code performance
    profvis \ 
# interactivity
    leaflet \
    leaflet.extras \
    leafpop \
    leaftime \
    rhandsontable \
    highcharter \
    av \
    gganimate \
# geoprocessing
    fasterize \
    #lidR \
    #sen2r \
    geojsonlint \
    spatstat \
# graphics extras
    ggExtra \
    sparkline \
    processx \
    webshot \
# process mining
    bupaR \
    edeaR \ 
    eventdataR \  
    processmapR \
    processmonitR \ 
# parallel processing
    doParallel \
# presentation
    flexdashboard \
    bookdown \
    gt \
# training 
    nycflights13 \
    gapminder \
    Lahman \
# h2o dependencies 
    h2o \
# automation
    blastula \
    tidyRSS \
# munging 
    janitor \
    googlesheets4 \
    xlsx \
    "

# Install 
RUN install2.r --error -s --deps TRUE $r_packages 

RUN Rscript -e 'devtools::install_github("homerhanumat/bpexploder")'
RUN Rscript -e 'remotes::install_github("rstudio/webshot2", dependencies = TRUE)'

USER $NB_USER
