FROM frolvlad/alpine-miniconda3 as backend

FROM jenkins/jenkins:alpine

WORKDIR /backend
COPY --from=backend "/opt/conda" .
COPY --from=backend "/etc/profile.d/conda.sh" .
