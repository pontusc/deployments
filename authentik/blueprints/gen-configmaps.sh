#!/bin/bash

SOURCE_DIR="${1:-.}"
TARGET_DIR="${2:-.}"
NAMESPACE="${3:-authentik}"

for file in "$SOURCE_DIR"/*.y*ml; do
  [ -f "$file" ] || continue 

  filename=$(basename "$file")
  name="${filename%.*}"

  kubectl create configmap "$name" \
    --from-file="$file" \
    --namespace="$NAMESPACE" \
    --dry-run=client -o yaml > "$TARGET_DIR/cm-$filename"
done
