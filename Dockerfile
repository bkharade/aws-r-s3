FROM rocker/r-ver:4.3

RUN apt-get update && apt-get install -y git-core libssl-dev libcurl4-gnutls-dev curl libsodium-dev libz-dev libxml2-dev

RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /mnt
RUN chmod ugo+w -R /mnt

RUN Rscript -e "install.packages('pak' , repos = sprintf('https://r-lib.github.io/p/pak/stable'))"

RUN Rscript -e "pak::pkg_install('rstudio/plumber@main')"

RUN Rscript -e "pak::pkg_install(c('logger','tictoc','fs', 'promises','future','fastmap'))"

RUN Rscript -e "pak::pkg_install(c('psych','haven','flextable', 'dplyr'))"

RUN Rscript -e "pak::pkg_install(c('fastmatch', 'Hmisc','lubridate','officedown'))"

RUN Rscript -e "pak::pkg_install(c('openxlsx','stringdist','tidyr','paws','officer','janitor'))"

COPY . /app

WORKDIR /app

VOLUME [ "/mnt" ]

EXPOSE 8080

ENTRYPOINT [ "Rscript" ]

CMD ["app.R"]