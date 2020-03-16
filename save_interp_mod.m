
function  obj = save_interp_mod(obj)       

%% SAVING INTERPOLATED LOGS

if isempty(obj.coordName) 
 [coord_bin,coord_XY]  = gen_coordinates(obj) ;
  BKModelcoord.Lines = coord_bin(:,1)  ;
 BKModelcoord.Traces = coord_bin(:,2) ;
 BKModelcoord.X = coord_XY(:,1)  ;
 BKModelcoord.Y = coord_XY(:,2)  ;
else
S = load(obj.coordName) ;
 fd = fieldnames(S) ;
 
 BKModelcoord = S.(fd{1}) ;

end
 BKModelcoord.HorIndx = obj.HorIndx;
 BKModelcoord.corr_indx = obj.corr_indx ;
 BKModelcoord.nLines = obj.nLines ;
 BKModelcoord.nTraces =obj.nTraces ;
 BKModelcoord.GEOM = obj.GEOM ;
 BKModelcoord.Grid  = obj.Grid;
 BKModelcoord.bin = obj.bin;
 BKModelcoord.dt = obj.dt ;
 BKModelcoord.tmin = obj.tmax ;
 BKModelcoord.wellfiles = obj.wellfiles ;
 BKModelcoord.wellcoord = obj.wellcoord ;
 BKModelcoord.dlines =  obj.dlines ;
 BKModelcoord.dtraces = obj.dtraces ;

if strcmp(obj.wlog,'Vp')
 VPinterp = obj.model   ; save('.\Model Building2\VPinterp','VPinterp', '-v7.3') ; 
elseif  strcmp(obj.wlog,'Rhob')
RHOinterp = obj.model  ; save('.\Model Building2\RHOinterp','RHOinterp', '-v7.3');
elseif  strcmp(obj.wlog,'Vs')
 VSinterp = obj.model   ; save('.\Model Building2\VSinterp','VSinterp', '-v7.3')  ;
else
error('not yet coded for other lognames')    
end




save ('.\Model Building2\BKModelcoord','BKModelcoord' )
disp("Interpolated models saved")
disp("To do : Be able to save coordinate names from coordName property")

end