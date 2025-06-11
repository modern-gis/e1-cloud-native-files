# .gitpod.Dockerfile

FROM python:3.11-slim

# 1. Install git (for Gitpod), wget (for fetching MinIO), and GDAL dependencies

RUN apt-get update&#x20;
&& apt-get install -y --no-install-recommends&#x20;
git&#x20;
wget&#x20;
ca-certificates&#x20;
gdal-bin&#x20;
libgdal-dev&#x20;
&& rm -rf /var/lib/apt/lists/\*

# 2. Download and install MinIO server

RUN wget [https://dl.min.io/server/minio/release/linux-amd64/minio](https://dl.min.io/server/minio/release/linux-amd64/minio)&#x20;
-O /usr/local/bin/minio&#x20;
&& chmod +x /usr/local/bin/minio

# 3. Install Python dependencies from requirements.txt

COPY requirements.txt /workspace/requirements.txt
RUN pip install --no-cache-dir -r /workspace/requirements.txt

# 4. Prepare MinIO data directory

RUN mkdir -p /data

# 5. Expose ports for Jupyter and MinIO

EXPOSE 8888 9000 9001

# 6. Start MinIO server and then drop into bash

ENTRYPOINT \["sh","-lc"]
CMD \["minio server /data --console-address " :9001" & jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]
