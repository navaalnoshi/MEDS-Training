def exp(x):
    terms = 1
    z = 1
    for i in range(1, 20):
        # Calculate the next term: multiply the previous term by (x / i).
        terms *= x / i
        z += terms
    return z

# Test the function by calculating e^3.
t = exp(3)
# Print the result of the approximation.
print(t)
