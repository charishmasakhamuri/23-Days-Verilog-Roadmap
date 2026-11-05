`timescale 1ns/1ps

module tb_sequence_detector_101;

reg clk;
reg rst;
reg din;

wire detected;

integer i;
integer count;

reg [4:0] test_data;

sequence_detector_101 DUT (
    .clk(clk),
    .rst(rst),
    .din(din),
    .detected(detected)
);

// Clock generation: 10 ns period
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    rst       = 1;
    din       = 0;
    count     = 0;
    test_data = 5'b10101;

    // Reset
    repeat (2) @(negedge clk);
    rst = 0;

    // Apply serial input
    for (i = 4; i >= 0; i = i - 1) begin

        din = test_data[i];

        @(posedge clk);
        #1;

        if (detected) begin
            count = count + 1;
            $display("Sequence detected at time %0t", $time);
        end

        @(negedge clk);

    end

    if (count == 2)
        $display("PASS: Two overlapping sequences detected");
    else
        $display("FAIL: Expected 2 detections, Got %0d", count);

    $finish;

end
  //`timescale 1ns/1ps

module tb_sequence_detector_1011;

reg clk;
reg rst;
reg din;

wire detected;

integer i;
integer count;

reg [6:0] test_data;

sequence_detector_1011 DUT (
    .clk(clk),
    .rst(rst),
    .din(din),
    .detected(detected)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    rst       = 1;
    din       = 0;
    count     = 0;
    test_data = 7'b1011011;

    // Reset
    repeat (2) @(negedge clk);
    rst = 0;

    // Apply input serially
    for (i = 6; i >= 0; i = i - 1) begin

        din = test_data[i];

        @(posedge clk);
        #1;

        if (detected) begin
            count = count + 1;
            $display("Sequence detected at time %0t", $time);
        end

        @(negedge clk);

    end

    if (count == 1)
        $display("PASS: One non-overlapping sequence detected");
    else
        $display("FAIL: Expected 1 detection, Got %0d", count);

    $finish;

end

endmodule

endmodule
