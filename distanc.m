function [distance] = distanc(loc,wellcoord,bin)
% function to calculation distance at arbitrary location (inline,crossline)
% [distance] = distanc(loc,wellcoord,bin)


inline = loc(1) ;
 xline = loc(2) ;
 
 [nwells] = size(wellcoord,1) ;
 distance  = zeros(nwells,1) ;
 
 for i  = 1:nwells
     distance(i) = sqrt(((inline - wellcoord(i,1))*bin(1))^2 + ((xline - wellcoord(i,2))*bin(2))^2) ;
 end