
# Hash Table Analysis

A C++ project focused on implementing and evaluating a hash table based on separate chaining. The project explores hash-function quality, key distribution, and lookup performance using statistical analysis and profiling tools.

## Table of Contents

- [Overview](#overview)
- [Project Goals](#project-goals)
- [Hash Function Analysis](#hash-function-analysis)
- [Performance Evaluation](#performance-evaluation)
- [Results](#results)
- [Project Structure](#project-structure)
- [Documentation](#documentation)

## Overview

The hash table uses an array of buckets, with each bucket implemented as a singly linked list. This design allows collisions to be handled through separate chaining.

The project compares several hash functions and evaluates their impact on bucket distribution and lookup performance. It also uses profiling tools to investigate execution costs and potential optimization opportunities.

## Project Goals

- Implement a hash table using separate chaining.
- Compare the distribution quality of different hash functions.
- Evaluate collision rates and bucket occupancy.
- Measure lookup performance under different workloads.
- Explore performance profiling with Valgrind and Cachegrind.
- Identify the trade-offs between hash-function complexity and distribution quality.

## Hash Function Analysis

The project evaluates the following hash functions:

| Hash function | Purpose |
|---|---|
| `hash_zero` | Baseline used to illustrate poor distribution |
| `hash_first` | Uses the first character of the key |
| `hash_word` | Uses a word-based component of the key |
| `hash_xor` | Uses XOR-based operations |
| `hash_xor_reversed` | Applies XOR-based processing in reverse order |
| `hash_rol` | Uses a rotate-left operation |
| `hash_ror` | Uses a rotate-right operation |
| `crc32` | Uses CRC-32-based hashing |

The analysis focuses on how evenly keys are distributed across buckets. A good hash function should minimize clustering and reduce the average length of collision chains.

### Distribution Visualizations

The following plots illustrate the bucket distributions produced by the tested hash functions.

| Hash function | Distribution |
|---|---|
| `hash_zero` | ![Zero hash distribution](images/graph_zero.png) |
| `hash_first` | ![First-character hash distribution](images/graph_first.png) |
| `hash_word` | ![Word-based hash distribution](images/graph_word.png) |
| `hash_xor` | ![XOR hash distribution](images/graph_xor.png) |
| `hash_xor_reversed` | ![Reversed XOR hash distribution](images/graph_xor_reversed.png) |
| `hash_rol` | ![Rotate-left hash distribution](images/graph_rol.png) |
| `hash_ror` | ![Rotate-right hash distribution](images/graph_ror.png) |
| `crc32` | ![CRC-32 hash distribution](images/graph_crc32.png) |

## Performance Evaluation

The project evaluates lookup performance and uses profiling data to investigate the behavior of the implementation.

The benchmark results include different lookup workloads, including unsuccessful searches. Cachegrind is used to collect information about simulated cache behavior and branch prediction.

### Benchmark Results

![Miss benchmark](images/bench_miss.png)

![Benchmark without optimization](images/bench_no_optimize.png)

## Results

The experiments demonstrate that hash-function choice has a substantial effect on bucket distribution.

- Simple functions may produce severe clustering when they use too little information from a key.
- XOR-based functions can improve distribution, but their effectiveness depends on the input data.
- Rotation-based functions can provide a more balanced distribution for the tested dataset.
- CRC-32 provides a useful comparison point for distribution quality and computational cost.

A more uniform distribution generally reduces collision-chain lengths and can improve lookup performance. However, distribution quality alone does not determine runtime: the cost of computing the hash and the memory-access pattern also matter.

## Project Structure

```text
.
├── include/       # Public headers
├── src/           # Implementation
├── csv/           # Experimental data
├── images/        # Generated plots and benchmark charts
├── cache_grind/   # Cachegrind profiling output
├── Dump_inf/      # Graph-related output
├── Makefile
├── README.md
├── REQUIREMENTS.md
└── BUILDING.md
```
