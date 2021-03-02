% N is the stoechiometric matrix (m*r), G is a matrix (n*r) and h is a vector (n*1) explaining the linear constraints : Gv >= h (v is the vector of flux)
% Iirrev is the vector of irreversible reactions (Iirrev_i = 0 if the reaction i is reversible, 1 if it's irreversible) (the size of the vector is r, the number of reactions)
% The consistency of the sizes are not tested

% This function transforms the constraints (N,Iirrev,G,h) into a stoechiometric matrix and a list of irreversible reaction (in order to calculate EFM from them)
function net = constraintsToPseudoEFMMatrix(N,Iirrev,G,h)
	[m,r] = size(N);
	[n, r2] = size(G);
	
	net.st = [N, zeros(m,n), zeros(m,1);
				 G, -eye(n),    -h];
				 
	[li,ci] = size(Iirrev);
	% I force Iirrev to be a line vector
	if(ci==1)
		Iirrev = Iirrev';
	end
	
	net.irrev_react = [Iirrev, ones(1,n+1)];
end
