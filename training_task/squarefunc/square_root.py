def sqrt(x):
    if not isinstance(x, int):
        raise ValueError("Input must be an integer")

    # Handle the case of negative input
    if x < 0:
        return None  # Square root of a negative number is undefined in this context

    # Initialize the search range for binary search
    low = 0          # Lower bound
    high = x         # Upper bound
    ans = 0          # Variable to store the result

    # Perform binary search to find the integer square root
    while low <= high:
        mid = (low + high) // 2  
       
        if mid * mid <= x:
            ans = mid         
            low = mid + 1      
        else:
            high = mid - 1     
    return ans  

# Example usage
print(sqrt(28))  # Output: 5
