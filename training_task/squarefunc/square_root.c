#include <stdio.h>

double sqrt_custom(double x, double precision) {
    // Check for invalid input (square root of negative numbers is not real)
    if (x < 0) {
        return -1; 
    }
    // Initialize the range for binary search
    double low = 0.0, high = x, mid, ans = 0.0;

    // Special case: for numbers between 0 and 1, adjust the high value to 1.0
    if (x < 1.0) {
        high = 1.0;  // This ensures the range covers the square root for x < 1
    }

    while ((high - low) > precision) {
        mid = (low + high) / 2; // Calculate the midpoint of the current range

        // Check if the square of the midpoint is less than or equal to the input
        if (mid * mid <= x) {
            ans = mid;  
            low = mid;   
        } else {
            high = mid; 
        }
    }

    return ans;
}

int main() {
    // Test the sqrt_custom function with various inputs
    printf("sqrt(28) = %.6f\n", sqrt_custom(28, 1e-6)); // Test with 28
    printf("sqrt(1)  = %.6f\n", sqrt_custom(1, 1e-6));  // Test with 1
    printf("sqrt(0)  = %.6f\n", sqrt_custom(0, 1e-6));  // Test with 0
    printf("sqrt(5)  = %.6f\n", sqrt_custom(5, 1e-6));  // Test with 5

    return 0;
}
