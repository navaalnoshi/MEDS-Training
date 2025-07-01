module exponential (
    output logic [31:0] result 
);
  
    parameter int X = 3000;    
    parameter int SCALE = 1000; 
    parameter int TERMS = 20;   // Number of terms for the Taylor series expansion of e^x.

   
    int term; // Holds the current term in the Taylor series expansion.
    int z;    // for the summation of terms.
    int i;    // Loop variable.

    // Always block with combinational logic
    always_comb begin
        term = SCALE;  // Initialize the first term of the Taylor series: term = 1.0.
        z = SCALE;     // Initialize the result z with the first term: z = 1.0.

        // Loop to calculate the Taylor series terms
        for (i = 1; i < TERMS; i++) begin.
            term = (term * X) / (i * SCALE); 
            z = z + term;
        end
        result = z;
    end
endmodule
