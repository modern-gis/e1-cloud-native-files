
# Brick E1 – Cloud Object Storage

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/modern-gis/e1-cloud-native-files)

Welcome to **Brick E1** of the Modern GIS Bricks series! In this lab you’ll learn how to move geospatial data into—and transform it inside—cloud object storage, using S3-compatible APIs (e.g. AWS S3 or MinIO), `rasterio`/`rio-cogeo` for Cloud-Optimized GeoTIFFs, and `geopandas`/Arrow for GeoParquet.

---

## 🔑 Enrollment Code (paid students only)

After you purchase the course, you’ll receive a **one-time enrollment code** by email. To unlock the auto-grader and earn your badge:

1. Fork this repo and clone locally (or open it in Gitpod via the badge above).
2. At the **project root**, create a file named  
   ```text
   enrollment_code.txt
3. Paste **exactly** your one-time code into that file (no extra whitespace).
4. Run through the notebook, commit your changes, and open a PR.

The CI will run both the lab tests and verify your enrollment code before issuing your badge.

---

## 📖 Lab Objectives

1. **Connect** to an S3-compatible store via `obstore` (or `s3fs`/`fsspec`).
2. **Upload** local GeoTIFF & GeoPackage files into cloud storage.
3. **Convert** GeoTIFF → COG with `rio_cogeo`.
4. **Convert** GeoPackage → GeoParquet with `geopandas` & Arrow.
5. **Partition** your GeoParquet via a quadtree or kd-tree strategy.
6. **Verify** outputs locally & in CI-friendly metadata form.

---

## 🚀 Quickstart

### 1. In Gitpod

Click **“Open in Gitpod”** at the top of this README and wait for the workspace to spin up.
MinIO will be started for you on ports **9000 (API)** and **9001 (Console)**, and Jupyter Lab on **8888**.

### 2. Locally

```bash
git clone https://github.com/modern-gis/e1-cloud-native-files.git
cd e1-cloud-native-files

# create a Python 3.11 venv
python3.11 -m venv .venv
source .venv/bin/activate

# install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# start Jupyter Lab
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser
```

> If you want to run MinIO locally instead of S3, follow the Dockerfile & Gitpod setup steps in `.gitpod.yml` and `.gitpod.Dockerfile`.

---

## 🧱 Notebook Structure

1. **00-Introduction**
   Overview of cloud object storage and lab goals.
2. **01-Setup**

   * Import Python packages
   * Configure & authenticate to S3/MinIO via `obstore`
3. **02-Upload Local Files**

   * Upload a sample GeoTIFF & GeoPackage into `s3://…/e1-input/`
4. **03-COG Conversion**

   * Read GeoTIFF bytes from cloud
   * Create a Cloud-Optimized GeoTIFF in memory
   * Upload back to `s3://…/e1-output/`
5. **04-GeoParquet Conversion**

   * Read GeoPackage bytes from cloud
   * Encode geometries, sort & write a single GeoParquet file
   * Upload to `s3://…/e1-output/parks.parquet`
6. **05-Partitioning**

   * Build a quadtree on a sample of your data
   * Tag each feature with its partition, sort, then write one file per cell
   * Upload to `s3://…/e1-output/parks_quadtree/…`
7. **06-Verification**

   * Download outputs to `tests/outputs/`
   * Inspect COG metadata & GeoParquet row counts
   * (CI writes minimal JSON metadata for badge checks)

All code cells marked **`# TODO:`** are where you’ll fill in or experiment.

---

## 📂 Repo Layout

```
├── .gitpod.Dockerfile        ← custom image (GDAL, build tools, MinIO cli)
├── .gitpod.yml               ← Gitpod tasks & ports
├── Dockerfile                ← (optional) local Docker build
├── environment.yml           ← (optional) conda spec
├── requirements.txt          ← pip dependencies
├── notebooks/                ← Jupyter notebooks for the lab
│   └── e1-cloud-object-storage.ipynb
├── tests/                    ← public smoke tests (outputs saved locally)
│   └── outputs/              ← test‐downloaded COG & Parquet
├── hidden_tests/             ← **not published**; contains enrollment & grading
│   ├── test_enrollment.py
│   └── …
├── enrollment_code.txt       ← **YOU** must create this with your code
└── README.md                 ← you are here
```

---

## ✅ Submission & Badge

1. Make sure all **public** tests in `tests/` pass locally:

   ```bash
   pytest -q
   ```
2. Commit your notebook edits **and** your `enrollment_code.txt`.
3. Push to your fork and open a pull request.
4. The GitHub Actions CI will run:

   * Public lab tests
   * Hidden enrollment test
   * If everything passes, it issues your Open Badge via Badgr.

Good luck, and enjoy this hands-on dive into cloud-native GIS!
