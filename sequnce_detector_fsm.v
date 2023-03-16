module PD_fsm(input clk,
             input rst,
             input stream_in,
             output reg pattern_found);
  
  parameter state_reg_width=3;
  parameter [state_reg_width-1 : 0] s_0=3'b000, s_1=3'b001, s_11=3'b010, s_110=3'b011,
  s_1101 = 3'b100, s_11010= 3'b101;
  
  reg [state_reg_width-1 : 0] next_state, curr_state ;
  //////////////////////// state register /////////////////
  always @(posedge clk) begin
    if(rst) begin
      curr_state <= s_0;
    end
    else begin
      curr_state <= next_state;
    end
  end
  
  ////////////////////// next state and output logic /////////////////
  always @(*)begin
    pattern_found=0;
    case(curr_state)
      s_0: begin
        if(stream_in==1) begin
          next_state =s_1; 
        end
        else begin
          next_state = s_0;
        end
      end
      s_1: begin
        if(stream_in==1) begin
          next_state =s_11; 
        end
        else begin
          next_state = s_0;
        end
      end
      s_11: begin
        if(stream_in==1) begin
          next_state =s_11; 
        end
        else begin
          next_state = s_110;
        end
      end
      s_110: begin
        if(stream_in==1) begin
          next_state =s_1101; 
        end
        else begin
          next_state = s_0;
        end
      end
      s_1101: begin
        if(stream_in==1) begin
          next_state =s_11; 
        end
        else begin
          next_state = s_11010;
        end
      end
      s_11010: begin
        pattern_found =1;
        if(stream_in==1) begin
          next_state =s_1; 
        end
        else begin
          next_state = s_0;
        end
      end
      default: begin
        next_state = s_0;
      end 
    endcase
  end 
endmodule
///////////////////////////////////////////////
