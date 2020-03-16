function obj = segment_log(obj)

          obj = horzextr(obj) ;
  obj.logzone = recoordzone(obj.logzone,obj.dt) ;




end