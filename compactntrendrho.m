function  [residual] = compactntrendrho(x,data) 
global z
% objective function compaction trend
% [residual] = compactntrend(x,data) 
% x is a column vector of (a,b,c,d) coeffiecients

%% START FUNCTION
   global  vsyoung  vpyoung water 
minden  = min(data) ;    % edit to include nan data
    a = x(1)   ;      b = x(2)   ;
   % c = x(3)   ;      d = x(4)   ;
   water = 1.8 ;
    
    % mod = water +  a.*exp(b.*z) + c.*exp(d.*z) ;

     mod =   water + a.*exp(b.*z)  ;
   % mod = water+ a.*(b.*z)  ;
   residual = data - mod ;

end
