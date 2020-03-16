function  [coord_bin,coord_XY] = gen_coordinates (obj)
% [coord_bin,coord_XY] = gen_coordinates (obj)

if isempty(obj.nGrid)
    nGrid = obj.Grid ;
else
    nGrid = obj.nGrid ;
end


IL = [nGrid(1,1):obj.dlines:nGrid(1,2)]'     ;
XL = [nGrid(2,1):obj.dtraces:nGrid(2,2)]'    ;

if (obj.GEOM(1,2) - obj.GEOM(1,1)) > 1
X = [obj.GEOM(1,1): obj.bin(1)  : obj.GEOM(1,2)]' ;
else
X = [obj.GEOM(1,2): -obj.bin(1)  : obj.GEOM(1,1)]' ;
end

if (obj.GEOM(2,2) - obj.GEOM(2,1)) > 1
Y = [obj.GEOM(2,1): obj.bin(2) : obj.GEOM(2,2)]' ;
else
Y = [obj.GEOM(2,2): obj.bin(2) : obj.GEOM(2,1)]' ;
Y = flip(Y) ;
end


 nLines = length(IL)   ;     
nTraces = length(XL)   ;
     ns = nTraces*nLines    ;

coord_bin = zeros(ns,2)  ;
coord_XY = zeros(ns,2)   ;
k = 0 ;
for i  = 1 :nLines    
   inL = repmat(IL(i),nTraces,1) ;
   inX = repmat(X(i),nTraces,1)  ;

coord_bin((k*nTraces+(1:nTraces)),:) =  [inL XL]  ; 
coord_XY((k*nTraces+(1:nTraces)),:)  =  [inX Y]   ; 
    k = k+1 ;
end
end