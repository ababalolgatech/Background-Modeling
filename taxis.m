function [tindex]  = taxis(tseis,hor)

% function to extract horizon amplitude index
% [tindex]  = taxis(tseis,hor)


  nhor = size(hor,1) ;

   hor = fix(hor)      ;
tindex = zeros(nhor,1) ;
for i = 1: nhor
  tindex(i) = find(tseis==hor(i)) ;    
end

end