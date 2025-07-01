#include "Vexponential.h" // Include the generated header file for the Verilog module
#include "verilated.h"    // Include Verilator support
#include <iostream>       // Include standard input/output library

int main(int argc, char **argv) {
    // Pass command-line arguments to Verilator for initialization
    Verilated::commandArgs(argc, argv);

    // Create an instance of the top-level Verilog module
    Vexponential* top = new Vexponential;

    // Evaluate the combinational logic of the module
    // This triggers the computation defined in the Verilog module
    top->eval();

    // Print the results:
    // `top->result` holds the output of the Verilog module in fixed-point representation.
    // Divide by 1000.0 to convert the fixed-point result back to a floating-point approximation.
    std::cout << "exp(3.0) approx (fixed-point): " << top->result << std::endl;
    std::cout << "exp(3.0) approx (float)      : " << top->result / 1000.0 << std::endl;

    // Clean up the allocated memory for the module
    delete top;

    // Indicate successful program termination
    return 0;
}
