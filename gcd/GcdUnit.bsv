//========================================================================
// Basic GCD Unit
//========================================================================

interface IGcdUnit;

  // Start a new GCD computation on the given operands 
  method Action start( Int#(32) a_in, Int#(32) b_in );

  // Return the result of the GCD computation
  method Int#(32) result();

endinterface

//------------------------------------------------------------------------
// GcdUnit
//------------------------------------------------------------------------

(* synthesize *)
module mkGcdUnit( IGcdUnit );

  Reg#(Int#(32)) a <- mkRegU;
  Reg#(Int#(32)) b <- mkReg(0);

  rule swap (( a < b ) && ( b != 0 ));
    a <= b;
    b <= a;
  endrule

  rule subtract (( a >= b ) && ( b != 0 ));
    a <= a - b;
  endrule

  method Action start( Int#(32) a_in, Int#(32) b_in ) if ( b == 0 );
    a <= a_in;
    b <= b_in;    
  endmethod

  method Int#(32) result() if ( b == 0 );
    return a;
  endmethod

endmodule

