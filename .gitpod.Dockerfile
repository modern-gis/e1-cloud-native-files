# 1. Base
FROM python:3.11-slim

# 2. System deps for GDAL/PROJ, Git, build tools
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      libgdal-dev gdal-bin \
      libproj-dev proj-data proj-bin \
      build-essential \
      git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# 3. Ensure GDAL headers are found for rasterio/fiona builds
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal \
    C_INCLUDE_PATH=/usr/include/gdal

# 4. Workdir
WORKDIR /workspace

# 5. Python deps
COPY requirements.txt /workspace/requirements.txt
RUN pip install --no-cache-dir -r /workspace/requirements.txt

# 6. Expose Jupyter port
EXPOSE 8888

# 7. Default command
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
