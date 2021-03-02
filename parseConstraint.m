% Translate the constraints expressed in the file constraint into a matrix G (n*r) and a vector h (n*1) (n the number of constraints, r the number of reactions). The constraints are expressed in the way Gv>=h.
% names is the vector of the reactions'names.
function [G,h] = parseConstraint(constraint, names)
	[fid, msg] = fopen(constraint, 'r');
	if fid == -1
		disp(['Error opening file ', constraint]);
	 	disp(msg);
	  	return;
	end
	G = [];
	h = [];
	while feof(fid) == 0
		line = fgetl(fid);
		[gi,hi] = parseLine(line,names);
		G = [G;gi];
		h = [h;hi];
	end
	fclose(fid);
	
	function [gi, hi] = parseLine(line,names)
		n = length(names);
		gi = [];
		hi = [];
		pattern = '[>=<]+';
		[startIndex,endIndex] = regexp(line,pattern);
		symbol = line(startIndex:endIndex);
		cut = strsplit(line,symbol);
		before = cut{1};
		after = cut{2};
		
		vectorBefore = charToVect(before,names);
		vectorAfter = charToVect(after,names);
		if contains(symbol,'>')
			[gi,hi] = sortVects(vectorBefore,vectorAfter);
		elseif contains(symbol,'<')
			[gi,hi] = sortVects(vectorAfter, vectorBefore);
		else
			[gi1,hi1] = sortVects(vectorBefore,vectorAfter);
			[gi2,hi2] = sortVects(vectorAfter, vectorBefore);
			gi = [gi1;gi2];
			hi = [hi1;hi2];
		end
		
		function vect = charToVect(str,cel)
			rplus = length(cel)+1;
			vect = zeros(1,rplus);
			str = strtrim(strrep(str,'+',''));
			cut = strsplit(str);
			n = length(cut);
			for i =1:n
				term = cut{i};
				cut2 = strsplit(term,'.');
				coef = 1;
				name = term;
				if length(cut2)==2
					coef = str2num(cut2{1});
					name = cut2{2};
				end
				index = find(strcmp(cel,name));
				if isempty(index)
					coef = str2num(term);
					index = rplus;
				end
				vect(index)= vect(index) + coef;
			end
		end
		
		function [g,h] = sortVects(vect1,vect2)
			rplus = length(vect1);
			n = rplus-1;
			vect = vect1 - vect2;
			g = vect(1:n);
			h = -vect(rplus);
			
		end
	end
end
