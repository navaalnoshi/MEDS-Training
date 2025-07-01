module squareroot (
    input  logic [31:0] x,        
    output logic [15:0] result  
);

    function automatic [15:0] int_sqrt(input [31:0] num);
        integer low, high, mid;  
        begin
            low = 0;            
            high = num;        
            // Binary search loop to calculate the square root
            while (low <= high) begin
                mid = (low + high) >> 1;  // Calculate the mid-point (right shift by 1 is equivalent to division by 2)
                
                // Check if the square of mid is less than or equal to the input number
                if (mid * mid <= num)
                    low = mid + 1;       // Move the lower bound up to narrow the range
                else
                    high = mid - 1;      // Move the upper bound down to narrow the range
            end

            // Return the computed square root
            int_sqrt = high[15:0];       // Assign the upper bound as the integer square root
                                        // Only take the lower 16 bits to fit the result size
        end
    endfunction

    // Combinational logic to compute the square root
    always_comb begin
        if (x == 0)
            result = 0;                  // Handle edge case: square root of 0 is 0
        else
            result = int_sqrt(x);     
    end

endmodule
