# .gitpod.Dockerfile
# Use slim Python 3.11 base
FROM python:3.11-slim

# Install system deps for GDAL, build tools, wget/unzip
RUN apt-get update \
 && apt-get install -y \
      gdal-bin \
      libgdal-dev \
      build-essential \
      wget \
      unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install MinIO server + client
RUN wget https://dl.min.io/server/minio/release/linux-amd64/minio \
  && chmod +x minio && mv minio /usr/local/bin/ \
  && wget https://dl.min.io/client/mc/release/linux-amd64/mc \
  && chmod +x mc && mv mc /usr/local/bin/

# Install your Python CLI (uv) and any other PyPI deps
RUN pip install uv

# Create a data dir for MinIO
RUN mkdir -p /data

# Expose S3 & console ports
EXPOSE 9000 9001

# By default, start MinIO and drop into a shell
ENTRYPOINT ["sh","-lc"]
CMD     ["minio server /data --console-address \":9001\" & bash"]
