OPENSCAD = $(if $(wildcard /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD),/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD,openscad-nightly)

all: a4000d_hpdb50.stl

a4000d_hpdb50.stl: a4000d_hpdb50.scad
	$(OPENSCAD) -o $@ $<

clean:
	rm -f a4000d_hpdb50.stl

.PHONY: all clean
