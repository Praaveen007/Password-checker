`timescale 1ns / 1ps

module password_security (
    input  wire       clk,
    input  wire       reset,
    input  wire [3:0] password,
    input  wire       enter,
    output reg        access_granted,
    output reg        error,
    output reg        timeout
);

parameter CORRECT_PASSWORD = 4'b1011;

reg [1:0] wrong_attempts;
reg timeout_state;

reg clear_after_grant; 

always @(posedge clk or posedge reset) begin
    if (reset) begin
        access_granted    <= 0;
        error             <= 0;
        timeout           <= 0;
        wrong_attempts    <= 0;
        timeout_state     <= 0;
        clear_after_grant <= 0;
    end else begin
        if (timeout_state) begin
            
            access_granted    <= 0;
            error             <= 0;
            timeout           <= 1;
            clear_after_grant <= 0;
        end else if (clear_after_grant) begin
            
            access_granted    <= 0;
            error             <= 0;
            timeout           <= 0;
            wrong_attempts    <= 0;
            clear_after_grant <= 0;
        end else if (enter) begin
            if (password == CORRECT_PASSWORD) begin
                access_granted    <= 1;  
                error             <= 0;
                timeout           <= 0;
                clear_after_grant <= 1;   
                
                wrong_attempts    <= 0;
            end else begin
                access_granted    <= 0;
                error             <= 1;
                clear_after_grant <= 0;   

                wrong_attempts    <= wrong_attempts + 1;
                if ((wrong_attempts + 1) >= 3) begin
                    timeout_state <= 1;
                    timeout       <= 1;
                end else begin
                    timeout       <= 0;
                end
            end
        end else begin
            
            access_granted    <= 0;
            error             <= 0;
            timeout           <= timeout_state ? 1 : 0;
            clear_after_grant <= 0;
        end
    end
end

endmodule

