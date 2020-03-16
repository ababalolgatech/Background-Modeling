function [tempdata] = gendata(newlogs,tindex,nr)
% [tempdata] = gendata(newlogs,tindex,nr)

nwells = size(newlogs,1) ;
iter = abs(tindex(1) - tindex(2))+1 ;

  for nn = 1: nwells
       indx(nn,:) = round(linspace(1,nr(nn),iter)) ;   % creating indexing for each data point
  end
    tempdata = zeros(iter,3,nwells) ;
   
    for iii = 1:iter
       for ii = 1:3
            for i = 1:nwells
     tempdata(iii,ii,i) = newlogs{i,ii+1}(indx(i,iii)) ;   % extract data from vp,vs,rho at indx
            end       
        
        end 



    end
end