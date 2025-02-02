# Hierarchical-Truss-Structures
This Matlab program creates heterogeneous non-periodic truss using volume minimization with (global) stability constraints. A rod with desired stiffness and critical load could be implemented with an optimized truss with equivalent mechanical properties while using less material. Euler’s critical problem is transformed into the global buckling problem of the truss at the lower level of hierarchy. The recursive algorithm constructs and simultaneously searches the best structure of multi-level hierarchy. 

## Feature
input: 

E: Young's Modulus of the constituent material

w: even integer, topology parameter for Model_Beta

minA: minimum cross-sectional area of bar

L: length of the fusiform truss

F: uniaxial compressive load (required critical load)

k: required (effective) stiffness for the optimal truss 

hier: maximum hierarchy

output: the truss structure

## Quick start
1. Download ZIP and add all folders to Matlab path.

2. Run optTest.m. Matlab may take a long time to initialize parallel computing.

3. Run drawTest.m to visualize the results.
   
![visualization](https://github.com/LyzDede/Hierarchical-Truss-Structures/blob/main/readme.png)

## Contact
LIU Yizhuo

liuyizhuo@seu.edu.cn

School of Architecture, Southeast University



