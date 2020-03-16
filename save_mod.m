function obj = save_mod(obj)      


HorIndx = obj.HorIndx ; save('.\Model Building2\HorIndx','HorIndx'); 
newlogs = obj.newlogs ; save('.\Model Building2\newlogs','newlogs');
    hor = obj.hor     ; save('.\Model Building2\hor','hor')  ;
   logs = obj.logs    ; save('.\Model Building2\logs','logs');
 
if strcmp(obj.wlog,'Vp')  
VPmod = obj.model   ; save('.\Model Building2\VPmod','VPmod', '-v7.3')  ;
Vp_ED_logs = obj.LOGS ; save('.\Model Building2\Vp_ED_logs','Vp_ED_logs'); 
elseif  strcmp(obj.wlog,'Vs')
VSmod = obj.model   ; save('.\Model Building2\VSmod','VSmod', '-v7.3')  ; 
Vs_ED_logs = obj.LOGS ;  save('.\Model Building2\Vs_ED_logs','Vs_ED_logs'); 
elseif  strcmp(obj.wlog,'Rhob')
 RHOmod = obj.model  ; save('.\Model Building2\RHOmod','RHOmod', '-v7.3'); 
 Rhob_ED_logs = obj.LOGS ;   save('.\Model Building2\Rhob_ED_logs','Rhob_ED_logs'); 

else
error('not yet coded for other lognames')    
end

 disp('***************************')

 geodata.horfiles = obj.horfiles ;
 geodata.wellfiles = obj.wellfiles ;
 geodata.HorIndx = obj.HorIndx ;

 geodata.hor = obj.hor ;
 geodata.wellxy = obj.wellxy ;  % empty for now 
 
 % if strcmp(obj.wlog,'Vp')  
 % geodata.Vplogs = obj.logs ;  
 % geodata.VpLOGS = obj.LOGS ;  
 % geodata.Vpnewlogs = obj.newlogs ;
 
 % elseif strcmp(obj.wlog,'Vs')  
 % geodata.Vslogs = obj.logs ;  
 % geodata.VsLOGS = obj.LOGS ;  
 % geodata.Vsnewlogs = obj.newlogs ;
 
 % elseif strcmp(obj.wlog,'Rhob') 
 % geodata.Rhoblogs = obj.logs ;  
 % geodata.RhobLOGS = obj.LOGS ;  
 % geodata.Rhobnewlogs = obj.newlogs ;
 
  % end
 
 % save('.\Model Building2\geodata','geodata', '-v7.3')  ;
 
  disp('Model Building done')
end