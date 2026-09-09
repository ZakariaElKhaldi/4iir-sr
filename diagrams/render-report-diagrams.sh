#!/usr/bin/env bash
set -euo pipefail

diagram_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
rendered_dir="$diagram_dir/rendered"
staging_dir=$(mktemp -d "${TMPDIR:-/tmp}/iot-report-diagrams.XXXXXX")
trap 'rm -rf "$staging_dir"' EXIT
chmod a+rwx "$staging_dir"

mermaid_image=${MERMAID_IMAGE:-ghcr.io/mermaid-js/mermaid-cli/mermaid-cli:11.16.1}
plantuml_image=${PLANTUML_IMAGE:-plantuml/plantuml:1.2025.2}

mkdir -p "$rendered_dir"

docker run --rm \
  --volume "$diagram_dir:/data:ro" \
  --volume "$staging_dir:/output" \
  "$plantuml_image" -tsvg -o /output /data/01-use-cases.puml

rsvg-convert \
  --format pdf \
  --output "$staging_dir/01-use-cases.pdf" \
  "$staging_dir/01-use-cases.svg"

install -m 0644 "$staging_dir/01-use-cases.svg" "$rendered_dir/01-use-cases.svg"
install -m 0644 "$staging_dir/01-use-cases.pdf" "$rendered_dir/01-use-cases.pdf"
diagrams=(
  02-ingestion-sequence
  03-domain-classes
  03b-ingestion-classes
  03c-model-health-classes
  03d-service-operations
  04-ingestion-states
  07-synchronous-prediction-sequence
  09-alert-investigation-sequence
  11-model-health-sequence
  12-operator-activity
  13-alert-communication
  14-component-architecture
  15-docker-deployment
)

for diagram in "${diagrams[@]}"; do
  docker run --rm \
    --volume "$diagram_dir:/data:ro" \
    --volume "$staging_dir:/output" \
    "$mermaid_image" \
    --configFile /data/report-mermaid-config.json \
    --input "/data/$diagram.mmd" \
    --output "/output/$diagram.pdf" \
    --backgroundColor white \
    --pdfFit
  install -m 0644 "$staging_dir/$diagram.pdf" "$rendered_dir/$diagram.pdf"
done

printf 'Rendered %s\n' "$rendered_dir/01-use-cases.pdf"
for diagram in "${diagrams[@]}"; do
  printf 'Rendered %s\n' "$rendered_dir/$diagram.pdf"
done
