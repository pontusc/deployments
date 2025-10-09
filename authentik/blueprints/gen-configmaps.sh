#!/bin/bash

SOURCE_DIR="${1:-.}"
TARGET_DIR="${2:-.}"
NAMESPACE="${3:-authentik}"

for file in "$SOURCE_DIR"/*.y*ml; do
  [ -f "$file" ] || continue 

  filename=$(basename "$file")
  name="${filename%.*}"
  
  # --from-file expects a "KEY=PATH" structure, where KEY is the name of the configmaps data key,
  # and the PATH is the file to read contents from
  kubectl create configmap "$name" \
    --from-file="$name.yaml=$file" \
    --namespace="$NAMESPACE" \
    --dry-run=client -o yaml > "$TARGET_DIR/cm-$filename"
done
