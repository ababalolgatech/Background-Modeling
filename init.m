 function obj = init(obj) 

if ~exist('Model Building2','dir') 
mkdir('Model Building2')

disp('creating ...Model Building2.... in the current directory')
end


  obj.nlogs = 2 ;
 obj.Wells.wellnames = obj.wellfiles ;
  obj.Wells.read;

  obj.nhor = length(obj.horfiles)    ;
obj.nwells = obj.Wells.nwells ;
obj.wellcoord = [obj.Wells.Inline obj.Wells.Crossline] ;

     obj.logs = cell(obj.nwells,obj.nlogs)  ;
  obj.newlogs = cell(obj.nwells,obj.nlogs)  ;
  
 obj = loadhor(obj)  ;
 obj = loadwells(obj);


      nCDP = size(obj.hor{1},1)          ;
  obj.ntrc = obj.nLines * obj.nTraces  ;

  
obj.tseis = [obj.tmin : obj.dt :obj.tmax]';

if (nCDP ~= obj.ntrc)
disp("No of traces in the seismic grid is unequal to horizon")

% reduceHor
else
obj.nCDP = nCDP ;
disp("add reduce horizon function here")
end


obj = model_preallocate(obj);  % tmin changes here because of pre-allocation

if obj.tmin == 0
    obj.corr_indx = 0 ;
else
    obj.corr_indx = fix(1/obj.dt*obj.tmin) ;
end


end