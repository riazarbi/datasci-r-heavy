FROM riazarbi/datasci-r-8020:latest

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
    libcairo2-dev \
    libudunits2-dev \
    libgdal-dev \ 
    libgeos++-dev \
    libproj-dev \
    libx11-dev \
    libgl-dev \
    libglu-dev \
    libfreetype6-dev \
    libv8-3.14-dev \
    libjq-dev \
    libprotobuf-dev \
    protobuf-compiler \
    python-gdal \
    gdal-bin \
    aria2 \
    libpython-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* 

# RPACKAGES =================================================================

ARG r_packages="\
# inspect code performance
    profvis \ 
# hash tables
    hashmap \  
# interactive maps
    leaflet \
# geoprocessing
    fasterize \
    lidR \
    sen2r \
    geojsonlint \
# plotting extras
    ggExtra \ 
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
#    evaluate \
#    highr \
#    markdown \
#    htmltools \
#    rprojroot \
#    bookdown \
#    gridExtra \
#    markdown \
#    igraph \
#    RCurl \
#    jsonlite \
#    RJSONIO \
#    geojsonio \
#    repr \
#    crayon \ 
#    uuid \
#    digest \
#    caTools \
#    shinythemes \
#    shinyBS \
#    shinyLP \
#    keras \
#    xlsx \
#    network \
#    sna \
#    visNetwork \
#    threejs \
#    networkD3 \
#    ndtv \
#    factoextra \
#    arules \
#    DiagrammeRsvg \
#    arulesViz \
#    kohonen \
#    dummies \ 
#    tempR \
#    WDI \
#    smacof \ 
#    cluster \ 
#    ggmap \
#    googleway \ 
#    RJSONIO \
#    xesreadR \
#    petrinetR \
#    prophet \
#    timevis \ 
#    kableExtra \
#    evaluate \
#    crayon \
#    pbdZMQ \
#    esquisse \
#    shinydashboard \ 
#    rasterVis \
#    viridis \
#    caret \
#    drake \ 
#    RSQLite \
#    writexl \ 
#    odbc \
    "

# Install
RUN install2.r --error -n 2 -s --deps TRUE $r_packages 

# Configure sen2r
RUN mkdir /sen2cor_255 \
 && Rscript -e 'sen2r:::install_sen2cor("/sen2cor_255", version = "2.5.5")' \
 && chmod -R 0755 /sen2cor_255 

USER $NB_USER
