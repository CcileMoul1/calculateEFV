% Calculation directly from the constraints
S = [1 -1 -1]; % Stoichiometric matrix (m rows, r columns)
Iirrev = [1 0 1]; % Boolean vector indicating if the ith reaction is irreversible (1) or not (0)
G = [-1 0 0 ; 0 1 0 ; 1 0 0]; % Matrix (n rows, r columns)
h = [-2 ; -1 ; 0]; % vector with n rows. 
% G and h explain the linear constraints  Gv >= h (v is the vector of flux)
efv = constraintsToEFV(S,Iirrev,G,h);


% Calculation from the files
efv2 = calculateEFV('example.dat','example_constraints.dat');
