SCRIBUS := $(shell if [ -x /Applications/Scribus.app/Contents/MacOS/Scribus ]; then echo /Applications/Scribus.app/Contents/MacOS/Scribus; else echo /usr/bin/scribus; fi)
SVG2CMYK = ../scripts/svg2cmyk.py

SVGS = $(wildcard *.svg)
PDFS = $(SVGS:.svg=.pdf)

all: $(PDFS)

# SVG to CMYK PDF via Scribus
%.pdf: %.svg
	QT_QPA_PLATFORM=offscreen INPUT=$< OUTPUT=$@ $(SCRIBUS) -g -py $(SVG2CMYK)

clean:
	rm -f $(PDFS)

.PHONY: all clean
