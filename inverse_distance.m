function obj = inverse_distance(obj) 


k = 0 ;


 for ii = 1 : obj.nhor-1
               for j = 1:obj.nwells
     [obj.newlogs{j,2},obj.newlogs{j,1}] = segment_log...
     (obj.logzone(j,(1:2)+k),obj.logs{j,1},obj.logs{j,2}) ;
               end
         insetlog = obj.newlogs    ;
      obj.newlogs = normalize_logs(obj.newlogs,obj.dt)  ;
          [nr,~]  = cellfun(@size,obj.newlogs)   ;
               nr = nr(:,1)        ;
          
for mm = 1:obj.nCDP             
               
      for n  = 1:2                           % extract top and base index using tseis at every CDP
       tindex (n)= taxis(obj.tseis,obj.hor{n+k}(mm,3)) ;   % deal with you later 
      end
       obj.HorIndx(mm,(1:2)+k)  = tindex - obj.corr_indx;    
       % I need this Index for Inversion
       % correction index added in case sart time is not zero
    %% inverse distance weighting
     [tempdata] = generate_data(obj.newlogs,tindex,nr) ;
         [data] = invdist2(tempdata,obj.hor{1}(mm,1:2),obj.wellcoord,obj.bin) ;  
       
        obj.model(mm,tindex(1):tindex(2)) = data' ;

      
      progressing(mm,obj.nCDP) ;
            

     
end
%% INVERSE DISTANCE FAILS AT WELL-LOCATION (reinserting the logs)
       for i  = 1 : obj.nwells        
      indx = coordextr(obj,i) ;
    tindex = obj.HorIndx(indx,(1:2)+k);
    obj.model(indx,tindex(1):tindex(2)) =  insetlog{i,2}'  ;

      end
     k=k+1 ;
 end
 
 
end
 
 
 
 
 
 
%------------------------------------------------------------------ 
 function [logs] = normalize_logs(newlogs,dt)
% [logs] = normlogs(newlogs,dt)
% function to normalize well-logs to have theseame number of samples
% this function calls SRresamp

    [nw,nl] = size(newlogs) ;
           logs = cell(nw,nl) ;
[nlogs, nwells] = cellfun(@size,newlogs) ;

   ndat = nlogs(:,1)      ;
   tindex =[1 max(ndat)]  ;

for i = 1:nw  
   
 [logs{i,1},~] = tie_log(newlogs{i,1},dt,tindex) ;
 [logs{i,2},~] = tie_log(newlogs{i,2},dt,tindex) ;


       
end
 end

%------------------------------------------------------------------
function [dat_out,tout] =  tie_log(dat_in,dt,tindex)
% function to stretch and squeeze logs 
% [vp,vs,rho,tout] =  tielog(vp1,vs1,rho1,dt,tindex)
% did not work well with linearly varying data (compaction trend)
% works well with logs

ns_in  = length(dat_in) ;
ns_out = abs(tindex(1) - tindex(2))+1  ; 
if ns_in>ns_out
    ns_out = abs(tindex(1) - tindex(2)) ; 
end

t1 = (1: ns_in)*dt  ;
t2 = (1: ns_out)*dt ;

zonein  = [1 max(t1)] ;
zoneout = [1 max(t2)] ;

    [dat_out,tout]  =  stretchlog(dat_in,t1,zonein,zoneout)   ;

end

%------------------------------------------------------------------
function [tempdata] = generate_data(newlogs,tindex,nr)
% [tempdata] = gendata(newlogs,tindex,nr)

nwells = size(newlogs,1) ;
iter = abs(tindex(1) - tindex(2))+1 ;

  for nn = 1: nwells
       indx(nn,:) = round(linspace(1,nr(nn),iter)) ;   % creating indexing for each data point
  end
    tempdata = zeros(iter,nwells) ;
   
    for ii = 1:iter
            for i = 1:nwells
     tempdata(ii,i) = newlogs{i,2}(indx(i,ii)) ;       % extract data from well-log at indx
            end       
    end       
  
end

%------------------------------------------------------------------
function [dat_out,z_out] = segment_log(zones,z_in,dat_in)

% function to segment logs 
% [dat_out,z_out] = segment_log(zones,z_in,dat_in)
zones = fix(zones)  ;
    aa = find(z_in==zones(1))  ;        bb = find(z_in==zones(2))        ; 
    
  if isempty(aa)     
  error('lower zone exceeded')      
  elseif isempty(bb)
  error('upper zone exceeded')
  end
  
  
    dat_out = dat_in(aa:bb)  ;          
      z_out = z_in(aa:bb)    ;
  
end