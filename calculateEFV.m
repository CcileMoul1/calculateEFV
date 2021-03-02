% This function calculates the EFV of the model composed of the network described in network and the constraints described in constraint
% network is a "Metatool" file
% constraint is a file as describe in describe_constraint.txt
% efv is a structure. efv.vectors contains the efv and efv.bounded contains a boolean vector (1 and 0) of "is this efv bounded ?"
function efv = calculateEFV(network, constraint)
	net = parse(network);
	N = net.st;
	Iirrev = net.irrev_react;
	names = net.react_name;
	[G,h] = parseConstraint(constraint, names);
	efv = constraintsToEFV(N,Iirrev,G,h);
end
