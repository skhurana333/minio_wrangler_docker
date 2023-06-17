#!/bin/bash
nohup ./minio server /hostdata/miniodata --console-address ":9001" &
exec "$@"
