
module pd_tb;
  parameter op_sz= 6;
  parameter clk_period=10ns;
  reg clk_tb=0;
  always #(clk_period/2) clk_tb=~clk_tb;
  
  //////////////////////////
  
  reg rst,stream_in,pattern_found;
  PD_fsm pattern_detector(.clk(clk_tb),.rst(rst),.stream_in(stream_in),.pattern_found(pattern_found));
  /////////////////////////////////
  task input_data(input data);
    rst=0;
    stream_in= data;
    #(clk_period);
    $display("------------------------------");
    $display("pattern found = %d at %t",pattern_found,$time);
  endtask

  /////////////////////////////////////////////////////////////////////
  task reset_pd();
    rst=1;
    #(clk_period);
  endtask
  
  ///////////////////////////////////////
  
  initial begin
    reset_pd();
    input_data(1);
    input_data(1);
    input_data(0);
    input_data(1);
    input_data(0);
    $display("------------------------------");	
    
   $finish();
  end
  
endmodule