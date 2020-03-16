
function obj= ctrendlogs3(obj) 

% function to compute the compaction trend and elastic logs 
% Hampson-Russell Strata program (Low frequency model-building)
% [newlogs,time] = ctrendlogs(logs,time) 
% time(vector) is total time interval to be padded 
% modified to add the velocity of young sediments at the surface

disp ('---needs debugging---')
disp('modify the paramester  estimation  with genetic algorithm') 

[nwells,nlogs] = size(obj.LOGS)      ;
     



%% ESTIMATE COMPACTION PARAMETERS
global z
z   =  cell2mat(obj.LOGS(:,1)) ;
dat  = cell2mat(obj.LOGS(:,2)) ;


a = 1.0000e-10   ;     b = 1.0000e-10   ;
c = 1.0000e-10   ;     d = 1.0000e-10    ;  e = 1.0000e-10 ;
 


 initpar = [a b c d] ;
    scal = 0.001   ;
if strcmp(obj.wlog,'Vp')
 objfun = @compactntrendvp; 
      lb = [0 0 0 0 ]     ;    
      ub = [300 0.0006]   ;
    data = dat/scal ;
elseif strcmp(obj.wlog,'Vs')
 objfun =  @compactntrendvs3; 
     lb = [0 0 0 0 ] ;      
     ub = [0.005 0.001 0.9 0.002]      ;
      initpar = [a b c d e] ;
  data = dat/scal ;
elseif strcmp(obj.wlog,'Rhob')
    objfun =@compactntrendrho; 
      lb =  [0 0 0 0 ]  ;     
      ub = [1 0.00012] ;
      data = dat ;
else
    error('not yet coded for other lognames')
end

      tol = 0.0001 ;

options = optimset('Display', 'off','TolFun',tol,'Largescale','off',...
                'Algorithm', 'trust-region-reflective') ;
         
           
[mod]  = lsqnonlin(objfun,initpar,lb,ub,options,data)  ;



%% CALCULATING UPPER AND LOWER ZONES WITH FIT PARAMETERS

   for i  = 1:nwells
      
upper = [min(obj.tseis):obj.dt:min(obj.LOGS{i,1})-obj.dt] ;
           z = upper ;

           if strcmp(obj.wlog,'Vp')
upperzone_data  = fcompactntrend(mod)   ; 
           elseif strcmp(obj.wlog,'Vs')
upperzone_data  = fcompactntrendvs3(mod)*scal   ; 
       elseif strcmp(obj.wlog,'Rhob')
upperzone_data = fcompactntrendrho(mod)         ; 
           else
error('not yet coded for other lognames')               
           end
           
 
lower = [max(obj.LOGS{i,1})+obj.dt:obj.dt:max(obj.tseis)] ;
           z = lower ;
          
      if strcmp(obj.wlog,'Vp')
lowerzone_data  = fcompactntrend(mod)  ; 
     elseif strcmp(obj.wlog,'Vs')
lowerzone_data = fcompactntrendvs3(mod)*scal  ; 
      elseif strcmp(obj.wlog,'Rhob')
lowerzone_data = fcompactntrendrho(mod)       ;  
      else
 error('not yet coded for other lognames')     
      end
          
data_out  =  [upperzone_data' ; obj.LOGS{i,2}  ; lowerzone_data']   ;

obj.logs{i,1} = obj.tseis ;
obj.logs{i,2} = data_out   ;


   end


%% RECONSTRUCTING LOGS
% ns = length(vp1) ;
% trt = hanning(ns);
% vp1 = trt.*vp1 ;
% vs1 = trt.*vs1 ;
% rho1 = trt.*rho1 ;


% vp  =  [upperzoneVP' ; vp1  ; lowerzoneVP']  ;
% vs  =  [upperzoneVS' ; vs1  ; lowerzoneVS']  ;
% rho =  [upperzoneRHO'; rho1 ; lowerzoneRHO'] ;


 %% TESTING
% z = obj.tseis ;
% vp = fcompactntrendvp(modvp)   ;
% vs = fcompactntrendvs(modvs)   ;
% rho = fcompactntrendrho(modrho) * nn  ;

%% IMPLEMEMENTATION
% better result if the trend is initially filtered before the scalars (nn &
% scal ) are manipulated !

% I feel the velocity should not go to zero..
% velocity of young sediments (mean velocitVP==2730m/s, VS =1370m/s) Rock
% Physics Handbook


% BUG - too much data if tseis is less than log obj.tseis

end