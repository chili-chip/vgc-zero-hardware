# Next revision plan

Plan for the next VGC Zero board, decided 2026-10-21. The board keeps the Waveshare RP2350-Plus as the MCU and gains plug-in audio and WiFi modules. Tickets live in this repo's issues, under the "ChiliChip console launch" milestone.

## Summary

| Block | Plan | Status | Ticket |
|-------|------|--------|--------|
| Display | Keep the Waveshare 1.5" RGB OLED (SSD1351, 128×128, SPI). It plugs onto a 2.54 mm pin header instead of the 7-pin JST cable. | Decided | #21 |
| Audio | Separate audio module board: copy an existing open module design, modify it, order it assembled. Plugs onto the main board. | Chip not chosen yet | #20, plus the audio chip decision and audio module tickets |
| WiFi / Bluetooth | Raspberry Pi Radio Module 2 (RM2, Infineon CYW43439, same radio as the Pico 2 W). | Decided | RM2 ticket |

The earlier idea of moving to a TFT IPS panel is dropped: the display stays the SSD1351 OLED.

## Display

- Same module as board v1.1.4: [Waveshare 1.5inch RGB OLED Module](https://www.waveshare.com/wiki/1.5inch_RGB_OLED_Module).
- Replace DISP1_CONN1 (JST PH, 7 pin) with a 2.54 mm header so the module plugs straight onto the board. Pin order must match the module (see #13).
- Signals stay on SPI0: CS, CLK, DIN, RST, DC, plus 3V3 and GND.

## Audio module

Approach:

1. Pick an existing open-source audio module design (schematic and layout available).
2. Copy it into this repo and modify it to fit the console: board outline, connector to the main board, speaker connection.
3. Order it assembled (PCBA) and plug it onto the main board.

The main board schematic already has an `AudioModule` symbol (pins VIN, GND, EN, GAIN, DI0, DI1, DI2), which suits an I2S amplifier with enable and gain pins. The final pinout depends on the chip.

**Open decision: the audio chip.** Candidates to compare:

| Chip | Type | Interface | Notes |
|------|------|-----------|-------|
| MAX98357A | Class D mono amp with built-in DAC, ~3 W | I2S (BCLK, LRCLK, DIN) + SD/enable + GAIN | Matches the `AudioModule` pins. Many open modules exist (e.g. Adafruit's). Digital input, so no PWM noise on the line. |
| NS4168 | Class D mono amp with built-in DAC | I2S | Cheaper MAX98357A-style part, common at JLCPCB/LCSC. Check datasheet and availability. |
| PAM8302A | Class D mono amp, 2.5 W | Analog in + shutdown | Open Adafruit breakout. Still needs PWM plus an RC filter from the RP2350, so the noise problem stays partly on our side. |
| HXJ8002 | Class AB mono amp | Analog in | Used on the breadboard prototype. Same PWM filtering need as PAM8302A. |

Things to decide with the chip: speaker size and connection, headphone jack or not, and firmware support (I2S through PIO on the RP2350 versus PWM).

## WiFi / Bluetooth: Raspberry Pi Radio Module 2

- [Raspberry Pi Radio Module 2](https://www.raspberrypi.com/documentation/microcontrollers/radio-modules.html) (RM2): Infineon CYW43439, 2.4 GHz WiFi and Bluetooth, 21-pad castellated module, 16.5 × 14.5 mm. Supported by the Pico SDK (`cyw43` driver, as on the Pico 2 W).
- Needs power, a reset/enable line and a gSPI link (data, clock, chip select): four RP2350 GPIOs.
- On the Pico 2 W these are GP23, GP24, GP25 and GP29, which are not on the RP2350-Plus header pins. The RM2 must use free header GPIOs, and the firmware board config (`chilichip_vgc` in the 32blit SDK fork) must set the CYW43 pins to match. To verify against the RM2 datasheet and the Pico SDK before layout.
- Follow the RM2 datasheet for the antenna keep-out area and place the module at the board edge, away from the display and the battery.

## GPIO budget

The RP2350-Plus header exposes 26 GPIOs (GP0–GP22, GP26–GP28).

| Use | GPIOs |
|-----|-------|
| Buttons | 10 |
| Display (SPI0 + CS, DC, RST) | 5 |
| Audio, I2S (BCLK, LRCLK, DIN) + enable | 3–4 |
| RM2 (WL_ON, data, clock, CS) | 4 |
| **Total** | **22–23** |

That leaves 3–4 GPIOs for the rest of the plan (RTC on I2C, debug/UART). The buzzer and LED pins are freed if those parts go.

## Still planned from before

- RTC
- LED removed or replaced
- Debug and UART sockets (#4, #5)
