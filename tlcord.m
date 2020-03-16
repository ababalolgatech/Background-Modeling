function [tcord,vp,vs,rho] = tlcord(time,dt,vp1,vs1,rho1) 
% [tcord,vp,vs,rho] = tlcord(time,dt,vp1,vs1,rho1) 
% function to recoordinate log sampling with seismic
% should be aapplied prior to resampling with seismic sampling rate 

minT = min(time)             ;
maxT = max(time)             ;

num1 =  minT +(dt-round((rem(minT,dt))))  ;
num2 =  maxT - round((rem(maxT,dt)))      ;

t1 = find(time==num1) ;
t2 = find(time==num2) ;

vp = vp1(t1:t2)      ;          vs = vs1(t1:t2)      ;
rho = rho1(t1:t2)    ;          tcord = time(t1:t2)     ;

end

