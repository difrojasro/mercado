XILINXCADROOT   = /opt/cad/Xilinx/10.1/ISE

SIM_SRC=                                  \
	wb_BCD_tb.v     

SRC=                                      \
	../BCD.v	      	\
	../decoder_segments.v		\
	../selector_anodes.v			\
	../wb_BCD.v
#############################################################################
# Synthesis constants
SYNCLEAN=wb_BCD.bgn wb_BCD.drc wb_BCD.mrp wb_BCD.ngd wb_BCD.pcf 
SYNCLEAN+=wb_BCD.bld wb_BCD.lso wb_BCD.ncd wb_BCD.ngm wb_BCD.srp
SYNCLEAN+=wb_BCD.bit wb_BCD_signalbrowser.* wb_BCD-routed_pad.tx
SYNCLEAN+=wb_BCD.map wb_BCD_summary.xml timing.twr
SYNCLEAN+=wb_BCD-routed* wb_BCD_usage* wb_BCD.ngc param.opt netlist.lst
SYNCLEAN+=xst wb_BCD.prj *ngr *xrpt  _xmsgs  xlnx_auto_0_xdb *html *log *xwbt

USAGE_DEPTH=0
SMARTGUIDE= 

#############################################################################
# Simulation constants
SIMCLEAN=wb_BCD_tb.vvp wb_BCD_tb.vcd verilog.log wb_BCD_tb.vvp.list simulation

CVER=cver
GTKWAVE=gtkwave
IVERILOG=iverilog
VVP=vvp
	
#############################################################################
# 
sim: wb_BCD_tb.vcd
syn: wb_BCD.bit
view: wb_BCD_tb.view

#############################################################################
# Ikarus verilog simulation

wb_BCD_tb.vvp:
	rm -rf  simulation && mkdir simulation
	cp wb_BCD_tb.v simulation && cd simulation && rm -f $@.list
	for i in $(SRC); do echo $$i >> simulation/$@.list; done
	for i in $(SIM_SRC); do echo $$i >> simulation/$@.list; done
	cd simulation && $(IVERILOG) -o $@ $(VINCDIR) -c $@.list -s $(@:.vvp=)

postsim: wb_BCD.ngc
	cd build &&  netgen -sim -ofmt verilog wb_BCD.ngc
	cd build && iverilog -Wall \
	-y $(XILINXCADROOT)/verilog/src/unisims \
	-y $(XILINXCADROOT)/verilog/src/XilinxCoreLib \
	-y ../   \
	wb_BCD.v ../wb_BCD_tb.v -o wb_BCD.bin
	cd build &&  vvp wb_BCD.bin

%.vcd: %.vvp
	cd simulation && $(VVP) $<

#############################################################################
# ISE Synthesis


wb_BCD.prj:
	rm -rf build && mkdir build
	@rm -f $@
	for i in $(SRC); do echo verilog work $$i >> build/$@; done
	for i in $(SRC_HDL); do echo VHDL work $$i >> build/$@; done

wb_BCD.ngc: wb_BCD.prj
	cd build && xst -ifn ../wb_BCD.xst

wb_BCD.ngd: wb_BCD.ngc wb_BCD.ucf
	cd build && ngdbuild -uc ../wb_BCD.ucf wb_BCD.ngc

wb_BCD.ncd: wb_BCD.ngd
	cd build && map $(SMARTGUIDE) wb_BCD.ngd

wb_BCD-routed.ncd: wb_BCD.ncd
	cd build && par $(SMARTGUIDE) -ol high -w wb_BCD.ncd wb_BCD-routed.ncd

wb_BCD.bit: wb_BCD-routed.ncd
	cd build &&  bitgen -w wb_BCD-routed.ncd wb_BCD.bit
	@mv -f build/wb_BCD.bit $@

wb_BCD.mcs: wb_BCD.bit
	cd build && promgen -u 0 wb_BCD

wb_BCD-routed.xdl: wb_BCD-routed.ncd
	cd build && xdl -ncd2xdl wb_BCD-routed.ncd wb_BCD-routed.xdl

wb_BCD-routed.twr: wb_BCD-routed.ncd
	cd build &&  trce -v 10 wb_BCD-routed.ncd wb_BCD.pcf

timing: wb_BCD-routed.twr

usage: wb_BCD-routed.xdl
	xdlanalyze.pl wb_BCD-routed.xdl $(USAGE_DEPTH)

####################################################################
# final targets

%.view: %.vcd
	cd simulation && $(GTKWAVE) $< $<.save.sav

clean:
	rm -Rf build $(SYNCLEAN) $(SIMCLEAN) 

.PHONY: clean view


