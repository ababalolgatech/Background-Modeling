function [obj] = model_preallocate(obj) 

  disp('modelel preallocation started')
  
         nsamp = length(obj.tseis) ;
       ntraces = nsamp*obj.nCDP ;
       
       if ntraces > 1e9
       
           obj.tmin = fix(min(obj.hor{1}(:,3)));
           obj.tmax = fix(max(obj.hor{obj.nhor}(:,3)));
          obj.tseis = [obj.tmin : obj.dt :obj.tmax]';       
  
      obj.modelel = zeros(obj.nCDP,length(obj.tseis))  ;     
      disp('***************************')
      disp('modelel preallocation done')
    
       else
       obj.model = zeros(obj.nCDP,length(obj.tseis))  ; 
  
      disp('***************************')
      disp('modelel preallocation done')
    
       end
    
    



end