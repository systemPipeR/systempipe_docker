# Docker inheritance
FROM bioconductor/bioconductor_docker:devel

## Install BiocStyle
RUN R -e 'BiocManager::install("BiocStyle")'

# Install required Bioconductor package from devel version
RUN R -e 'BiocManager::install("tgirke/systemPipeR")'
RUN R -e 'BiocManager::install("tgirke/systemPipeRdata")'

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
 
