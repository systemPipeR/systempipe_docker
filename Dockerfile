# Docker inheritance
FROM bioconductor/bioconductor_docker:devel

# Update Bioconductor packages from devel version
RUN Rscript --vanilla -e "options(repos = c(CRAN = 'https://cran.r-project.org')); BiocManager::install(ask=FALSE)"

# Install required Bioconductor packages from devel version
RUN Rscript -e 'BiocManager::install("systemPipeR/systemPipeTools")'
RUN Rscript -e 'BiocManager::install("tgirke/systemPipeR")'

WORKDIR /home/rstudio/SPRojects

COPY --chown=rstudio:rstudio . /home/rstudio/SPRojects

# Metadata
LABEL name="systempipe/systempipe_docker" \
      version="systempipe_docker:latest" \
      url="https://github.com/systemPipeR/systempipe_docker" \
      vendor="systemPipe Project" \
      maintainer="danicassol@gmail.com" \
      description="systemPipe Project docker image" \
      license="Artistic-2.0"
 
