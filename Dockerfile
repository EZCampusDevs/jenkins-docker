FROM jenkins/jenkins:latest


USER root

ARG CONDA_DIR="/opt/conda"

ENV PATH="$CONDA_DIR/bin:$PATH"

RUN mkdir /tmp/miniconda
WORKDIR /tmp/miniconda
RUN curl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -L -o miniconda.sh && \
    bash miniconda.sh -f -b -p $CONDA_DIR && \
    echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh

RUN $CONDA_DIR/bin/conda update --all --yes && \
    $CONDA_DIR/bin/conda config --set auto_update_conda False && \
    $CONDA_DIR/bin/conda clean --all --force-pkgs-dirs --yes && \
    find "$CONDA_DIR" -follow -type f \( -iname '*.a' -o -iname '*.pyc' -o -iname '*.js.map' \) -delete && \
    mkdir -p "$CONDA_DIR/locks" && \
    chmod 777 "$CONDA_DIR/locks"

WORKDIR /
RUN rm -rf /tmp/miniconda

USER jenkins
