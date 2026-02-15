TEX = A4092-manual.tex
PDF = A4092-manual.pdf
SCRIBUS := $(shell if [ -x /Applications/Scribus.app/Contents/MacOS/Scribus ]; then echo /Applications/Scribus.app/Contents/MacOS/Scribus; else echo /usr/bin/scribus; fi)
SVG2CMYK = ../scripts/svg2cmyk.py
# Find all PNG and SVG files
FIGURE_PNGS = $(wildcard figures/*.png)
FIGURE_SVGS = $(wildcard figures/*.svg)
FIGURE_PDFS = $(FIGURE_SVGS:.svg=.pdf)

# Crane SVG
CRANE_PDF = cranes.pdf

all: $(PDF)

# Convert figure SVGs to CMYK PDF via Scribus
figures/%.pdf: figures/%.svg
	QT_QPA_PLATFORM=offscreen INPUT=$< OUTPUT=$@ $(SCRIBUS) -g -py $(SVG2CMYK)

# Cranes: SVG to CMYK PDF via Scribus
cranes.pdf: cranes.svg
	QT_QPA_PLATFORM=offscreen INPUT=$< OUTPUT=$@ $(SCRIBUS) -g -py $(SVG2CMYK)

$(PDF): $(TEX) $(FIGURE_PDFS) $(FIGURE_PNGS) $(CRANE_PDF)
	pdflatex $(TEX)
	pdflatex $(TEX)

clean:
	rm -f *.aux *.log *.toc *.out $(PDF)
	rm -f figures/*.pdf cranes.pdf

.PHONY: all clean
