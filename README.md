# A4092 — A Modern Successor to the A4091

The A4092 is a modern re-implementation of Dave Haynie's classic A4091 Zorro
III SCSI controller for the Commodore Amiga. It retains a lot of the proven
architecture and the NCR/LSI 53C710 SCSI controller at its core, while
replacing obsolete and unobtainable components with modern equivalents that are
more readily available today.

![PCB](Docs/PCB.png?raw=True)

And also as a real PCB (REV A):

![Real PCB](Docs/PCB.jpg?raw=True)

## What's New

### CPLD Instead of GALs

The original A4091 used eight discrete GALs (ATF22V10 and similar) programmed
with WinCUPL to implement all bus interface, AutoConfig, address decoding,
arbitration, and SCSI control logic. The A4092 consolidates all of this
into a single Xilinx XC95144XL CPLD. This brings several advantages:

- Field-updatable logic — no need to pull and reprogram individual GAL chips
- No soldering and no sockets required for upgrading the liogic.
- More logic resources and routing flexibility than the original GAL array
- Eliminates dependence on increasingly scarce GAL parts
- The original WinCUPL equations have been rewritten from scratch in Verilog for the CPLD

### SPI Flash Instead of EPROM

The parallel EPROM used for the A4091's boot ROM has been replaced with SPI
Flash memory. Firmware updates no longer require a UV eraser and a dedicated
EPROM programmer — the flash can be reprogrammed in-system.

### Modern SMD Packages

Where the original A4091 used through-hole, PLCC and SOIC packages, the A4092 uses
TSSOP and other modern surface-mount packages (such as 0603 passives). This
reduces the board footprint, improves signal integrity and aligns with current
PCB assembly capabilities.

### Designed for Current Manufacturing

The A4092 is designed to be manufactured with services like JLCPCB or PCBway, using
(mostly) components that are in current production and readily sourced. No hunting for
NOS parts or pulling chips from donor boards.

### AutoConfig in the CPLD

The AutoConfig logic — previously spread across multiple GALs — is now
integrated into the CPLD alongside the rest of the glue logic, resulting in a
cleaner and more maintainable design. 

## What Stays the Same

The A4092 is not a redesign — it is a re-implementation. The core architecture is unchanged:

- NCR/LSI 53C710 SCSI controller
- Zorro III bus interface with the same timing and protocol behavior
- Full compatibility with existing A4091 device drivers and ROM images
- Active SCSI termination
- Internal and external SCSI connectors

## Revisions

- **Revision C** - This is the revision you should build.
- **Revision A** - needs [a number of reworks](https://docs.google.com/document/d/1CN8fwkUjfMrxxf_vMktpmiZ6GXSNA-jGrsVZTGIDl_o/edit?usp=sharing)

## Related Projects

- **A4091** — The original Commodore design by Dave Haynie (1992)

## License

[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

