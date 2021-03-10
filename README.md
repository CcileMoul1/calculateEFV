# calculateEFV
Matlab implementation of the calculation of Elementary Flux Vector of a network.
Inspired by **From elementary flux modes to elementary flux vectors: Metabolic pathway analysis with arbitrary linear flux constraints** by Klamt et al, 2017 [(the article)](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005409#sec007).

## Installation
This code has to be able to run [Metatool](http://pinguin.biologie.uni-jena.de/bioinformatik/networks/). Store Metatool in the same folder as **calculateEFV**, add it to the Matlab path for [the session](http://fr.mathworks.com/help/matlab/ref/addpath.html) or [permanently](https://fr.mathworks.com/help/matlab/matlab_env/what-is-the-matlab-search-path.html).

## Usage
(see test_protocole.m to try it)

### You can calculate the EFV directly from the constraints

```Matlab
S = [1 -1 -1]; % Stoichiometric matrix (m rows, r columns)
Iirrev = [1 0 1]; % Boolean vector indicating if the ith reaction is irreversible (1) or not (0)
G = [-1 0 0 ; 0 1 0 ; 1 0 0]; % Matrix (n rows, r columns)
h = [-2 ; -1 ; 0]; % vector with n rows.
% G and h explain the linear constraints  Gv >= h (v is the vector of flux)
efv = constraintsToEFV(S,Iirrev,G,h);
```
**Warning** the size consistency is not tested
```constraintsToEFV``` calculates the EFV of the given structure (Sv = 0, vi>=0 if vi irreversible, Gv>=h ). It returns a structure : efv.vectors contains the efv and efv.bounded contains a boolean vector (1 and 0) of "is this efv bounded ?"

### You can store the constraints into files and calculate the efv from these files
```Matlab
efv2 = calculateEFV('example.dat','example_constraints.dat');
```
```example.dat``` describe the network (stoichiometric matrix). It uses the Metatool format file.
```example_constraints.dat``` contains the linear constraints (Gv >= h). The format is describe in describe_constraint.txt
