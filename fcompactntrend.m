function  [mod] = fcompactntrend(x) 
global z
% forward model compaction trend
% [residual] = compactntrend(x,data) 
% x is a column vector of (a,b,c,d) coeffiecients

%% START FUNCTION
 global  vsyoung  vpyoung 
  vpyoung  = 1500 ;
    a = x(1)   ;      b = x(2)   ;
    c = x(3)   ;      d = x(4)   ;
    
 mod = vpyoung + a.*exp(b.*z) + c.*exp(d.*z) ;
  %mod =  vpyoung  + (a.*exp(b.*z))  ;

    %% The basic theoretical idea is to assume VP = F(Effective Pressure)
% It follows an exponential trend line with an symptote at high pressure(Macbeth)

end
