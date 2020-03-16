function [obj] = loadwells(obj)
% [obj.LOGS] = loadwellStruct(obj.wellfiles,nobj.LOGS, type)
% function to :
% Type : Elastic : vp, vs rho
% Type Acoustic : vp, vs
% Type RP  : vp , vs, por, vsh,sw


obj.LOGS = cell(obj.nwells ,obj.nlogs) ;

for i = 1: obj.nwells 
    tmp_in = obj.Wells.well(i).(obj.wlog) ;
   time_in = obj.Wells.well(i).time       ;
  [tmp_out,tcord] = dataresamp2 (tmp_in,time_in,obj.old_dt,obj.dt)   ;
        obj.LOGS{i,1} = tcord    ;
        obj.LOGS{i,2} = tmp_out  ;



end

  obj = cleanLOGS(obj) ; % removes the Nan values

end
