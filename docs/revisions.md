# Revisions and roadmap

Every main board revision is a tag and a GitHub release in [vgc-zero-hardware](https://github.com/chili-chip/vgc-zero-hardware/releases). The releases carry the schematic PDF, a PCB image and the Gerbers.

## Main board history

| Version | Released | Board | Processor | Big changes |
|---|---|---|---|---|
| Breadboard | 2025 | Breadboard | Pico board | First prototype with a 1.44" ST7735S TFT. See the [breadboard guide](https://chilichip.eu/docs/vgc-zero/vgc-breadboard/) |
| v0.0.1 to v1.0.2 | 11 Dec 2025 | First PCBs | Raspberry Pi Pico 2 | First KiCad board: TP4056 charger module, LiPo, speaker, through-hole buttons, power switch |
| v1.1.0 to v1.1.4 | 2 to 7 Mar 2026 | 50 × 90 mm | Waveshare RP2350-Plus | Through-hole buttons, buzzer, LED, power switch, display on a JST cable. Fabricated and playable |
| [v2.0.0](https://github.com/chili-chip/vgc-zero-hardware/releases/tag/v2.0.0) | 5 Nov 2026 | 50 × 90 mm | Raspberry Pi Pico 2 | Castellated modules: buttons, audio, radio. Display on a pin header. USB power only |
| [v3.0.0](https://github.com/chili-chip/vgc-zero-hardware/releases/tag/v3.0.0) | 6 Nov 2026 | 50 × 100 mm | Waveshare RP2350-Plus | Flush LiPo, utility module (IMU, RTC, haptics), all 26 GPIOs used |

### v1.1.4

The board that the console firmware targets today.

![Main board v1.1.4, 3D render without parts](images/revisions/v1.1.4-iso.png){ loading=lazy width="560" }

| | |
|---|---|
| Processor | Waveshare RP2350-Plus |
| Buttons | 10 through-hole tactile switches (D-pad, A, B, X, Y, MENU, HOME) |
| Sound | Buzzer driven by PWM on GP22 |
| Display | Waveshare 1.5" OLED on a 7-pin JST cable |
| Power | LiPo on the RP2350-Plus, hard power switch |
| Extras | Status LED |

Known issues on v1.1.4 led to [#10](https://github.com/chili-chip/vgc-zero-hardware/issues/10) to [#13](https://github.com/chili-chip/vgc-zero-hardware/issues/13) (bigger holes, single pin header, longer resistor, display connector pin order) and to the sound and display changes in [#20](https://github.com/chili-chip/vgc-zero-hardware/issues/20) and [#21](https://github.com/chili-chip/vgc-zero-hardware/issues/21).

### v2.0.0

The first board built from modules.

![Main board v2.0.0, 3D render](images/revisions/v2.0.0-iso.png){ loading=lazy width="560" }

| | |
|---|---|
| Processor | Raspberry Pi Pico 2, soldered flat |
| Buttons | Buttons module v1.2, castellated |
| Sound | Audio module (MAX98357A) |
| Radio | Raspberry Pi Radio Module 2 |
| Power | USB only, no battery |

The plan it implemented is in [`docs/next-revision.md`](https://github.com/chili-chip/vgc-zero-hardware/blob/master/docs/next-revision.md).

### v3.0.0

The current board. Everything on this site describes it.

| Change from v2.0.0 | Why |
|---|---|
| Pico 2 → RP2350-Plus | LiPo charger and 16 MB flash on the module |
| 50 × 90 → 50 × 100 mm | Room for the battery flat on the back |
| LP802540 LiPo, flush on the back | Battery power without a thicker console |
| Utility module added | Tilt, real-time clock and rumble on three GPIOs |

## Firmware support per board

| Board | Console firmware |
|---|---|
| v1.1.4 | Supported (`chilichip_vgc`) |
| v2.0.0 | Not supported, no battery; superseded by v3.0.0 |
| v3.0.0 | Needs new board files. See [firmware and software](console/firmware.md#pin-map-differences) |

## Work in progress

!!! note "Not released"
    The designs below are not released. They can change at any time. Do not order them for a console yet.

| Design | Repository | Status |
|---|---|---|
| Single fully assembled board: RP2350 on the main board, all modules merged, bare SSD1351 panel | [chilichip-console-hardware](https://github.com/chili-chip/chilichip-console-hardware) | Planning. Starts from Raspberry Pi's RP2350A minimal design. Deferred until after launch ([32blit-sdk #63](https://github.com/chili-chip/32blit-sdk/issues/63)). Display plan in [#16](https://github.com/chili-chip/chilichip-console-hardware/issues/16) |
| Custom silicone keypad | [vgc-zero-hardware #33](https://github.com/chili-chip/vgc-zero-hardware/issues/33) | Prototyping with GBA pads |
| Shell | [vgc-zero-shell](https://github.com/chili-chip/vgc-zero-shell) | Shell 0v1 (3MF), made for the older boards |
| Main board with the chilichip display module (OLED or TFT), 50 × 83.9 mm | This repository, `master` | Placed and routed, ERC and DRC clean. See [below](#next-main-board-display-module-and-smaller-outline). Not fabricated yet ([#41](https://github.com/chili-chip/vgc-zero-hardware/issues/41)) |

### Next main board: display module and smaller outline

The next main board drops the Waveshare OLED and its 7-pin header. It takes a chilichip [display module](modules/display.md) instead: OLED or TFT, same outline and pads, so either one fits ([#41](https://github.com/chili-chip/vgc-zero-hardware/issues/41)). With the big display module gone, the board is rearranged and shrinks from 50 × 100 mm to **50 × 83.9 mm**.

<div class="renders" markdown>
<figure markdown>
![Next main board, front, 3D render](images/next/iso.png){ .render loading=lazy }
<figcaption>Front: display module and buttons module (work in progress)</figcaption>
</figure>
<figure markdown>
![Next main board, back, 3D render](images/next/iso-bottom.png){ .render loading=lazy }
<figcaption>Back: radio top right, audio and utility down the right, battery along the bottom</figcaption>
</figure>
</div>

<div class="renders" markdown>
<figure markdown>
![Next main board, front placement drawing](images/next/placement-front.svg){ .drawing loading=lazy }
<figcaption>Front</figcaption>
</figure>
<figure markdown>
![Next main board, back placement drawing, mirrored](images/next/placement-back.svg){ .drawing loading=lazy }
<figcaption>Back (mirrored)</figcaption>
</figure>
</div>

#### What changes

| | v3.0.0 | Next board |
|---|---|---|
| Outline | 50 × 100 mm | 50 × 83.9 mm. The width is set by the 50 mm buttons module; the height by the RP2350-Plus plus the battery on the back |
| Display | Waveshare 1.5" OLED module, 44.5 × 37 mm, on a 7-pin header | chilichip display module, 28 × 22 mm (OLED or TFT), 8 SMD pads at 2.54 mm. It lies flat on top and is hand soldered by its castellations. No hole in the board |
| Display holes | Four 2 mm holes for the display standoffs | None. The panel is glued or screwed to the frame |
| Radio (U3) | Bottom edge, antenna down | Top right corner of the back, antenna to the right edge. The copper keep-out is the strip along the right edge, from the top down to 25.9 mm |
| Audio module (U2) | Top left of the back | Below the radio, turned 180° so J3 faces up. The 6 mm gap above J3 leaves room for the speaker plug |
| Utility module (U6) | Between audio, RP2350-Plus and battery | Below the audio module |
| Battery (BT1) | Middle of the back | Along the bottom edge |
| R2, R3 | 0.25 W axial, through hole | 1206 SMD with hand-solder pads, right of the audio module. Through-hole leads would poke into the buttons module, which now sits over the back parts |
| Branding | Bottom of the front | Front, right of the display module, rotated |
| Height above the board, front | Header plus module, about 11 mm | Display module 3.6 mm (1.6 mm board plus the 2.0 mm FPC connector) |
| Firmware pins | | No change. Same GPIOs for every part |

#### Where the parts sit

Measured from the board's top-left corner as seen from the front, so the back parts are not mirrored. Each box is the part's courtyard.

| Ref | Part | Side | x (mm) | y (mm) |
|---|---|---|---|---|
| U4 | Display module | Front | 5.5 to 33.5 (pads 3.9 to 35.1) | 8.6 to 30.6 |
| U5 | Buttons module | Front | 0 to 50 | 40.9 to 83.7 |
| U1 | RP2350-Plus | Back | 7.7 to 30.9 | 0 to 52.8 (USB-C at the top edge) |
| U3 | Radio Module 2 | Back | 32.7 to 50 | 0 to 15.9, keep-out 45 to 50 by 0 to 25.9 |
| U2 | Audio module | Back | 31.0 to 44.6 | 22.0 to 41.7 |
| R3, R2 | 1206 resistors | Back | 45.0 to 47.3 | 26.0 to 31.0, 31.4 to 36.4 |
| U6 | Utility module | Back | 31.0 to 49.6 | 41.9 to 57.3 |
| BT1 | LiPo LP802540 | Back | 1.5 to 42.1 | 57.9 to 83.5 |

Under the display module: no parts and no bare copper. Tracks and tented vias are fine, because the module's bottom is a covered GND pour. The module's 3D model is `3d-models/chili-display-module-hardware.step` (the OLED module).

The board is routed with Freerouting on both layers and has a GND pour on both sides. ERC and DRC (with schematic parity) are clean. It is not fabricated yet.

To fit the display module: tin one corner pad on the main board, hold the module in place, solder that pad, check it lies flat and square, then solder the other seven.

## Earlier and side projects

These designs are not part of the current console. They are listed so nobody has to guess what they are.

| Design | Repository | What it is |
|---|---|---|
| VGC-0 on RP2350 and ESP8684 | [vgc-pico-hw](https://github.com/chili-chip/vgc-pico-hw) | September 2025 KiCad design: RP2350 chip on the board, ESP8684 for Wi-Fi and extra GPIO, 6 buttons, 2 system buttons and an encoder wheel. Not continued |
| Luckfox Pico variant | [vgc-zero-luckfox-pico](https://github.com/chili-chip/vgc-zero-luckfox-pico) | Linux SDK fork for an older Luckfox Pico based idea. Inactive since 2025 |

## Open hardware issues

The board's open issues are in [vgc-zero-hardware issues](https://github.com/chili-chip/vgc-zero-hardware/issues).

| Issue | Topic |
|---|---|
| [#32](https://github.com/chili-chip/vgc-zero-hardware/issues/32) | Console modules: tracking issue |
| [#31](https://github.com/chili-chip/vgc-zero-hardware/issues/31), [#33](https://github.com/chili-chip/vgc-zero-hardware/issues/33) | Buttons module and rubber dome feel |
| [#20](https://github.com/chili-chip/vgc-zero-hardware/issues/20), [#23](https://github.com/chili-chip/vgc-zero-hardware/issues/23), [#24](https://github.com/chili-chip/vgc-zero-hardware/issues/24) | Audio |
| [#21](https://github.com/chili-chip/vgc-zero-hardware/issues/21) | Display on a pin header |
| [#25](https://github.com/chili-chip/vgc-zero-hardware/issues/25) | Wi-Fi and Bluetooth |
| [#19](https://github.com/chili-chip/vgc-zero-hardware/issues/19) | Gyroscope and vibrator |
| [#4](https://github.com/chili-chip/vgc-zero-hardware/issues/4), [#5](https://github.com/chili-chip/vgc-zero-hardware/issues/5) | Debug and UART sockets |
| [#1](https://github.com/chili-chip/vgc-zero-hardware/issues/1) | Enter boot mode with the buttons |
