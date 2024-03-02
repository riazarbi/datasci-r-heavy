FROM riazarbi/datasci-r-8020:20230520210047

LABEL authors="Riaz Arbi,Gordon Inggs" \
      release="20210406"

USER root

COPY apt.txt .

RUN echo "Checking for 'apt.txt'..." \
        ; if test -f "apt.txt" ; then \
        apt-get update --fix-missing > /dev/null\
        && xargs -a apt.txt apt-get install --yes \
        && apt-get clean > /dev/null \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /tmp/* \
        ; fi

 # Install chromium browser 
RUN apt-get --fix-broken install 
RUN apt-get install -y gdebi-core libappindicator3-1 libgbm1 libgtk-3-0 libxcursor1  libu2f-udev \
 && wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
 && dpkg -i google-chrome-stable_current_amd64.deb \
 && rm -rf google-chrome-stable_current_amd64.deb \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* 


# Install R dependencies
COPY install.R .
RUN if [ -f install.R ]; then R --quiet -f install.R; fi


RUN /usr/local/bin/fix-permissions $HOME 

USER $NB_USER
