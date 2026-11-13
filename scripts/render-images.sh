#!/usr/bin/env bash
# Regenerate the board renders, placement drawings and schematic in docs/,
# and the vgc-zero.glb 3D export.
set -euo pipefail

cd "$(dirname "$0")/.."
PCB=vgc-zero.kicad_pcb
SCH=vgc-zero.kicad_sch
OUT=docs/images
mkdir -p "$OUT" docs/schematics

kicad-cli pcb render --side top --zoom 0.95 -w 800 -h 1500 -o "$OUT/top.png" "$PCB"
kicad-cli pcb render --side bottom --zoom 0.95 -w 800 -h 1500 -o "$OUT/bottom.png" "$PCB"
kicad-cli pcb render --quality high --side top --rotate "-40,0,25" --zoom 0.85 \
  -w 1300 -h 1100 -o "$OUT/iso.png" "$PCB"
kicad-cli pcb render --quality high --side bottom --rotate "-40,0,-25" --zoom 0.85 \
  -w 1300 -h 1100 -o "$OUT/iso-bottom.png" "$PCB"
kicad-cli pcb export glb --force --subst-models -o vgc-zero.glb "$PCB"

# Placement drawings: outlines and silkscreen only, back side mirrored
kicad-cli pcb export svg --mode-single --fit-page-to-board --exclude-drawing-sheet \
  --black-and-white -l Edge.Cuts,F.Fab,F.SilkS,F.CrtYd,User.Drawings \
  -o "$OUT/placement-front.svg" "$PCB"
kicad-cli pcb export svg --mode-single --fit-page-to-board --exclude-drawing-sheet \
  --black-and-white --mirror -l Edge.Cuts,B.Fab,B.SilkS,B.CrtYd,User.Drawings \
  -o "$OUT/placement-back.svg" "$PCB"

# Schematic for the docs site
TMP=$(mktemp -d)
kicad-cli sch export svg -o "$TMP" "$SCH"
mv "$TMP/vgc-zero.svg" docs/schematics/main-board.svg
rm -rf "$TMP"
