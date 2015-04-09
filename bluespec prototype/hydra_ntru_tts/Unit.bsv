import Type::*;

interface Unit;
	method Action load(Data re);
	method Action instr(Bool isMod307, Data a1, Data a2, Data a3, Data a4, Data a5);
	method Data read;
endinterface

(* synthesize *)
module mkUnit(Unit);
	Reg#(Bit#(9)) result <- mkRegA(0);

	method Action load(Bit#(9) re);
		result <= re;
	endmethod
	method Action instr(Bool isMod307, Bit#(9) a1, Bit#(9) a2, Bit#(9) a3, Bit#(9) a4, Bit#(9) a5);
		Bit#(10) d1 = zeroExtend(a1) + zeroExtend(a2);
		Bit#(10) d2 = zeroExtend(a3) + zeroExtend(a4);
		Bit#(10) d3 = zeroExtend(a5) + zeroExtend(result);
		Bit#(12) re = zeroExtend(d1) + zeroExtend(d2) + zeroExtend(d3);

		Bit#(9) mod31 = truncate(re%31);
		Bit#(9) mod307 = truncate(re%307);

		result <= isMod307 ? mod307:mod31;
	endmethod
	method Bit#(9) read = result;
endmodule
