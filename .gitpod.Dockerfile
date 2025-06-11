FROM python:3.11-slim

# ─── Install git & GDAL deps ─────────────────────────────────────────────────
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      git \             # ← ensure git is here for Gitpod
      gdal-bin \
      libgdal-dev \
 && rm -rf /var/lib/apt/lists/*

# ─── MinIO server ─────────────────────────────────────────────────────────────
RUN wget https://dl.min.io/server/minio/release/linux-amd64/minio \
     -O /usr/local/bin/minio \
 && chmod +x /usr/local/bin/minio

# ─── Python packages ───────────────────────────────────────────────────────────
RUN pip install --no-cache-dir \
      fsspec \
      s3fs \
      rasterio \
      geopandas \
      rio-cogeo \
      pyarrow \
      python-geohash

# ─── MinIO data volume & ports ────────────────────────────────────────────────
RUN mkdir -p /data
EXPOSE 9000 9001

# ─── Launch MinIO then give you a shell ───────────────────────────────────────
ENTRYPOINT ["sh","-lc"]
CMD     ["minio server /data --console-address \":9001\" & bash"]
