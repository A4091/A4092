# A4092 Active SCSI Terminator Case

A 3D-printable snap-fit enclosure for the A4092 (and A4091) Active SCSI Terminator PCB, designed in [OpenSCAD](https://openscad.org/) using the [YAPP Box](https://github.com/mrWheel/YAPP_Box) generator v3.

## Features

- Two-piece snap-fit design (base + lid), no screws required
- Cutout for the IDC50 SCSI connector
- Label embossed/debossed on the lid
- PCB standoffs with alignment pins

## Variants

STL files are provided for several combinations:

| Option | Choices |
|--------|---------|
| Device | A4091, A4092 |
| Process | FDM (debossed label), Resin/SLA (embossed label) |
| Edge style | Round, Chamfered |

Pre-built STL files follow the naming convention:

```
<device>_terminator_<part>_<process>_<style>.stl
```

For example: `A4092_terminator_lid_fdm_chamfered.stl`

## Building from Source

### Prerequisites

- [OpenSCAD](https://openscad.org/) (the Makefile expects the macOS .app bundle by default)
- [YAPP Box generator v3](https://github.com/mrWheel/YAPP_Box) checked out at `../YAPP_Box/`

### Generating STL Files

```bash
make          # Build all variants
make clean    # Remove generated STL files
```

The Makefile generates all combinations of part, process, and style automatically. To change which devices are built, edit the `DEVICES` variable in the Makefile.

## Printing Tips

- **FDM**: Labels are debossed (engraved into the surface). Use the `fdm` STL variants.
- **Resin/SLA**: Labels are embossed (raised from the surface). Use the `resin` STL variants.
- No supports should be needed for either the base or lid when printed in their default orientation.

## Design Parameters

Key dimensions (defined in `A4092_terminator.scad`):

| Parameter | Value |
|-----------|-------|
| PCB size | 69.6 x 24 mm |
| Wall thickness | 2.0 mm |
| Base/lid plane thickness | 2.0 mm |
| Ridge height | 4.0 mm |

