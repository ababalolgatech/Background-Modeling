function  obj = applyfilter(obj) 

for i  = 1 :obj.nCDP
        tindex  = [obj.HorIndx(i,1) obj.HorIndx(i,obj.nhor)]  ;
        temp = obj.model(i,tindex(1):tindex(2))  ;
      
        data = filtering_model(temp,obj.bkmodfreq,obj.dt) ;
        clear temp
        obj.model(i,tindex(1):tindex(2)) = data  ;

        clear datas
progressing(i,obj.nCDP) ;
    

end  
    
function [data] = filtering_model(dat,bkmodfreq,dt)
% function to filter the background model
% [data] = filtering_model(dat,bkmodfreq,dt)

%% MOVING-AVERAGE FILTER RUNS FASTER AND IS SMOOTHER
   
         try
     data = Filt(dat,bkmodfreq,dt) ;
         catch ME
  disp('Bug  detected')
  disp('---------------------------------------------------')
  disp(ME.message);
  disp('---------------------------------------------------')
    [nr,nc] = size(dat) ;
       data = zeros(nr,nc) ;
         end
         
       


