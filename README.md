# Inefficient-Sorts
Why use the default comparison functions when you can use ones that have specific use cases?

# Use Cases
I don't know (I already forgot what's the best use case for each one). 


# Runtime [Uniform]
- Using integers in range [0,2500] with a size of 5000. Done consecutively 500 times (probably shouldn't clone the exact same table for comparisons).
- Built in sort (C): 63.3351ms
- QuickSort: DNF (Yes it broke.)
- HeapSort: 3279.4721ms

# Runtime [Randomized]
- Using integers in range [0,2500] with a size of 5000. Done consecutively 500 times.
- Built in sort (C): 147.4886ms
- QuickSort: 691.0440ms
- HeapSort: 3089.0130ms
