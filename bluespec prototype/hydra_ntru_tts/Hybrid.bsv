import Vector::*;
import StmtFSM::*;
import RegFile::*;

import Unit::*;


interface Hybrid;
	method Action setRF1(Bit#(7) addr1, Vector#(10,Bit#(5)) data1);
	method Action setRF2(Bit#(5) addr1, Vector#(10, Bit#(5)) data1);
	method Action setRE(Bit#(5) addr1, Bit#(180) data1);
	method Action ntru_mult(Vector#(397, Bit#(1)) data1);
	method Bit#(180) read(Bit#(5) addr1);


	method Action tts_mult(Vector#(20, Bit#(5)) v1);
endinterface


typedef enum{Idle , NTRU_Mult, TTS_Mult} State deriving (Eq, Bits);


(*synthesize*)
module mkHybrid(Hybrid);
	Vector#(20, Unit) unit <- replicateM(mkUnit);
	Reg#(State) state <- mkRegA(Idle);
	Reg#(State) stateStack <- mkRegA(Idle);

	Vector#(10, RegFile#(Bit#(7), Bit#(5))) rf1 <- replicateM(mkRegFile(0, 79));
	Vector#(10, RegFile#(Bit#(5), Bit#(5))) rf2 <- replicateM(mkRegFile(0, 19));

	RegFile#(Bit#(5), Bit#(180)) re <- mkRegFile(0, 19);
	
	Vector#(397, Reg#(Bit#(1))) f2 <- replicateM(mkRegA(0));
	Vector#(20, Reg#(Bit#(5))) vectorB <- replicateM(mkRegA(0));

	Reg#(Bit#(10)) idx <- mkRegA(0);
	Reg#(Bit#(10)) addr <- mkRegA(0);




	let ntru_mult_stmt = seq
		idx <= 0;
		while ( idx < 20) seq
			action 
				Vector#(20, Bit#(9)) tmp = unpack(re.sub(truncate(idx)));
				for (Integer i = 0; i < 20; i = i + 1)
					unit[i].load(tmp[i]);
				addr <= 0;
			endaction

			while (addr < 80) action
				Vector#(5, Bit#(9)) a;
				for (Integer i = 0; i < 5; i = i + 1) begin
					let t0 = rf1[2*i].sub(truncate(addr));
					let t1 = rf1[2*i+1].sub(truncate(addr));
					a[i] = truncate({t1, t0});
				end

				for (Integer i = 0; i < 20; i = i + 1) begin
					let t1 = unpack(f2[i]) ? a[0] : 0;
					let t2 = unpack(f2[(i + 396)% 397]) ? a[1] : 0;
					let t3 = unpack(f2[(i + 395)% 397]) ? a[2] : 0;
					let t4 = unpack(f2[(i + 394)% 397]) ? a[3] : 0;
					let t5 = unpack(f2[(i + 393)% 397]) ? a[4] : 0;

					unit[i].instr(True, t1, t2, t3, t4, t5);
				end

				for (Integer i = 0; i < 397; i = i + 1)
					f2[i] <= f2[(i - 5 + 397)%397];
				addr <= addr + 1;
			endaction

			action
				idx <= idx + 1;
				for (Integer i = 0; i < 397; i = i + 1)
					f2[i] <= f2[(i + 23)%397];
				Vector#(20, Bit#(9)) tmp;
				for (Integer i = 0; i < 20; i = i + 1)
					tmp[i] = unit[i].read;
				re.upd(truncate(idx), pack(tmp));
			endaction
		endseq
		state <= stateStack;
	endseq;
	let ntru_mult_fsm <- mkFSMWithPred(ntru_mult_stmt, state == NTRU_Mult);



	let tts_mult_stmt = seq
		// load offset
		action
			Vector#(20, Bit#(9)) tmp = unpack(re.sub(0));
			for (Integer i = 0; i < 20 ; i = i + 1)
				unit[i].load(tmp[i]);
		endaction

		addr <= 0;
		while (addr < 20) action
			Vector#(5, Bool) mux;
			for (Integer i = 0; i < 5; i = i + 1)
				mux[i] = unpack(vectorB[0][i]);
			for (Integer i = 0; i < 20; i = i + 1) begin
				Bit#(9) d;
				if ( i < 10)
					d = zeroExtend(rf1[i].sub(truncate(addr)));
				else
					d = zeroExtend(rf2[i-10].sub(truncate(addr)));
				Vector#(5, Bit#(9)) tmp;
				for (Integer j = 0; j< 5; j = j + 1)
					tmp[j] = mux[j] ? d << j : 0;
				unit[i].instr(False, tmp[0], tmp[1], tmp[2], tmp[3], tmp[4]);
			end

			for (Integer i = 0; i < 20; i = i + 1)
				vectorB[i] <= vectorB[(i+1)%20];
			addr <= addr + 1;
		endaction

		action
			Vector#(20, Bit#(9)) tmp;
			for (Integer i = 0; i < 20; i = i + 1)
				tmp[i] = unit[i].read;
			re.upd(0, pack(tmp));
		endaction
		state <= stateStack;
	endseq;
	let tts_mult_fsm <- mkFSMWithPred(tts_mult_stmt, state == TTS_Mult);

	method Action setRF1(Bit#(7) addr1, Vector#(10,Bit#(5)) data1) if(state == Idle);
		for (Integer i = 0; i < 10; i = i + 1)
			rf1[i].upd(addr1, data1[i]);
	endmethod
	method Action setRF2(Bit#(5) addr1, Vector#(10, Bit#(5)) data1) if(state == Idle);
		for (Integer i = 0; i < 10; i = i + 1)
			rf2[i].upd(addr1, data1[i]);
	endmethod
	method Action setRE(Bit#(5) addr1, Bit#(180) data1) if(state == Idle);
		re.upd(addr1, data1);
	endmethod
	method Action ntru_mult(Vector#(397, Bit#(1)) data1) if(state == Idle);
		ntru_mult_fsm.start;
		state <= NTRU_Mult;
		writeVReg(f2, data1);
	endmethod
	method Bit#(180) read(Bit#(5) addr1) if(state == Idle);
		return re.sub(addr1);
	endmethod



	method Action tts_mult(Vector#(20, Bit#(5)) v1) if (state == Idle);
		tts_mult_fsm.start;
		state <= TTS_Mult;
		writeVReg(vectorB, v1);
	endmethod

endmodule


