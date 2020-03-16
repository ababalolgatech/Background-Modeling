function [obj] = normlogs(obj)
% [logs] = normlogs(newlogs,dt)
% function to normalize well-logs to have theseame number of samples
% this function calls SRresamp

    [nw,nl] = size(obj.newlogs) ;
       logs = cell(nw,nl)       ;
 [nlogs, ~] = cellfun(@size,obj.newlogs) ;

     ndat = nlogs(:,1)     ;
   tindex = [1 max(ndat)]  ;

for i = 1:nw
  
   
 [logs{i,1},logs{i,1},logs{i,1}] = tielog(obj.newlogs{i,1},obj.newlogs{i,1},obj.newlogs{i,1}...
                                             ,obj.dt,tindex) ;
 [logs{i,2},logs{i,3},logs{i,4}] = tielog(obj.newlogs{i,2},obj.newlogs{i,3},obj.newlogs{i,4}...
                                             ,obj.dt,tindex) ;
       
end






end