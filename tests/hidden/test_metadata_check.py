import os
import io
import json
import pytest
import pyarrow.parquet as pq

# directory where the student notebook writes its outputs
OUT_DIR = "tests/outputs"

@pytest.fixture(scope="module")
def cog_meta():
    meta_path = os.path.join(OUT_DIR, "esa_world_cover_cog_meta.json")
    assert os.path.exists(meta_path), "Missing COG metadata JSON"
    with open(meta_path, "r") as f:
        return json.load(f)

def test_cog_metadata_structure(cog_meta):
    # must contain exactly these keys
    assert set(cog_meta) == {"bounds", "tile_size", "compression", "overviews"}
    # bounds format
    b = cog_meta["bounds"]
    assert isinstance(b, list) and len(b) == 4
    # tile size positive
    ts = cog_meta["tile_size"]
    assert ts["x"] > 0 and ts["y"] > 0
    # valid compression
    assert cog_meta["compression"] in {"DEFLATE", "ZSTD", "LZW", "JPEG"}
    # overviews list of ints
    ovs = cog_meta["overviews"]
    assert isinstance(ovs, list) and all(isinstance(o, int) for o in ovs)

def test_single_geoparquet_exists_and_reads():
    pq_file = os.path.join(OUT_DIR, "parks.parquet")
    assert os.path.exists(pq_file), "Missing single GeoParquet"
    buf = io.BytesIO(open(pq_file, "rb").read())
    pf  = pq.ParquetFile(buf)
    # must have at least one row group
    assert pf.num_row_groups > 0
    # footer metadata must include GeoParquet info
    meta = pf.metadata.metadata or {}
    assert b"geo" in meta, "GeoParquet footer missing geo metadata"

EXPECTED_CODE = 'dcd6539f-4a00-4ed2-95c6-66ae639e0323'

def test_enrollment_code_matches():
    code = open("enrollment_code.txt", "r").read().strip()
    assert code == EXPECTED_CODE, (
        f"Invalid enrollment code '{code}'. "
        "Please check you copied it exactly from your course email."
    )