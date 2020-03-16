function [obj] = variomod(obj)
% [vstruct,xy,z] = variomod(newlogs,wellcoord, Nzones)

v2struct(geoparams) ;  % extracting geometry ,bin and Grid information
[nl, nw] = cellfun(@size,newlogs) ;
    ndat = nl(:,1)                ;
[nwells,nlogs] = size(newlogs)   ;
     
  Tindex = round(linspace(1,ndat(1),Nzones+1)) ;
   
   for j  = 1:nwells
       for n = 1 : nlogs
           for i = 1:Nzones
                  indx = [Tindex(i):Tindex(i+1)] ;
               temp(i) = mean(newlogs{j,n}(indx)) ;   %extract elements at each zones and find avg                                                      
           end           
           newLog{j,n} = temp ;
       end
   end

   %% PREPING DATA FOR VARIOGRAM MODELING
   for ii = 1:nlogs
       for k = 1:nwells
               data{k,1} = newLog{k,ii} ;
       end
           data = cell2mat(data) ;
      for i = 1:Nzones
           z(:,i,ii) = data(:,i) ;
      end
      clear data
   end
   
%   [XX,YY] = findloc(GEOM,bin,Grid,rotation,dlines,dtraces,xy(:,1),xy(:,2)) ;
  for ii  = 2:nlogs
      for i = 1:Nzones
          [garr,hc,hangc,gamma,h] = semivar_exp(xy,z(:,i,ii)) ;
          
         [dum,dum,dum,data{i,ii-1}] = variogramfit(h,gamma,[],[],[],'model','spherical','plotit', false);
      end
  end
          
    
    
end
