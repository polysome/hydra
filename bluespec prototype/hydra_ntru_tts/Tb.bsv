import Vector::*;
import StmtFSM::*;

import Hybrid::*;

module mkTb(Empty);
	let hybrid <- mkHybrid;
	Reg#(Bit#(10)) addr <- mkRegA(0);


	Vector#(400, Bit#(5)) matrixA;
	Vector#(20, Bit#(5)) vectorB;
#include "wiedemann_tb.h"

/*
	Vector#(397, Bit#(1)) m;
	Vector#(397, Bit#(1)) r;
	Vector#(400, Bit#(9)) h;
	Vector#(397, Bit#(1)) f;
	Vector#(397, Bit#(1)) fp;
#include "ntru_tb.h"
h[397] = 0;
h[398] = 0;
h[399] = 0;

	let ntru_stmt = seq
		// Enc
		// set Re
		addr <= 0;
		while (addr < 20) action
			Vector#(20, Bit#(9)) tmp;
			for (Integer i = 0; i < 20 ;i = i + 1)
				tmp[i] = zeroExtend(m[20*addr + fromInteger(i)]);
			hybrid.setRE(truncate(addr),pack(tmp));
			addr <= addr + 1;
		endaction

		// set RF
		addr <= 0;
		while (addr < 80) action
			Vector#(10, Bit#(5)) tmp;
			for ( Integer i = 0; i < 5; i = i + 1) begin
				let t = h[addr *5 + fromInteger(i)];
				tmp[i*2] = t[4:0];
				tmp[i*2+1] = {0,t[8:5]};
			end
			hybrid.setRF1(truncate(addr),tmp);
			addr <= addr + 1;
		endaction

		hybrid.ntru_mult(r);

		addr <= 0;
		while (addr < 20) action
			Vector#(20, Bit#(9)) tmp = unpack(hybrid.read(truncate(addr)));
			addr <= addr + 1;
			for (Integer i = 0; i < 20; i = i + 1)
				$display("enc[%d] := %d", addr *20 + fromInteger(i), tmp[i]);
		endaction

		$finish(0);
	endseq;
	let ntru_fsm <- mkFSM(ntru_stmt);
*/

	let tts_stmt = seq
		hybrid.setRE(0, 0);
		addr <= 0;
		while (addr < 20) action
			addr <= addr + 1;
			Vector#(10, Bit#(5)) tmp;
			for (Integer i = 0; i < 10; i = i + 1)
				tmp[i] = matrixA[addr + fromInteger(i*20)];
			hybrid.setRF1(truncate(addr), tmp);

			Vector#(10, Bit#(5)) tmp2;
			for (Integer i = 0; i < 10; i = i + 1)
				tmp2[i] = matrixA[addr + fromInteger((i+10)*20)];
			hybrid.setRF2(truncate(addr), tmp2);

		endaction
		hybrid.tts_mult(vectorB);
		
		action
			Vector#(20, Bit#(9)) tmp = unpack(hybrid.read(0));
			for (Integer i = 0; i < 20; i = i + 1)
				$display(i, tmp[i]);

		endaction
		$finish(0);
	endseq;
	let tts_fsm <- mkFSM(tts_stmt);


	rule main;
//		ntru_fsm.start;
		tts_fsm.start;
	endrule
endmodule
