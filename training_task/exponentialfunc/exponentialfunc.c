#include <stdio.h>
double exp(double x, int n);    // The function `exp` calculates an approximation of e^x using the Taylor series expansion.
// x: The exponent.
// n: The number of terms in the Taylor series used for approximation.
int main(void) {
    double x = 3; // Exponent for e^x
    int n = 20;   // Number of terms for the Taylor series approximation
    double result = exp(x, n);

    // Print the result in a formatted output
    printf("exp(%.2f) ≈ %.6f\n", x, result);
    return 0; 
}

// Function to compute exponential using Taylor series
double exp(double x, int n) {
    double term = 1.0; // First term of the series
    double sum = 1.0;  // Start the summation with the first term

    // Loop to calculate the terms of the Taylor series up to the nth term
    for (int i = 1; i <= n; i++) {
        term *= x / i;
        sum += term;
    }
    // Return the calculated sum, which approximates e^x
    return sum;
}
