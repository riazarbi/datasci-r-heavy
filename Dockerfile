FROM riazarbi/datasci-r-8020:20241020203701

LABEL authors="Riaz Arbi,Gordon Inggs" \
      release="20210406"

USER root

COPY apt.txt .

RUN echo "Checking for 'apt.txt'..." \
        ; if test -f "apt.txt" ; then \
        apt update --fix-missing > /dev/null\
        && xargs -a apt.txt apt install --yes \
        && apt-get clean > /dev/null \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /tmp/* \
        ; fi

# Install R dependencies
COPY install.R .
RUN if [ -f install.R ]; then R --quiet -f install.R; fi


RUN /usr/local/bin/fix-permissions $HOME 

USER $NB_USER
