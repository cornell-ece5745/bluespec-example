//========================================================================
// Test harness for greatest common divisor unit
//========================================================================

import GcdUnit::*;

//------------------------------------------------------------------------
// Helper function
//------------------------------------------------------------------------

function Action verify( Int#(32) testResult, Int#(32) correctResult );
  if ( testResult == correctResult )
    $display( "  [ passed ] %d == %d ", testResult, correctResult );
  else
    $display( "  [ FAILED ] %d != %d ", testResult, correctResult );
endfunction

//------------------------------------------------------------------------
// Enum for test state machine
//------------------------------------------------------------------------

typedef enum 
{ 
  Test1Start, Test1Finish, 
  Test2Start, Test2Finish,
  Test3Start, Test3Finish,
  Test4Start, Test4Finish,
  Test5Start, Test5Finish,
  Done 
} 
State deriving(Eq,Bits);

//------------------------------------------------------------------------
// Main test harness module
//------------------------------------------------------------------------

(* synthesize *)
module mkGcdUnitTH( Empty );

  // Instantiate the GCD module

  IGcdUnit gcd <- mkGcdUnit();

  // State for managing test cases

  Reg#(State) state <- mkReg(Test1Start);

  //----------------------------------------------------
  // Test 1

  rule test1start ( state == Test1Start );
    gcd.start( 27, 15 );
    state <= Test1Finish;
  endrule

  rule test1finish ( state == Test1Finish );
    verify( gcd.result(), 3 );
    state <= Test2Start;
  endrule

  //----------------------------------------------------
  // Test 2

  rule test2start ( state == Test2Start );
    gcd.start( 21, 49 );
    state <= Test2Finish;
  endrule

  rule test2finish ( state == Test2Finish );
    verify( gcd.result(), 7 );
    state <= Test3Start;
  endrule

  //----------------------------------------------------
  // Test 3

  rule test3start ( state == Test3Start );
    gcd.start( 25, 30 );
    state <= Test3Finish;
  endrule

  rule test3finish ( state == Test3Finish );
    verify( gcd.result(), 5 );
    state <= Test4Start;
  endrule

  //----------------------------------------------------
  // Test 4

  rule test4start ( state == Test4Start );
    gcd.start( 19, 27 );
    state <= Test4Finish;
  endrule

  rule test4finish ( state == Test4Finish );
    verify( gcd.result(), 1 );
    state <= Test5Start;
  endrule

  //----------------------------------------------------
  // Test 5

  rule test5start ( state == Test5Start );
    gcd.start( 40, 40 );
    state <= Test5Finish;
  endrule

  rule test5finish ( state == Test5Finish );
    verify( gcd.result(), 40 );
    state <= Done;
  endrule

  //----------------------------------------------------
  // Done

  rule done ( state == Done );
    $finish;
  endrule

endmodule
