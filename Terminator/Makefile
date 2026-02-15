OPENSCAD = $(if $(wildcard /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD),/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD,openscad-nightly)
SRC = A4092_terminator.scad
DEPS = $(SRC) ../YAPP_Box/YAPPgenerator_v3.scad

# DEVICES   = A4091 A4092
DEVICES   = A4092
PARTS     = base lid
PROCESSES = fdm resin
STYLES    = round chamfered

# Device -> label text
label_A4091 = A4091 Terminator
label_A4092 = A4092 Terminator

# Part -> shell booleans
shell_base_base = true
shell_base_lid  = false
shell_lid_base  = false
shell_lid_lid   = true

# Process -> label depth
depth_fdm  = 0.1
depth_resin = -0.4

# Style -> box type
boxtype_round     = 0
boxtype_chamfered = 5

# Generate all target names
TARGETS = $(foreach d,$(DEVICES),\
            $(foreach p,$(PARTS),\
              $(foreach pr,$(PROCESSES),\
                $(foreach s,$(STYLES),\
                  $(d)_terminator_$(p)_$(pr)_$(s).stl))))

all: $(TARGETS)

# Rule-generating template: $(1)=device $(2)=part $(3)=process $(4)=style
define RULE
$(1)_terminator_$(2)_$(3)_$(4).stl: $$(DEPS)
	$$(OPENSCAD) -o $$@ \
		-D 'printBaseShell=$$(shell_$(2)_base)' \
		-D 'printLidShell=$$(shell_$(2)_lid)' \
		-D 'labelDepthVal=$$(depth_$(3))' \
		-D 'boxType=$$(boxtype_$(4))' \
		-D 'labelText="$$(label_$(1))"' \
		$$(SRC)
endef

$(foreach d,$(DEVICES),\
  $(foreach p,$(PARTS),\
    $(foreach pr,$(PROCESSES),\
      $(foreach s,$(STYLES),\
        $(eval $(call RULE,$(d),$(p),$(pr),$(s)))))))

clean:
	rm -f $(TARGETS)

.PHONY: all clean
