# Docker inheritance
FROM bioconductor/bioconductor_docker:devel

RUN apt-get update && \
    apt-get install -y hisat2 bowtie bowtie2 bwa samtools vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/rstudio/SPRojects/

COPY --chown=rstudio:rstudio . /home/rstudio/SPRojects/

RUN apt-get update &&\ 
    cd tools &&\
    unzip Trimmomatic-0.39.zip -d /opt/ &&\
#    rm -rf Trimmomatic-0.39.zip &&\
    chmod +x /opt/Trimmomatic-0.39/trimmomatic-0.39.jar &&\
    echo "#!/bin/bash" >> /opt/Trimmomatic-0.39/trimmomatic &&\
    echo "exec java -jar /opt/Trimmomatic-0.39/trimmomatic-0.39.jar """"$""@"""" " >> /opt/Trimmomatic-0.39/trimmomatic &&\
    chmod +x /opt/Trimmomatic-0.39/trimmomatic

ENV PATH="${PATH}:/opt/Trimmomatic-0.39/"

# Update Bioconductor packages from devel version
RUN Rscript --vanilla -e "options(repos = c(CRAN = 'https://cran.r-project.org')); BiocManager::install(ask=FALSE)"

# Install required Bioconductor packages from devel version
RUN Rscript -e 'BiocManager::install("systemPipeR/systemPipeTools")'
RUN Rscript -e 'BiocManager::install("systemPipeR/systemPipeShiny")'
RUN Rscript -e 'BiocManager::install("tgirke/systemPipeR")'

# Metadata
LABEL name="systempipe/systempipe_docker" \
      version="systempipe_docker:latest" \
      url="https://github.com/systemPipeR/systempipe_docker" \
      vendor="systemPipe Project" \
      maintainer="danicassol@gmail.com" \
      description="systemPipe Project docker image" \
      license="Artistic-2.0"
 
