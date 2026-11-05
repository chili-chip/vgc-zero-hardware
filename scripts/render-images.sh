#!/usr/bin/env bash
# Regenerate the README board renders in docs/images/ and the vgc-zero.glb 3D export.
set -euo pipefail

cd "$(dirname "$0")/.."
PCB=vgc-zero.kicad_pcb
OUT=docs/images
mkdir -p "$OUT"

kicad-cli pcb render --side top --zoom 0.95 -w 800 -h 1300 -o "$OUT/top.png" "$PCB"
kicad-cli pcb render --side bottom --zoom 0.95 -w 800 -h 1300 -o "$OUT/bottom.png" "$PCB"
kicad-cli pcb render --quality high --side top --rotate "-40,0,25" --zoom 0.85 \
  -w 1300 -h 1100 -o "$OUT/iso.png" "$PCB"
kicad-cli pcb render --quality high --side bottom --rotate "-40,0,-25" --zoom 0.85 \
  -w 1300 -h 1100 -o "$OUT/iso-bottom.png" "$PCB"
kicad-cli pcb export glb --force --subst-models -o vgc-zero.glb "$PCB"
