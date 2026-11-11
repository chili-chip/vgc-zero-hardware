# Pin map

Every GPIO on the RP2350-Plus header is used on main board v3.0.0. The pins were picked so that each trace runs as short and straight as possible to its module.

**Pin** is the RP2350-Plus header pin (the same numbering as a Raspberry Pi Pico). The net names are the ones in the schematic.

## By GPIO

| GPIO | Pin | Net | Goes to | Function | Notes |
|---|---|---|---|---|---|
| GP0 | 1 | `UTIL_SDA` | Utility J1.2 | I2C0 SDA | 4.7 kΩ pull-up on the module |
| GP1 | 2 | `UTIL_SCL` | Utility J1.3 | I2C0 SCL | 4.7 kΩ pull-up on the module |
| GP2 | 4 | `UTIL_INT` | Utility J1.4 | Interrupt in | Open drain, shared by IMU and RTC, 10 kΩ pull-up on the module |
| GP3 | 5 | `AUDIO_DIN` | Audio J1.1 | I²S data | PIO |
| GP4 | 6 | `AUDIO_BCLK` | Audio J1.2 | I²S bit clock | PIO side-set base |
| GP5 | 7 | `AUDIO_LRCLK` | Audio J1.3 | I²S word select | Must be BCLK + 1 |
| GP6 | 9 | `AUDIO_MODE` | Audio J1.4 | Amplifier enable | High = on (mono mix), low = shutdown |
| GP7 | 10 | `BTN_A` | Buttons J4.2 | Button A | Pull-up, low when pressed |
| GP8 | 11 | `BTN_B` | Buttons J4.1 | Button B | Pull-up, low when pressed |
| GP9 | 12 | `WIFI_ON` | RM2 WL_ON, BT_ON | Radio power on | |
| GP10 | 14 | `BTN_Y` | Buttons J2.3 | Button Y | Pull-up, low when pressed |
| GP11 | 15 | `BTN_X` | Buttons J2.2 | Button X | Pull-up, low when pressed |
| GP12 | 16 | `BTN_SELECT` | Buttons J2.1 | Button Select | Pull-up, low when pressed |
| GP13 | 17 | `WIFI_CS` | RM2 CS | gSPI chip select | |
| GP14 | 19 | `WIFI_CLK` | RM2 SCLK | gSPI clock | |
| GP15 | 20 | `WIFI_DIO` | RM2 DI, DO, nIRQ | gSPI data and IRQ | DO via R2 470 Ω, nIRQ via R3 10 kΩ |
| GP16 | 21 | `BTN_DOWN` | Buttons J3.2 | D-pad down | Pull-up, low when pressed |
| GP17 | 22 | `BTN_RIGHT` | Buttons J3.3 | D-pad right | Pull-up, low when pressed |
| GP18 | 24 | `BTN_START` | Buttons J1.3 | Button Start | Pull-up, low when pressed |
| GP19 | 25 | `BTN_UP` | Buttons J1.2 | D-pad up | Pull-up, low when pressed |
| GP20 | 26 | `BTN_LEFT` | Buttons J1.1 | D-pad left | Pull-up, low when pressed |
| GP21 | 27 | `DISP_RST` | Display RST | Display reset | |
| GP22 | 29 | `DISP_DC` | Display DC | Data / command | |
| GP26 | 31 | `DISP_CLK` | Display CLK | SPI1 SCK | |
| GP27 | 32 | `DISP_DIN` | Display DIN | SPI1 TX | |
| GP28 | 34 | `DISP_CS` | Display CS | Display chip select | |

GPIOs inside the RP2350-Plus, not on the header:

| GPIO | Use on the RP2350-Plus |
|---|---|
| GP25 | On-board LED |
| GP29 | VSYS sense through a 200k/100k divider (ADC3) |

## Power pins

| Pin | Name | Used for |
|---|---|---|
| 36 | 3V3 | 3.3 V rail for every module |
| 39 | VSYS | RTC backup on the utility module (J1.6) |
| 40 | VBUS | Not used |
| 30 | RUN | Not connected |
| 37 | 3V3_EN | Not connected |
| 35 | ADC_VREF | Not connected |
| 3, 8, 13, 18, 23, 28, 33, 38 | GND | Ground pour |

## By module

| Module | GPIOs | Count |
|---|---|---|
| Buttons | GP7, GP8, GP10, GP11, GP12, GP16, GP17, GP18, GP19, GP20 | 10 |
| Display | GP21, GP22, GP26, GP27, GP28 | 5 |
| Audio | GP3, GP4, GP5, GP6 | 4 |
| Radio | GP9, GP13, GP14, GP15 | 4 |
| Utility | GP0, GP1, GP2 | 3 |
| **Total** | | **26 of 26** |

!!! warning "No free GPIOs"
    All 26 header GPIOs are taken. Anything new must go on the utility module's I²C bus, or free a pin first.

!!! note "UART0 is taken"
    GP0 and GP1 are the RP2350's default UART0 pins. The utility module uses them for I²C, so use USB serial for debug output.

## Firmware board file

The pin map above has to match the `chilichip_vgc` board files in the console SDK. Today those files still describe board v1.1.4. The [firmware page](firmware.md#pin-map-differences) lists the differences.
