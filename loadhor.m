function [obj] = loadhor(obj,options)

% function to load horizons and arrange in a cell array
% [hor] = loadhor2(datafiles,options)
% temporray solution... please modify later
% options  - pristine or modify (to account for negative thickness with a
% const
% horizon time sampling has also be recoordinated with seismic time (recoordzone)

if nargin < 2
    options  = 'pristine' ;
end

%% MAKING SURE THAT TOTAL THICKNESS IS MORE THAN FILTER LENGTH
  Period = round( 1000/obj.bkmodfreq) ;
      FL = round(Period/obj.dt)  ; 

nhor = length(obj.horfiles) ;
horz = cell (nhor,1)   ;
horm = cell (nhor,1)   ;

for i = 1: nhor
            m =  load(obj.horfiles{i})  ; % struct 
        Sname = fieldnames(m) ;
         temp = [m.(Sname{:}).Inline m.(Sname{:}).Crossline m.(Sname{:}).time] ;
    horz{i,:} = temp ;
              
end
[nrm,ncm] = cellfun(@size,horz) ;
ns = nrm(1) ;

horm = horz ;

for ii = 1:ns
    for i  = 1: nhor-1
        temp = horm{i+1}(ii,3) - horm{i}(ii,3) ;
        if  temp < (FL*obj.dt)           
 horm{i+1}(ii,3) =  horm{i+1}(ii,3)  + (FL*obj.dt)+1 ;
        end
    end
end

    if strcmp(options,'pristine')
        hor = horz ;
    elseif strcmp(options,'modify')
        hor = horm ; 
    end
    
    %% recoordinating with seismic time sampling
   for i = 1:nhor
       temp  = hor{i}(:,3) ;
       temp = recoordzone(temp,obj.dt)  ;
       hor{i}(:,3)  = temp;
   end
      
   obj.hor = hor;
end