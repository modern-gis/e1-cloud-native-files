# Brick E1 – Cloud Object Storage

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/modern-gis/e1-cloud-native-files/tree/main)

**Part of Modern GIS Bricks**  
*Learn to upload local GIS files, convert them to cloud-native formats, and write them back to object storage.*

---

## 📖 Table of Contents

1. [Introduction](#introduction)  
2. [Setup](#setup)  
3. [Upload Local Files](#upload-local-files)  
4. [COG Best Practices & Conversion](#cog-best-practices--conversion)  
5. [GeoParquet Best Practices & Conversion](#geoparquet-best-practices--conversion)  
6. [Preview in MinIO](#preview-in-minio)  
7. [Basic Tests](#basic-tests)  
8. [Summary & Next Steps](#summary--next-steps)  

---

## Introduction

Cloud object storage (S3/MinIO) is essential for modern GIS workflows. In this lab you will:

- Upload GeoTIFF & Shapefile to MinIO  
- Convert GeoTIFF → Cloud-Optimized GeoTIFF (COG)  
- Convert Shapefile → GeoParquet  
- Write outputs back to MinIO  

---

## Setup

```python
import os
import fsspec
import rasterio
import geopandas as gpd

# MinIO credentials & endpoint
MINIO_ACCESS_KEY = "minioadmin"
MINIO_SECRET_KEY = "minioadmin"
MINIO_ENDPOINT   = "http://localhost:9000"

# Create S3 filesystem against MinIO
fs = fsspec.filesystem(
    "s3",
    key=MINIO_ACCESS_KEY,
    secret=MINIO_SECRET_KEY,
    client_kwargs={"endpoint_url": MINIO_ENDPOINT},
    use_ssl=False
)
