# Mechanical

## Board

| | |
|---|---|
| Outline | 50 × 100 mm, rounded corners |
| Layers | 2, 1.6 mm FR-4 |
| Copper | GND pour on both layers |
| Surface finish | HASL works; ENIG is nicer for soldering the castellated modules flat |
| Assembled thickness | About 19 mm, from the display front to the battery back |

## Placement

The front holds the display (top) and the buttons module (bottom). The back holds the processor board, the modules and the battery. The drawings show each part's outline as it is on the silkscreen and fabrication layers. The back is mirrored, as you see it when you turn the board over.

<div class="renders" markdown>
<figure markdown>
![Front placement drawing of main board v3.0.0](../images/placement-front.svg){ .drawing loading=lazy }
<figcaption>Front: U4 display, U5 buttons module</figcaption>
</figure>
<figure markdown>
![Back placement drawing of main board v3.0.0, mirrored](../images/placement-back.svg){ .drawing loading=lazy }
<figcaption>Back (mirrored): U1 RP2350-Plus, U2 audio, U6 utility, R2/R3, BT1 battery, U3 radio</figcaption>
</figure>
</div>

| Ref | Part | Side | Size (mm) | Where |
|---|---|---|---|---|
| U4 | Waveshare 1.5" OLED module | Front | 44.5 × 37 | Top of the board, on a 7-pin header and four standoffs |
| U5 | Buttons module | Front | 50 × 39 | Full width, below the display |
| U1 | RP2350-Plus | Back | 23 × 54 | Top right (seen from the back), USB-C at the top edge |
| U2 | Audio module | Back | 11.5 × 17.5 | Top left (seen from the back) |
| U6 | Utility module | Back | 16.4 × 14.8 | Between the audio module, the RP2350-Plus and the battery |
| R2, R3 | 470 Ω, 10 kΩ axial resistors | Back | | Between the audio module and the RP2350-Plus |
| BT1 | LiPo LP802540 | Back | 25 × 40 × 8 | Below the RP2350-Plus |
| U3 | Radio Module 2 | Back | 16.5 × 14.5 | Bottom edge, antenna over a copper keep-out |

## Display mounting holes

Four 2.0 mm plated holes hold the display module. They are measured from the top-left corner of the front.

| Hole | x (mm) | y (mm) |
|---|---|---|
| Top left | 5.25 | 5.25 |
| Top right | 44.75 | 5.25 |
| Bottom left | 5.25 | 37.25 |
| Bottom right | 44.75 | 37.25 |

The holes are 39.5 mm apart across and 32 mm apart down, the same as on the Waveshare module. Use screws and standoffs that fit the 2 mm holes to set the display height.

## Keep-outs

| Area | Why |
|---|---|
| Below the RM2 antenna, at the bottom edge | No copper on either layer. Keep metal, wires and fingers away in the shell too |
| Under each castellated module | No parts and no exposed vias, so the module sits flat |
| Under the buttons module | No parts: the board sits flat on the main board |

## 3D model

`vgc-zero.glb` in the repository is the assembled board with every module. Open it in any glTF viewer, for example [gltf-viewer.donmccurdy.com](https://gltf-viewer.donmccurdy.com/), or import it into a CAD tool to design a shell.

The `3d-models/` folder has STEP files for each part: the display, the RP2350-Plus, the RM2, the battery outline, and the audio, buttons and utility modules.

## Shell

There is no released shell for v3.0.0 yet. The shell design is work in progress.

!!! note "Work in progress"
    [vgc-zero-shell](https://github.com/chili-chip/vgc-zero-shell) has shell 0v1: 3MF files for a front and back housing and printed button caps. It was made in October 2026, before board v2.0.0, so check the fit before printing it for v3.0.0.
