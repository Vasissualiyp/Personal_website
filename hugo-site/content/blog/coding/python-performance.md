---
title: "Python Performance Tips for Scientific Computing"
date: 2025-11-20
draft: false
author: "Vasilii Pustovoit"
tags: ["Python", "performance", "scientific computing"]
summary: "Making your Python code 10-100x faster without rewriting in C"
---

# Python Performance Tips for Scientific Computing

Python is great for scientific computing, but it can be slow. Here are my favorite techniques for speeding up Python code without dropping down to C.

## 1. Use NumPy Vectorization

**Bad** (Pure Python):
```python
result = []
for i in range(len(data)):
    result.append(data[i] ** 2)
```

**Good** (NumPy):
```python
result = data ** 2
```

The NumPy version is typically 100x faster!

## 2. Numba JIT Compilation

For loops you can't vectorize, use Numba:

```python
from numba import jit

@jit(nopython=True)
def calculate_distances(positions):
    n = len(positions)
    distances = np.zeros((n, n))
    for i in range(n):
        for j in range(i+1, n):
            dx = positions[i, 0] - positions[j, 0]
            dy = positions[i, 1] - positions[j, 1]
            dz = positions[i, 2] - positions[j, 2]
            distances[i, j] = np.sqrt(dx*dx + dy*dy + dz*dz)
    return distances
```

The `@jit` decorator compiles this to machine code - first call is slow, subsequent calls are C-speed.

## 3. Parallel Processing

Use `multiprocessing` for CPU-bound tasks:

```python
from multiprocessing import Pool

def process_snapshot(snapshot_number):
    # Heavy computation here
    return result

with Pool(processes=8) as pool:
    results = pool.map(process_snapshot, range(100))
```

This gave me near-linear speedup on my 8-core workstation.

## 4. Use the Right Data Structures

Checking membership:
```python
# Slow (list)
if particle_id in particle_list:  # O(n)
    ...

# Fast (set)
if particle_id in particle_set:   # O(1)
    ...
```

## 5. Profile Before Optimizing

Always profile first! Don't optimize based on guesses:

```python
import cProfile
cProfile.run('my_function()')
```

Or use line_profiler for line-by-line profiling:

```python
@profile
def my_function():
    # code here
    pass
```

Run with: `kernprof -l -v script.py`

## 6. Memory-Mapped Files for Large Data

When working with simulation data too large for RAM:

```python
import numpy as np

# Don't load entire file into memory
data = np.load('huge_file.npy', mmap_mode='r')

# Access slices as needed
subset = data[1000:2000]
```

## Real World Example

I applied these techniques to my Pop III star analysis code:

- **Original**: 6 hours to process 100 snapshots
- **After NumPy vectorization**: 45 minutes
- **After adding Numba**: 8 minutes
- **After multiprocessing**: 1.5 minutes

45x speedup without leaving Python!

## When to Use C/Fortran

Only drop to C/Fortran when:
- You've exhausted Python optimization
- The bottleneck is truly algorithmic
- You need specific low-level control

Usually, proper use of NumPy/Numba is enough.

Happy optimizing!
