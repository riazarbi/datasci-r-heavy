FROM riazarbi/datasci-r-8020:20230420211228

LABEL authors="Riaz Arbi,Gordon Inggs" \
      release="20210406"

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
    processanimateR \
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
    snakecase \
    widyr \
# actual stats \
    caTools \
# database \
    RPostgres \
# text mining \
   textdata \
   tidytext \
# timeseries \
   timetk \
    "

# Install 
RUN install2.r --skipinstalled --error  --ncpus 3 --deps TRUE -l $R_LIBS_SITE  $r_packages 

RUN install2.r --skipinstalled --error  --ncpus 3 --deps FALSE -l $R_LIBS_SITE  lwgeom stars
RUN Rscript -e 'devtools::install_github("homerhanumat/bpexploder")'
RUN Rscript -e 'remotes::install_github("rstudio/webshot2", dependencies = TRUE)'
RUN /usr/local/bin/fix-permissions $HOME 

USER $NB_USER
