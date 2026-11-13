# Specifications

These are the specifications of **main board v3.0.0** with the modules it is designed for. The schematic (`vgc-zero.kicad_sch`) is the source of truth. Where a number comes from a part's datasheet, the datasheet is linked.

## Summary

| | |
|---|---|
| Main board | v3.0.0, 50 × 100 mm, 2 layers, 1.6 mm FR-4 |
| Processor | Raspberry Pi RP2350A on a Waveshare RP2350-Plus |
| Screen | 1.5" RGB OLED, 128 × 128, SSD1351 |
| Controls | 10 buttons: D-pad, A, B, X, Y, Start, Select |
| Sound | MAX98357A I²S class D amplifier, one speaker |
| Sensors | LSM6DS3TR-C 6-axis IMU, RV-3028-C7 real-time clock |
| Haptics | DRV2605L driver, 4.3 mm SMD ERM motor |
| Wireless | Raspberry Pi Radio Module 2 (Infineon CYW43439) |
| Battery | 1-cell LiPo, LP802540, about 800 mAh |
| USB | USB-C on the RP2350-Plus: power, charging and data |
| Assembled thickness | About 19 mm, display front to battery back |

## Processor

The [brain module](../modules/brain.md) page has the details.

| | |
|---|---|
| Board | [Waveshare RP2350-Plus](https://www.waveshare.com/wiki/RP2350-Plus), 16 MB flash version |
| Chip | [RP2350A](https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf) (QFN-60) |
| Cores | 2 × Arm Cortex-M33 (or 2 × Hazard3 RISC-V), rated 150 MHz. The console SDK runs it at 250 MHz |
| RAM | 520 KB SRAM on chip |
| Flash | 16 MB QSPI on the RP2350-Plus. The firmware splits it into the OS, installed games and a USB drive |
| GPIO used | All 26 GPIOs on the RP2350-Plus header (GP0 to GP22, GP26 to GP28). See the [pin map](pin-map.md) |
| Debug | USB serial. UART0 pins are taken by the utility module's I²C bus |
| Boot | BOOT and RESET buttons on the RP2350-Plus (on the back of the console) |

## Screen

The [display module](../modules/display.md) page has the details.

| | |
|---|---|
| Module | [Waveshare 1.5inch RGB OLED Module](https://www.waveshare.com/wiki/1.5inch_RGB_OLED_Module) |
| Panel | 1.5" OLED, 128 × 128 pixels, no backlight |
| Controller | [SSD1351](https://www.waveshare.com/w/upload/a/a7/SSD1351-Revision_1.5.pdf) |
| Colour | 65k colours (RGB565) as the firmware drives it. The controller can do 262k |
| Interface | 4-wire SPI on SPI1 plus DC and RST. The firmware clocks it at 20 MHz |
| Frame time | About 13 ms for a full 128 × 128 frame at 20 MHz |
| Connection | 7-pin 2.54 mm header plus four 2 mm mounting holes |

## Controls

The [buttons module](../modules/buttons.md) page has the details.

| | |
|---|---|
| Buttons | Up, Down, Left, Right, A, B, X, Y, Start, Select |
| Type | Carbon pills on Game Boy Advance–style rubber domes, pressing on bare gold (ENIG) contacts |
| Electrical | Each button shorts its GPIO to GND. The RP2350's internal pull-ups are used |
| Not on this board | HOME and MENU buttons (they were on v1.1.4), power switch |

## Sound

The [audio module](../modules/audio.md) page has the details.

| | |
|---|---|
| Amplifier | [MAX98357A](https://www.analog.com/media/en/technical-documentation/data-sheets/MAX98357A-MAX98357B.pdf), filterless class D with a built-in DAC |
| Input | I²S from the RP2350's PIO (DIN, BCLK, LRCLK). No master clock needed |
| Sample rates | 8 kHz to 96 kHz (amplifier). See [firmware](firmware.md) for what the firmware uses |
| Gain | 12 dB, fixed |
| Output | Mono, bridge-tied. Mono mix (L + R) / 2 |
| Speaker | 4 to 8 Ω, on a Molex PicoBlade 1.25 mm 2-pin plug |
| Enable | AUDIO_MODE (GP6): high turns the amplifier on, low shuts it down |

## Sensors and haptics

The [utility module](../modules/utility.md) page has the details.

| | Part | I²C address | Notes |
|---|---|---|---|
| Motion | [ST LSM6DS3TR-C](https://www.st.com/resource/en/datasheet/lsm6ds3tr-c.pdf) | 0x6A | Accelerometer ±2/4/8/16 g, gyroscope ±125 to ±2000 °/s |
| Clock | [Micro Crystal RV-3028-C7](https://www.microcrystal.com/fileadmin/Media/Products/RTC/Datasheet/RV-3028-C7.pdf) | 0x52 | ±1 ppm, 45 nA, backed by the LiPo through VSYS |
| Haptics | [TI DRV2605L](https://www.ti.com/lit/ds/symlink/drv2605l.pdf) | 0x5A | 123 built-in effects, drives the ERM motor |
| Motor | Vybronics VZ43FC1B5640007L | | SMD ERM, 3 V, about 77 mA while it runs |

All three chips share I²C0 (GP0, GP1) and one open-drain interrupt line (GP2).

## Wireless

The [radio module](../modules/radio.md) page has the details.

| | |
|---|---|
| Module | [Raspberry Pi Radio Module 2](https://www.raspberrypi.com/products/radio-module-2/) (RM2) |
| Chip | Infineon CYW43439, the same radio as the Pico 2 W |
| Wi-Fi | 802.11b/g/n (Wi-Fi 4), 2.4 GHz, single band |
| Bluetooth | Bluetooth 5.2, Classic and Low Energy |
| Antenna | On the module, at the bottom edge of the board over a copper keep-out |
| Link | gSPI on 4 GPIOs (WIFI_ON, CS, CLK, DIO), driven from PIO by the `cyw43` driver |

## Power

The [power](power.md) page has the details.

| | |
|---|---|
| Battery | LP802540 LiPo, 3.7 V nominal, about 800 mAh, with protection board and PH1.25 plug |
| Charger | ETA6096 on the RP2350-Plus, 1 A from USB-C (about 1.25C for this cell) |
| Rails | VSYS (battery or USB, through a Schottky diode), 3.3 V from the RP2350-Plus regulator for everything else |
| Battery sense | GP29 reads VSYS through a 200k/100k divider on the RP2350-Plus |
| Power switch | None on v3.0.0 |

## Physical

The [mechanical](mechanical.md) page has the details.

| | |
|---|---|
| Main board | 50 × 100 mm, 2 layers, 1.6 mm, GND pour on both layers |
| Thickness | About 19 mm assembled |
| Mounting | Four 2 mm holes for the display; the module outlines are on the silkscreen |
| Shell | Not released yet. An early 3D-printed shell for older boards is in [vgc-zero-shell](https://github.com/chili-chip/vgc-zero-shell) |

## Not included

These are things people often expect. They are not on v3.0.0.

| Missing | Why it matters | Where it is tracked |
|---|---|---|
| Power switch | The console cannot be turned off fully. The firmware must put it to sleep | [Power](power.md#turning-the-console-off) |
| HOME and MENU buttons | The firmware's system menu used HOME. It needs a new button mapping | [Firmware](firmware.md#buttons) |
| Status LED on the front | The RP2350-Plus LED is on the back, under the shell | |
| Headphone jack | Speaker only | |
| SD card | Games live in the 16 MB flash | |
| Debug and UART sockets | Use USB serial | [#4](https://github.com/chili-chip/vgc-zero-hardware/issues/4), [#5](https://github.com/chili-chip/vgc-zero-hardware/issues/5) |
