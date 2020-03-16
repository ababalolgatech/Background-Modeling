function obj = cleanLOGS(obj)

disp('.....need debugging....')   ;
LOGS = cell(obj.nwells,obj.nlogs) ;
for i = 1:obj.nwells
   [LOGS{i,1},LOGS{i,2}]  = remove_nan(obj.LOGS{i,1}, obj.LOGS{i,2}) ;
end
obj.LOGS = LOGS ;


end






 
function [time_out,data_out] = remove_nan(time_in, dat_in)



     ns = length(dat_in) ;
indx = [1:ns]' ;
indnan = isnan(dat_in) ;

tmp_ind = find(indnan==0) ;
indx1 = indx(tmp_ind) ; % where data is not nan
indx2 = indx(indnan)  ;



if ~any(indnan)
    time_out  = time_in ;
    data_out  = dat_in  ;
else
		min_zone = min(indx2) ; % sample below
		max_zone = max(indx2) ; % sample above
        
        if (max_zone < ns)  % if Nan are above the logs
            min_zone = max_zone+1 ;
            max_zone = ns ;
        elseif (max_zone == ns && min_zone ==1 ) % if Nan are between the logs
            min_zone = min(indx1);
            max_zone = max(indx1);
        else
             min_zone = min(indx1);
             max_zone = max(indx1);
        end

            time_out  = time_in(min_zone:max_zone) ;
            data_out  = dat_in(min_zone:max_zone)  ;
end


end