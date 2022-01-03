// SynaptiCAD Verilog diagram file
//-------------------------------------------------------

`include "syncad.v"

`timescale 1 ns/1 ps
//-------------------------------------------------------

// Begin Module Declaration
module Exp9_Timing (tb_trigger, tb_status);

// Port Declarations
    input [1:0] tb_trigger;
    output [1:0] tb_status;

// Begin Process Infrastructure Declaration
    reg [1:0] tb_status;
    integer tb_transaction_run_count;
// Update Status Loop
  always @(tb_trigger)
    if ((tb_trigger === `TB_ONCE) || (tb_trigger === `TB_LOOPING))
      begin
        if ((tb_status === `TB_ONCE) || (tb_status === `TB_LOOPING))
          begin
            $display("Exp9_Timing is already executing.  Ignoring request to execute.");
          end
        else
          tb_status = tb_trigger;
      end
    else
      if (tb_trigger === `TB_ABORT)
        tb_status = `TB_DONE;
  always @(tb_status)
    begin
      if (tb_status === `TB_ONCE || tb_status === `TB_LOOPING)
        begin
          tb_transaction_run_count = tb_transaction_run_count + 1;
          if (tb_status === `TB_ONCE)
            begin
            $display("Executing \"Exp9_Timing\" TB_ONCE at time: %t  transaction_run_count: %d",$time,tb_transaction_run_count);
            end
          else
            begin
            $display("Executing \"Exp9_Timing\" TB_LOOPING at time: %t  transaction_run_count: %d",$time,tb_transaction_run_count);
            end
        end
      if (tb_status === `TB_DONE)
        begin
          if  (tb_transaction_run_count > 0)
            begin
              $display("Execution \"Exp9_Timing\" TB_DONE at time: %t  transaction_run_count: %d",$time,tb_transaction_run_count);
            end
        end
    end

// Begin Unclocked Sequence
  initial
  begin
    $timeformat(-9,3,"ns",7);
    tb_transaction_run_count = 0;
    forever
    begin
      forever
      begin :Unclocked_Sequence

        @(tb_status);

      end // Unclocked_Sequence
    end // forever
  end // initial

// End Unclocked Sequence

endmodule // Exp9_Timing

//-----------------------------------------------------------------

