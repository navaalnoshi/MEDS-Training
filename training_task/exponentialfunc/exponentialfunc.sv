module exponential (
    output logic [31:0] result
);
  
    parameter int X = 3;    // Input value for e^X (integer format for simplicity).
    parameter int TERMS = 20;  // Number of terms for the Taylor series expansion.

    int term;  // Holds the current term in the Taylor series expansion.
    int z;     // Summation of terms (final result).
    int i;     // Loop variable.

    // Always block with combinational logic
    always_comb begin
        term = 1;   // Initialize the first term: 1 (corresponds to 1.0 in floating-point).
        z = 1;      // Initialize the result with the first term: 1.

        // Loop to calculate the Taylor series terms
        for (i = 1; i < TERMS; i++) begin
            term = (term * X) / i;  // Update term: term = term * X / i.
            z = z + term;           // Add the term to the result.
        end

        result = z;  // Assign the final result.
    end
endmodule

