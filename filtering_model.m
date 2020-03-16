function [data] = filtering_model(dat,bkmodfreq,dt)
% function to filter the background model
% [data] = filtering_model(dat,bkmodfreq,dt)



     
  
% Fs = 1000/(2*dt);
% Fnorm = bkmodfreq/(Fs) ;           % Normalized frequency
% df = designfilt('lowpassfir','FilterOrder',70,'CutoffFrequency',Fnorm);

%  for i  = 1: 3
%   [data(:,i)] = filtfilt(df,dat(:,i)) ;
% end

%% MOVING-AVERAGE FILTER RUNS FASTER AND IS SMOOTHER
 for i  = 1: 3
  [data(:,i)] = Filt(dat(:,i),bkmodfreq,dt) ;
 end

end