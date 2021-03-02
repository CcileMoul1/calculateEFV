% For every j (from 1 to the number of colums) and i (from 1 to r) efv(i,j) = efm(i,j) if efm(m,j) = 0 and efv(i,j) = efm(i,j)/efm(m,j) if not. (m is the number of lines)

% Extract the efv from the efm where r is the number of reactions
% It returns a structure : efv.vectors contains the efv and efv.bounded contains a boolean vector (1 and 0) of "is this efv bounded ?" (is lambda different from 0 ?")
function efv = extractEFV(efm,r)
	vectors = efm(1:r,:);
	lambda = efm(end,:);
	
	% bounded and division by lambda
	bounded = lambda ~= 0;
	lambda(lambda==0)=1;
	vectors = vectors./lambda;
	
	efv.vectors = vectors;
	efv.bounded = bounded;
end
