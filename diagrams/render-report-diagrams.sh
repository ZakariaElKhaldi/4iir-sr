#!/usr/bin/env bash
set -euo pipefail

diagram_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
rendered_dir="$diagram_dir/rendered"
staging_dir=$(mktemp -d "${TMPDIR:-/tmp}/iot-report-diagrams.XXXXXX")
trap 'rm -rf "$staging_dir"' EXIT
chmod a+rwx "$staging_dir"

mermaid_image=${MERMAID_IMAGE:-ghcr.io/mermaid-js/mermaid-cli/mermaid-cli:11.16.1}

mkdir -p "$rendered_dir"

docker run --rm \
  --volume "$diagram_dir:/data:ro" \
  "$mermaid_image" \
  --input /data/12-operator-activity.mmd \
  --output /tmp/12-operator-activity.pdf \
  --backgroundColor transparent \
  --pdfFit

docker run --rm \
  --volume "$diagram_dir:/data:ro" \
  --volume "$staging_dir:/output" \
  "$mermaid_image" \
  --input /data/12-operator-activity.mmd \
  --output /output/12-operator-activity.pdf \
  --backgroundColor transparent \
  --pdfFit

rsvg-convert \
  --format pdf \
  --output "$staging_dir/01-use-cases.pdf" \
  "$diagram_dir/uscase_diagrame.svg"

install -m 0644 "$staging_dir/01-use-cases.pdf" "$rendered_dir/01-use-cases.pdf"
install -m 0644 "$staging_dir/12-operator-activity.pdf" "$rendered_dir/12-operator-activity.pdf"

printf 'Rendered %s\n' "$rendered_dir/01-use-cases.pdf"
printf 'Rendered %s\n' "$rendered_dir/12-operator-activity.pdf"
