# Brain: Waveshare RP2350-Plus

The brain of the console is a [Waveshare RP2350-Plus](https://www.waveshare.com/wiki/RP2350-Plus): an RP2350A board with the same pinout as a Raspberry Pi Pico 2, plus a LiPo charger and a battery header. It is soldered flat on the back of the main board by its castellated edge.

## Specifications

| | |
|---|---|
| Chip | [Raspberry Pi RP2350A](https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf), QFN-60, 30 GPIOs |
| Cores | 2 × Arm Cortex-M33 with FPU, or 2 × Hazard3 RISC-V. Rated 150 MHz; the console SDK runs it at 250 MHz |
| RAM | 520 KB SRAM |
| Flash | 16 MB QSPI (a 4 MB version exists; the console needs 16 MB) |
| PIO | 3 PIO blocks, 12 state machines. The console uses PIO for I²S sound and the radio |
| USB | USB-C, USB 1.1 device or host |
| Charger | ETA6096 LiPo charger, 1 A (R13 = 160 kΩ) |
| Battery | PH1.25 2-pin header |
| Regulator | 3.3 V for the board and the console |
| Buttons | BOOT and RESET |
| LED | On GP25 |
| Pinout | Raspberry Pi Pico compatible, 40 castellated pads |
| Size | About 23 × 54 mm with the USB-C connector |

## How it is mounted

The main board's `RP2350-Plus` footprint has:

- the Pico hand-solder lands, without the SWD pads,
- clearance holes for the USB-C shell legs,
- clearance holes for the pegs under the module.

The USB-C connector points at the top edge of the console. The BOOT and RESET buttons are on the side facing out, so they can be reached through the shell.

## Pins used

Every GPIO on the header is used. See the [pin map](../console/pin-map.md).

| RP2350-Plus pin | Used for |
|---|---|
| GP0 to GP22, GP26 to GP28 | Modules and buttons |
| 3V3 (36) | 3.3 V rail for all modules |
| VSYS (39) | Utility module RTC backup |
| GND | Ground pour |
| VBUS, RUN, 3V3_EN, ADC_VREF | Not connected |

## Why the RP2350-Plus

| Reason | Detail |
|---|---|
| Charger on board | The Pico 2 has no charger. The RP2350-Plus has one, plus the battery header |
| 16 MB flash | Room for the OS, many games and a USB drive. The Pico 2 has 4 MB |
| Pico pinout | Same pinout as a Pico 2, so firmware and footprints carry over |
| Hand soldering | The RP2350 is a 0.4 mm QFN. On a module, nobody has to solder it by hand |

Main board v2.0.0 used a Raspberry Pi Pico 2 and had no battery. See [revisions](../revisions.md).

## Links

| | |
|---|---|
| Product wiki | [waveshare.com/wiki/RP2350-Plus](https://www.waveshare.com/wiki/RP2350-Plus) |
| RP2350 datasheet | [rp2350-datasheet.pdf](https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf) |
| Hardware design with RP2350 | [hardware-design-with-rp2350.pdf](https://datasheets.raspberrypi.com/rp2350/hardware-design-with-rp2350.pdf) |
| 3D model | `3d-models/RP2350-Plus.stpZ` (Waveshare's model, gzipped) |
