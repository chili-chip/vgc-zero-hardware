#!/usr/bin/env bash
# Export the JLCPCB fabrication zip (gerbers + drill) and a hand-assembly BOM.
# The Pico, RM2 and the chilichip modules are soldered by hand, so there is no
# JLCPCB assembly BOM/CPL.
# Usage: scripts/export-jlcpcb.sh [VERSION] [OUTPUT_DIR]
set -euo pipefail

NAME=vgc-zero
PREFIX=chilichip-console
VERSION=${1:-$(git describe --tags --always --dirty 2>/dev/null || echo dev)}
OUT=${2:-production}
PCB=$NAME.kicad_pcb
SCH=$NAME.kicad_sch

cd "$(dirname "$0")/.."
rm -rf "$OUT"
mkdir -p "$OUT/gerbers"

# Gerbers (Protel extensions) + Excellon drill in mm.
kicad-cli pcb export gerbers --subtract-soldermask \
  --layers F.Cu,B.Cu,F.Paste,B.Paste,F.SilkS,B.SilkS,F.Mask,B.Mask,Edge.Cuts \
  -o "$OUT/gerbers/" "$PCB"
kicad-cli pcb export drill --format excellon --excellon-units mm \
  --generate-map --map-format gerberx2 -o "$OUT/gerbers/" "$PCB"
(cd "$OUT/gerbers" && zip -q "../$PREFIX-$VERSION-gerbers.zip" ./*)
rm -rf "$OUT/gerbers"

# Hand-assembly BOM, grouped by value and footprint.
kicad-cli sch export bom \
  --fields 'Reference,Value,${FOOTPRINT_NAME},${QUANTITY}' \
  --labels 'Designator,Value,Footprint,Qty' \
  --group-by 'Value,${FOOTPRINT_NAME}' \
  --exclude-dnp -o "$OUT/$PREFIX-$VERSION-bom.csv" "$SCH"

ls -1 "$OUT"
