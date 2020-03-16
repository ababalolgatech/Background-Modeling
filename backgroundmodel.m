classdef backgroundmodel < seisgrid
   
    properties
    wellfiles, wellcoord,wellxy, newlogs, wells, nwells
	Wells = wellmanager ;
    wlog
	LOGS, logs,nlogs,logzone, nz
    horfiles, hor, nhor,horz,HorIndx,corr_indx
    coordName
    old_dt, dt, bkmodfreq, fdom,tseis,tmin,tmax  
   
  % GEOM,bin,Grid,nGrid,nLines,nTraces,dlines,dtraces,ntrc, rotation
  
   modinterp, model
   Algorithm
   type
   nCDP
  
    coordname 
   
   wellClass= welldata.empty  ;
   
   saving_dir ;
    end
   
   methods
   
   % function obj = bkmod(obj)  % default constructor
   % obj = inherit(obj) ;
   % end
  
  %function obj = bkmod(obj)
 % obj = obj@seisgrid ;
%   obj = inherit(obj) ;  
  %end
  
       % function obj = inherit(obj)
          % obj.wells = welldata ;
            % obj.hor = horizon  ;
       % end

       obj = init(obj)       ;  % do model pre-allocations and parameter settings
	   obj = checkparam(obj)        ;
       obj = loadhor(obj,options)   ;
       obj = hor_grid(obj)          ;
	   obj = reduce_grid(obj)       ;
       obj = loadwells(obj)         ;
	   obj = ctrendlogs3(obj)       ;
       obj = segment_log(obj)       ; % hor_extr, recoord_zone
	   obj = model_preallocate(obj) ;   
	   obj = horzextr(obj)          ;
	   obj = applyfilter(obj)       ;
	   obj = inverse_distance(obj)  ;
       obj = krigging(obj)          ;      
       obj = save_mod(obj)          ;
	   obj = save_interp_mod(obj)   ;	   
	   obj = process(obj)           ; % main function
[coord_bin,coord_XY] = gen_coordinates (obj)
       obj = cleanLOGS(obj) ; 
       
	   
	   % Base class functions
	   %---------------------
	   % to use a baseclass function , you need to reprototype it
	   function  [indx]  = coordextr(obj,ind)
	   indx = coordextr@seisgrid(obj,ind);
	   end
	   
	   function  obj = coordextr2(obj)
	   obj = coordextr2@seisgrid(obj);
	   end
	   
	   function  obj = findloc(obj)
	   obj = findloc@seisgrid(obj);
	   end
	   
	   function  obj = findXY(obj)
	   obj = findXY@seisgrid(obj);
	   end
	   
% 	   function  obj = hor_grid(obj)
% 	   obj = hor_grid@seisgrid(obj);
% 	   end
	   
	   function  obj = calc_coord(obj)
	   obj = calc_coord@seisgrid(obj);
	   end
	   
	   function  obj = calc_coordXY(obj)
	   obj = calc_coordXY@cseisgrid(obj);
	   end
	   
	   function  hor = reduce_grid_hor(obj,hor)
	   hor = reduce_grid_hor@seisgrid(obj,hor);
	   end
	   
	   function coord = gen_coord(grd)
	    coord = gen_coord@seisgrid(grd);
	   end
	   
   end
   
end