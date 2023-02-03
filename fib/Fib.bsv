//========================================================================
// mkFib
//========================================================================

(* synthesize *)
module mkFib();

  Reg#(Bit#(32)) n_prev <- mkReg(0);
  Reg#(Bit#(32)) n      <- mkReg(1);

  rule fib;

    Bit#(32) n_next = n_prev + n;
    n_prev <= n;
    n      <= n_next;

    $display( "%0d", n );
    if ( n > 50 )
      $finish(0);

  endrule

endmodule

