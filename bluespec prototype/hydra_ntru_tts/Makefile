STYLE = sim

BSC = bsc
BSCFLAGS = -aggressive-conditions -cpp -u -keep-fires -simdir bscdir -bdir bscdir -info-dir bscdir -vdir bscdir -no-warn-action-shadowing -O -opt-undetermined-vals +RTS -K51200k -RTS
BSCGEN = -$(STYLE) # -verilog or -sim
BSCLIB = -p .:%/Prelude:%/Libraries: #../common -i ../common:.

LDFLAGS = -o ./sim -simdir bscdir -keep-fires
LDLIB = -p .:bscdir:%/Prelude:%/Libraries: #../common

TAR = Tb

ifeq ($(STYLE), verilog)
isVerilog = true
else
isVerilog = false
endif


.PHONY: all clean

all: clear compile link

clear:
	clear

link:
	$(BSC) $(BSCGEN) -e mk$(TAR) $(LDFLAGS) $(LDLIB)
	if ($(isVerilog)); then mkdir -p verilog; cp bscdir/mk*.v verilog/; fi

compile:
	mkdir -p bscdir
	$(BSC) $(BSCGEN) $(BSCFLAGS) $(BSCLIB) -g mk$(TAR) $(TAR).bsv


clean:
	rm -f bscdir/*
	rm -f sim sim.*
	rm -f verilog/mk*.v


