function obj = process(obj)

 obj = init(obj) ;
 obj = ctrendlogs3(obj)  ;  % edited for single log
 obj = segment_log(obj)  ; 

if isempty(obj.Algorithm)
obj.Algorithm = "inverse-distance" ;
end

if strcmp(obj.Algorithm,"inverse-distance" )
obj = inverse_distance(obj)  ;
else
obj = krigging(obj)          ;
end

 obj = save_interp_mod(obj)   ;
 obj = applyfilter(obj)       ;
 obj = save_mod(obj)          ;


end