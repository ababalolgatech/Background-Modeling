function  [mod] = fcompactntrendvs3(x) 
global z
% objective function compaction trend
% [residual] = compactntrend(x,data) 
% x is a column vector of (a,b,c,d) coeffiecients

%% START FUNCTION
 global  vsyoung  vpyoung 
   vsyoung  =  1000  ;
    a = x(1)   ;      b = x(2)   ;
    c = x(3)   ;      d = x(4)   ;  e = x(5) ;
    
    mod = vsyoung + a.*exp(b.*z) + c.*exp(d.*z) + e*z ;

  

end