# A4092 manual

This is the manual for the A4092 SCSI-2 host controller.

## Requirements

Building the manual requires:

- A LaTeX distribution with `pdflatex` and `tlmgr` (e.g. [MacTeX](https://www.tug.org/mactex/) on macOS)
- [Scribus](https://www.scribus.net/) for SVG-to-CMYK-PDF conversion
- Python 3 for the `svg2cmyk.py` helper script

### LaTeX packages (macOS)

```
sudo tlmgr update --self
sudo tlmgr install titlesec pagecolor helvetic svg framed transparent enumitem
```

## How to build

```
make
```

Output: `A4092-manual.pdf`

To remove all generated files:

```
make clean
```
