function [data] = invdist2(dat,loc,wellcoord,bin)

% Inverse distance weighting
% [data] = invdist(dat,loc,wellcoord,bin)

nwells = size(wellcoord,1) ;
w = zeros(nwells,1) ;
[distance] = distanc(loc,wellcoord,bin) ;

%% CALCULATING WEIGHT

for i = 1:nwells
    w(i) = distance(i)^-2/sum ((distance).^-2 ) ;
end

[ns,nlog,nwells] = size(dat)   ;
data = zeros(ns,nlog) ;
for ii = 1:nwells
    for i = 1:nlog
    data(:,i) = data(:,i) +(w(ii)*dat(:,i,ii)) ;
    end
end



end