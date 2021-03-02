% N is the stoechiometric matrix (m*r), G is a matrix (n*r) and h is a vector (n*1) explaining the linear constraints : Gv >= h (v is the vector of flux)
% Iirrev is the vector of irreversible reactions (Iirrev_i = 0 if the reaction i is reversible, 1 if it's irreversible) (the size of the vector is r, the number of reactions)
% The consistency of the sizes are not tested

% This function calculates the EFV of the given structure (Nv = 0, vi>=0 if vi irreversible, Gv>=h )
% It returns a structure : efv.vectors contains the efv and efv.bounded contains a boolean vector (1 and 0) of "is this efv bounded ?"
function efv = constraintsToEFV(N,Iirrev,G,h)
	net = constraintsToPseudoEFMMatrix(N,Iirrev,G,h);
	net = metatool(net);
	efm = net.sub' * net.rd_ems;
	[m,r] = size(N);
	efv = extractEFV(efm,r);
end
