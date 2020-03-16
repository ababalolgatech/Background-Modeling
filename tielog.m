function [vp,vs,rho,tout] =  tielog(vp1,vs1,rho1,dt,tindex)
% function to stretch and squeeze logs 
% [vp,vs,rho,tout] =  tielog(vp1,vs1,rho1,dt,tindex)
% did not work well with linearly varying data (compaction trend)
% works well with logs

ns_in  = length(vp1) ;
ns_out = abs(tindex(1) - tindex(2))+1  ; 
if ns_in>ns_out
    ns_out = abs(tindex(1) - tindex(2)) ; 
end

t1 = (1: ns_in)*dt  ;
t2 = (1: ns_out)*dt ;

zonein  = [1 max(t1)] ;
zoneout = [1 max(t2)] ;



    [vp,tout]  =  stretchlog(vp1,t1,zonein,zoneout)   ;
           vs  =  stretchlog(vs1,t1,zonein,zoneout)   ;
           rho =  stretchlog(rho1,t1,zonein,zoneout)  ;


end
