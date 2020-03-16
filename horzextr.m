function [obj] = horzextr(obj)
% function moves to well coordinates
% extract horizon top and base time samples
% this is required later to extract data from well-logs
% [data] = horzextr(wellcoord,hor,Grid)


    data = zeros (obj.nwells,obj.nhor)  ;
  
   for ii = 1 : obj.nwells
    [indx(ii)] = coordextr(obj,ii) ;
        for i  = 1:obj.nhor
          temp = obj.hor{i}(:,3)    ;
    data(ii,i) = temp(indx(ii)) ;  
        end
   end
   
   obj.logzone = data ;
end