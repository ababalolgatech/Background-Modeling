function [tcord] = recoordzone(logzone,dt) 
% [tcord] = recoordzone(logzone,dt) 
% function to recoordinate logzone with seismic coordinates

[nwells,ncol] = size(logzone)   ;

tcord = zeros (nwells,ncol) ;

for ii = 1:nwells
  for i = 1:ncol

minT = round(logzone(ii,i))     ;
%maxT = round(logzone(ii,i))     ;
num1 =  minT -(rem(minT,dt))   ;
%num2 =  maxT - (rem(maxT,dt))  ;

tcord(ii,i) = num1 ;
  end
end

% find time to debug : might be losing samples

end
