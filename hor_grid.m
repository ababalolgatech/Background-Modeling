function [obj] = hor_grid(obj)

% [horz] = hor_grid(hor,ntrc)
% forcing horizon to have thesame grid size

[nr, nc] = size(obj.hor)  ;
obj.horz = cell(nr,nc)    ;

for i  = 1:nr 
    
   obj.horz{i} = obj.hor{i}(1:ntrc,:) ;
    
end



end