`timescale 1ns / 1ps

module tb_password_security;

    reg clk;
    reg reset;
    reg [3:0] password;
    reg enter;
    wire access_granted;
    wire error;
    wire timeout;

    
    password_security uut (
        .clk(clk),
        .reset(reset),
        .password(password),
        .enter(enter),
        .access_granted(access_granted),
        .error(error),
        .timeout(timeout)
    );


    initial clk = 0;
    always #5 clk = ~clk;


    task enter_and_check(input [3:0] pw, input [127:0] msg);
    begin
        password = pw;
        enter = 1;
        @(posedge clk);
        
        $display("%0t: %s | Password=%b | AccessGranted=%b | Error=%b | Timeout=%b",
                 $time, msg, pw, access_granted, error, timeout);

        enter = 0; 
        
        @(posedge clk); 
        @(posedge clk); 
    end
    endtask

    initial begin
        
        reset = 1; password = 4'b0000; enter = 0;
        @(posedge clk); @(posedge clk);
        reset = 0;

        
        enter_and_check(4'b1011, "Test 1: Correct password");
        enter_and_check(4'b1001, "Test 2: Wrong password #1");
        enter_and_check(4'b0000, "Test 3: Wrong password #2");
        enter_and_check(4'b0101, "Test 4: Wrong password #3 (timeout expected)");
        enter_and_check(4'b1011, "Test 5: Attempt during timeout (should fail)");

        
        reset = 1;
        @(posedge clk);
        reset = 0;
        @(posedge clk);

      
        enter_and_check(4'b1011, "Test 6: Correct password after reset");

        #20;
        $display("Simulation complete.");
        $finish;
    end
endmodule
