# Parts list

Everything you need for one console built on main board v3.0.0. Each release of this repository also has a hand-assembly BOM attached as `chilichip-console-<version>-bom.csv`.

Prices change too often to list here. The links point to where the team bought the parts.

## Main board

| Ref | Qty | Part | Notes | Where to get it |
|---|---|---|---|---|
| PCB | 1 | Main board v3.0.0 | 2 layers, 1.6 mm, 50 × 100 mm | [JLCPCB](https://jlcpcb.com/), gerbers on the [release](https://github.com/chili-chip/vgc-zero-hardware/releases/tag/v3.0.0) |
| U1 | 1 | Waveshare RP2350-Plus, **16 MB** | Soldered flat by its castellations. The console firmware expects 16 MB of flash | [Waveshare](https://www.waveshare.com/wiki/RP2350-Plus) |
| U4 | 1 | Waveshare 1.5inch RGB OLED Module | SSD1351, 128 × 128, with its 7-pin header | [Waveshare](https://www.waveshare.com/wiki/1.5inch_RGB_OLED_Module) |
| U3 | 1 | Raspberry Pi Radio Module 2 | Castellated, soldered flat | [Raspberry Pi resellers](https://www.raspberrypi.com/products/radio-module-2/), for example The Pi Hut |
| U2 | 1 | chili-audio-module v1.1.1 | Assembled by JLCPCB | [Audio module](../modules/audio.md#ordering) |
| U5 | 1 | chili-buttons-module v1.2.0 | Bare ENIG PCB, no parts | [Buttons module](../modules/buttons.md#ordering) |
| U6 | 1 | chili-utility-module v2.0.0 | Assembled by JLCPCB | [Utility module](../modules/utility.md#ordering) |
| R2 | 1 | 470 Ω resistor, axial, 0.25 W | RM2 DO to the shared data line | Any electronics shop |
| R3 | 1 | 10 kΩ resistor, axial, 0.25 W | RM2 nIRQ to the shared data line | Any electronics shop |
| BT1 | 1 | LiPo LP802540, ~800 mAh, with protection and PH1.25 plug | 8.0 × 25 × 40 mm | Sold as "802540" cells, for example by Heltec resellers |

## Extras

| Qty | Part | Notes |
|---|---|---|
| 1 | Speaker, 4 to 8 Ω, with a Molex PicoBlade 1.25 mm 2-pin plug | Plugs into J3 on the audio module |
| 1 set | Game Boy Advance silicone button pads | D-pad, A/B and Start/Select pads. See [buttons](../modules/buttons.md#rubber-pads) |
| 1 set | GBA button caps and D-pad | For the shell |
| 4 | Screws and standoffs for the display | Fit the 2 mm holes |
| 1 | Double-sided foam tape | Holds the battery |
| 1 | USB-C cable | Power, charging and data |

## What JLCPCB assembles

| Board | PCB options | Assembly | Parts on it |
|---|---|---|---|
| Main board | 2 layers, 1.6 mm, HASL or ENIG | None | None: hand-soldered |
| Audio module | 2 layers, 1.6 mm, castellated holes, ENIG recommended | Top side | 5 parts, all LCSC |
| Utility module | 2 layers, 1.6 mm, castellated holes | Top side | 15 parts; the motor M1 is not on LCSC (global sourcing or consigned) |
| Buttons module | 2 layers, 1.6 mm, castellated holes, **ENIG required** | None | None |

## Module BOMs

Each module page has its full bill of materials with LCSC part numbers:

- [Audio module BOM](../modules/audio.md#bill-of-materials)
- [Utility module BOM](../modules/utility.md#bill-of-materials)
- [Buttons module](../modules/buttons.md) has no parts.
