function obj = krig(obj)

disp('****************')
disp('Layer Preallocation')

      k = 0 ;
 for ii = 1 : nhor-1
               for j = 1:nwells
     [newlogs{j,2},newlogs{j,3},newlogs{j,4},newlogs{j,1}] = seglog...
        (logzone(j,(1:2)+k),logs{j,1},logs{j,2},logs{j,3},logs{j,4}) ;
               end
      insetlog = newlogs ;
     [newlogs] = normlogs(newlogs,dt)  ;
         nwells = size(newlogs,1) ;
       [nr,nc]  = cellfun(@size,newlogs) ;
             nr = nr(:,1)     ;
                 
for mm = 1:ns          
               
      for n  = 1:2                           
       tindex (n)= taxis(tseis,hor{n+k}(mm,3)) ;   
      end
       HorIndx(mm,(1:2)+k)  = tindex ; 
       HorIndxZ(mm,:) = flip(round(linspace(tindex(2),tindex(1),Nzones+1)))    ;
       fprintf(sprintf('%s%%3d%%%%', repmat('\b', 1, 4)), round(mm/(ns)*100))  ;
end
 end

 
 
 
 [LVmodel,z] = variomod(newlogs,wellxy, Nzones,geoparams) ;

disp('****************')
disp('Kriging')
k = 0 ;

[X,Y] = findloc_all(geoparams,ns);
     for ii = 1:Nzones
        for i = 2:nlog
            r = num2str(LVmodel{ii,i-1}.range) ; sill = num2str(LVmodel{ii,i-1}.sill) ; 
           vv = char(strcat(eval('r'),{' '},'Sph(',eval('sill'),')')) ;
            V = deformat_variogram(vv) ;
%           [d_est_gstat,d_var_gstat]=gstat_krig(wellxy,z(:,ii,i),[X Y],V);
 %[temp(:,i-1),tempvar(:,i-1)]=krig(wellxy,z(:,ii,i),[X Y],V);
   [temp(:,i-1), tempvar(:,i-1)] = kriging(LVmodel{ii,i-1},wellxy(:,1),wellxy(:,2),z(:,ii,i),X,Y)   ; 
        end
         
                    Tindex = [HorIndxZ(:,ii) HorIndxZ(:,ii+1)]     ;
                    
                    for nn = 1:ns
                                              indx = Tindex(nn,:)     ;
                     VPmodelKrig(nn,indx(1):indx(2)) =  temp(nn,1)'     ;
                     VSmodelKrig(nn,indx(1):indx(2)) =  temp(nn,2)'     ;
                    RHOmodelKrig(nn,indx(1):indx(2)) =  temp(nn,3)'     ; 
                    
                    VPmodelvar(nn,indx(1):indx(2))  =  tempvar(nn,1)'   ;
                    VSmodelvar(nn,indx(1):indx(2))  =  tempvar(nn,2)'   ;
                    RHOmodelvar(nn,indx(1):indx(2)) =  tempvar(nn,3)'   ; 
                    end
     fprintf(sprintf('%s%%3d%%%%', repmat('\b', 1, 4)), round(ii/(Nzones)*100))  ;
        
     end
    

clear temp
end



function [zi,s2zi] = kriging(vstruct,x,y,z,xi,yi,chunksize)

% interpolation with ordinary kriging in two dimensions
%
% Syntax:
%
%     [zi,zivar] = kriging(vstruct,x,y,z,xi,yi)
%     [zi,zivar] = kriging(vstruct,x,y,z,xi,yi,chunksize)
%
% Description:
%
%     kriging uses ordinary kriging to interpolate a variable z measured at
%     locations with the coordinates x and y at unsampled locations xi, yi.
%     The function requires the variable vstruct that contains all
%     necessary information on the variogram. vstruct is the forth output
%     argument of the function variogramfit.
%
%     This is a rudimentary, but easy to use function to perform a simple
%     kriging interpolation. I call it rudimentary since it always includes
%     ALL observations to estimate values at unsampled locations. This may
%     not be necessary when sample locations are not within the
%     autocorrelation range but would require something like a k nearest
%     neighbor search algorithm or something similar. Thus, the algorithms
%     works best for relatively small numbers of observations (100-500).
%     For larger numbers of observations I recommend the use of GSTAT.
%
%     Note that kriging fails if there are two or more observations at one
%     location or very, very close to each other. This may cause that the 
%     system of equation is badly conditioned. Currently, I use the
%     pseudo-inverse (pinv) to come around this problem. If you have better
%     ideas, please let me know.
%
% Input arguments:
%
%     vstruct   structure array with variogram information as returned
%               variogramfit (forth output argument)
%     x,y       coordinates of observations
%     z         values of observations
%     xi,yi     coordinates of locations for predictions 
%     chunksize nr of elements in zi that are processed at one time.
%               The default is 100, but this depends largely on your 
%               available main memory and numel(x).
%
% Output arguments:
%
%     zi        kriging predictions
%     zivar     kriging variance
%
% Example:
%
%     % create random field with autocorrelation
%     [X,Y] = meshgrid(0:500);
%     Z = randn(size(X));
%     Z = imfilter(Z,fspecial('gaussian',[40 40],8));
%
%     % sample the field
%     n = 500;
%     x = rand(n,1)*500;
%     y = rand(n,1)*500;
%     z = interp2(X,Y,Z,x,y);
%
%     % plot the random field
%     subplot(2,2,1)
%     imagesc(X(1,:),Y(:,1),Z); axis image; axis xy
%     hold on
%     plot(x,y,'.k')
%     title('random field with sampling locations')
%
%     % calculate the sample variogram
%     v = variogram([x y],z,'plotit',false,'maxdist',100);
%     % and fit a spherical variogram
%     subplot(2,2,2)
%     [dum,dum,dum,vstruct] = variogramfit(v.distance,v.val,[],[],[],'model','stable');
%     title('variogram')
%
%     % now use the sampled locations in a kriging
%     [Zhat,Zvar] = kriging(vstruct,x,y,z,X,Y);
%     subplot(2,2,3)
%     imagesc(X(1,:),Y(:,1),Zhat); axis image; axis xy
%     title('kriging predictions')
%     subplot(2,2,4)
%     contour(X,Y,Zvar); axis image
%     title('kriging variance')
%
%
% see also: variogram, variogramfit, consolidator, pinv
%
% Date: 13. October, 2010
% Author: Wolfgang Schwanghart (w.schwanghart[at]unibas.ch)

% size of input arguments
sizest = size(xi);
numest = numel(xi);
numobs = numel(x);

% force column vectors
xi = xi(:);
yi = yi(:);
x  = x(:);
y  = y(:);
z  = z(:);

if nargin == 6;
    chunksize = 100;
elseif nargin == 7;
else
    error('wrong number of input arguments')
end

% check if the latest version of variogramfit is used
if ~isfield(vstruct, 'func')
    error('please download the latest version of variogramfit from the FEX')
end


% variogram function definitions
switch lower(vstruct.model)    
    case {'whittle' 'matern'}
        error('whittle and matern are not supported yet');
    case 'stable'
        stablealpha = vstruct.stablealpha; %#ok<NASGU> % will be used in an anonymous function
end


% distance matrix of locations with known values
Dx = hypot(bsxfun(@minus,x,x'),bsxfun(@minus,y,y'));

% if we have a bounded variogram model, it is convenient to set distances
% that are longer than the range to the range since from here on the
% variogram value remains the same and we don£t need composite functions.
switch vstruct.type;
    case 'bounded'
        Dx = min(Dx,vstruct.range);
    otherwise
end

% now calculate the matrix with variogram values 
A = vstruct.func([vstruct.range vstruct.sill],Dx);
if ~isempty(vstruct.nugget)
    A = A+vstruct.nugget;
end

% the matrix must be expanded by one line and one row to account for
% condition, that all weights must sum to one (lagrange multiplier)
A = [[A ones(numobs,1)];ones(1,numobs) 0];

% A is often very badly conditioned. Hence we use the Pseudo-Inverse for
% solving the equations
A = pinv(A);

% we also need to expand z
z  = [z;0];

% allocate the output zi
zi = nan(numest,1);

if nargout == 2;
    s2zi = nan(numest,1);
    krigvariance = true;
else
    krigvariance = false;
end

% parametrize engine
nrloops   = ceil(numest/chunksize);

% initialize the waitbar
%h  = waitbar(0,'Kr...kr...kriging');

% now loop 
for r = 1:nrloops;
    % waitbar 
  %  waitbar(r / nrloops,h);
    
    % built chunks
    if r<nrloops
        IX = (r-1)*chunksize +1 : r*chunksize;
    else
        IX = (r-1)*chunksize +1 : numest;
        chunksize = numel(IX);
    end
    
    % build b
    b = hypot(bsxfun(@minus,x,xi(IX)'),bsxfun(@minus,y,yi(IX)'));
    % again set maximum distances to the range
    switch vstruct.type
        case 'bounded'
            b = min(vstruct.range,b);
    end
    
    % expand b with ones
    b = [vstruct.func([vstruct.range vstruct.sill],b);ones(1,chunksize)];
    if ~isempty(vstruct.nugget)
        b = b+vstruct.nugget;
    end
    
    % solve system
    lambda = A*b;    % weights
    
    % estimate zi
    zi(IX)  = lambda'*z;
    
    % calculate kriging variance
    if krigvariance
        s2zi(IX) = sum(b.*lambda,1);
    end
    
end

% close waitbar
%close(h)

% reshape zi
zi = reshape(zi,sizest);

if krigvariance
    s2zi = reshape(s2zi,sizest);
end


%% bsxfun line calculates the dista and estimate variogram from model ... pin(A) - inverse of variogram for covariance
