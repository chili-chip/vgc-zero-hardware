# VGC Zero hardware

KiCad 9 project for the **VGC Zero** prototype board, the PCB of [chilichip](https://chilichip.eu)'s open hardware keychain game console. Firmware and games are built with the [chili-chip 32blit SDK](https://github.com/chili-chip/32blit-sdk) (board `chilichip_vgc`).

Current board revision: **v1.1.4** (2-layer). The schematic (`vgc-zero.kicad_sch`) is the source of truth for everything below.

## Parts (board v1.1.4)

| Ref | Part | Footprint / notes |
|-----|------|-------------------|
| MCU1 | Raspberry Pi Pico 2 (RP2350) module | `Module:RaspberryPi_Pico_Common_THT`, through-hole |
| DISP1 | [Waveshare 1.5inch RGB OLED Module](https://www.waveshare.com/wiki/1.5inch_RGB_OLED_Module), SSD1351 driver, 128×128, 16-bit colour, SPI | `vgc-zero-footprints:SSD1351_OLED_128x128_WAVESHARE` (mounting holes only) |
| DISP1_CONN1 | 7-pin JST PH connector for the display cable | `JST_PH_S7B-PH-K_1x07_P2.00mm_Horizontal` |
| SW1–SW10 | 10× tactile push buttons, 6 mm | `SW_PUSH_6mm_H5mm` |
| SW11 | SPDT slide switch (power) | C&K OS102011MA1Q, angled |
| Buzz1 | Buzzer | 12 × 9.5 mm, 7.6 mm pitch |
| D1 + R1 | LED (1210) with 330 Ω resistor | |
| J1–J3 | 3× 1×6 2.54 mm right-angle pin headers (Pico GPIO, 3V3, GND) | |
| H5, H6 | M2 mounting holes | |

Not on this board: battery or charger (the `Tp4056_Charger` footprint in the library is unused), audio amplifier or headphone jack, rotary encoder, shoulder buttons, PSRAM. The board is powered from the Pico's USB port.

## Pin map

| Pico pin | GPIO | Signal |
|----------|------|--------|
| 4–7, 9–12, 14–15 | GP2–GP11 | Buttons SW1–SW10 (to GND) |
| 21 | GP16 | LED (via R1) |
| 22 | GP17 | Display CS |
| 24 | GP18 | Display CLK (SPI0 SCK) |
| 25 | GP19 | Display DIN (SPI0 TX) |
| 26 | GP20 | Display RST |
| 27 | GP21 | Display DC |
| 29 | GP22 | Buzzer |
| 37 | 3V3_EN | Power switch SW11 |

Display connector pinout (DISP1_CONN1): 1 VCC (3V3), 2 GND, 3 DIN, 4 CLK, 5 CS, 6 DC, 7 RST.

## Earlier breadboard prototype

The first VGC Zero prototype was built on a breadboard, not on this PCB: Raspberry Pi Pico 2 W, a 1.44" 128×128 ST7735S SPI TFT, an HXJ8002 amplifier with a small speaker, a rotary encoder and tactile buttons. See the [breadboard guide](https://chilichip.eu/docs/vgc-zero/vgc-breadboard/).

## Planned for the next revision

- Display changes from the SSD1351 OLED to a TFT IPS panel, on a 2.54 mm pin header instead of the JST connector
- Audio noise filtering
- RTC
- LED removed or replaced

## Build outputs

CI (`.github/workflows/main.yml`) runs ERC and DRC on every push and pull request. Tagged releases (`v*`) attach the schematic PDF and gerbers.

## License

MIT, see [LICENSE](LICENSE).
