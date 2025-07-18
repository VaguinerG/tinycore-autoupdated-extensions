## Maximum Performance TinyCore Packages

### Flags

- **`-Ofast`**  
  Enables all `-O3` optimizations plus unsafe math and standard-breaking transforms (e.g., assumes no NaNs or signed overflow).

- **`-march=alderlake -mtune=alderlake`**  
  Uses all CPU features from Alder Lake.

- **`-fmerge-all-constants`**  
  Deduplicates identical constants (arrays, strings, etc.) across translation units to reduce size and improve cache efficiency.

- **`-fno-semantic-interposition`**  
  Assumes symbols are not replaced at runtime, allowing cross-module inlining and better optimization of function calls and globals.

- **`-ftree-vectorize`**  
  Enables vectorization at the GIMPLE tree level for both loops and straight-line code, using SIMD instructions where possible.

- **`-fipa-pta`**  
  Performs whole-program pointer analysis across functions to improve alias detection and unlock more aggressive optimization.

- **`-funroll-loops`**  
  Fully unrolls loops with constant bounds to remove loop control overhead and increase ILP (instruction-level parallelism).

- **`-floop-nest-optimize`**  
  Enables Pluto-based loop restructuring using ISL to improve cache locality and expose parallelism. Experimental.

---

### Warning

These flags prioritize **performance** over **portability** and **standards compliance**.

## Package Optimization Summary

| Package        | Version  | Flags Changed                          | Notes                                                              |
|----------------|----------|----------------------------------------|--------------------------------------------------------------------|
| MicroPython    | 1.25.0   | `-flto` added                          | Builds and runs correctly with all custom optimizations.           |
| Wine (Staging) | 10.12    | `-O3`                                  | `-Ofast` causes runtime issues; downgraded to `-O3`.               |
