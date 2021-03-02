S = [1 -1 -1];
Iirrev = [1 0 1];
G = [-1 0 0 ; 0 1 0 ; 1 0 0];
h = [-2 ; -1 ; 0];
efv = constraintsToEFV(S,Iirrev,G,h);
disp('With the files')
efv2 = calculateEFV('example.dat','example_constraints.dat');
