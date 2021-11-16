%% Function Description
close all
clear all


%% Load Wet Dry Line
F=fopen('C:\CoastSnap\CoastSnap_NonGuiWorkflow-master\CoastSnap_NonGuiWorkflow-master\X_Analysis\wetdrylinelook\20210805_jennettes_highwater.txt');
 A=textscan(F,'%f%f%f%f%s','delimiter','\t');

 wd.e=A{2};
 wd.n=A{3};
 wd.z=A{4};
 

%% Load Image (before survey)
I=imread('C:\CoastSnap\CoastSnap_NonGuiWorkflow-master\CoastSnap_NonGuiWorkflow-master\X_JennettesExampleData\ObliqueImagery\1628198520.Thu.Aug.05_16_22_00.EST.2021.jennettes.snap.anonymous.jpg');
f1=figure;
imshow((adapthisteq(rgb2gray(I))))
title('Before Survey: Using 4 GCPs, Fixed EO, Float PP, Fx')
title('Before Survey: Using 4 GCPs, Fixed xyz, Float pose, Fx Using Tide (-.46m)')


%% Reproject Survey Lines Onto Image

% Load IOEO
load('C:\CoastSnap\CoastSnap_NonGuiWorkflow-master\CoastSnap_NonGuiWorkflow-master\X_JennettesExampleData\IOEO_walked_shorelines\20210805_IOEO')

xyzCheck = [wd.e wd.n  wd.z];  % N x 3 matrix with rows= N pts, columns= x,y,z
% Transform xyz World Coordinates to Distorted Image Coordinates
[UVdReproj ] = xyz2DistUV(IOEO,xyzCheck);
%  Reshape UVdCheck so easier to interpret
UVdReproj = reshape(UVdReproj ,[],2);

% Plot
hold on
plot(UVdReproj(:,1),UVdReproj(:,2),'y','linewidth',2)


%% Processing using gps elevation
xyzCheck = [wd.e wd.n  wd.z];  % N x 3 matrix with rows= N pts, columns= x,y,z
% Transform xyz World Coordinates to Distorted Image Coordinates
[UVdReproj ] = xyz2DistUV(IOEO,xyzCheck);

%  Reshape UVdCheck so easier to interpret
UVdReproj = reshape(UVdReproj ,[],2);

% Plot
hold on
plot(UVdReproj(:,1),UVdReproj(:,2),'m','linewidth',2)


%% Processing Using Water level
xyzCheck = [wd.e wd.n  wd.z.*0+0.013250825];  % N x 3 matrix with rows= N pts, columns= x,y,z
% Transform xyz World Coordinates to Distorted Image Coordinates
[UVdReproj ] = xyz2DistUV(IOEO,xyzCheck);
%  Reshape UVdCheck so easier to interpret
UVdReproj = reshape(UVdReproj ,[],2);

% Plot
hold on
plot(UVdReproj(:,1),UVdReproj(:,2),'c','linewidth',2)


%% Processing Using NOAA Predicted
xyzCheck = [wd.e wd.n  wd.z.*0+0.45];  % N x 3 matrix with rows= N pts, columns= x,y,z
% Transform xyz World Coordinates to Distorted Image Coordinates
[UVdReproj ] = xyz2DistUV(IOEO,xyzCheck);
%  Reshape UVdCheck so easier to interpret
UVdReproj = reshape(UVdReproj ,[],2);

% Plot
hold on
plot(UVdReproj(:,1),UVdReproj(:,2),'r','linewidth',2)

%% Processing Using NOAA Measured
xyzCheck = [wd.e wd.n  wd.z.*0+0.437];  % N x 3 matrix with rows= N pts, columns= x,y,z
% Transform xyz World Coordinates to Distorted Image Coordinates
[UVdReproj ] = xyz2DistUV(IOEO,xyzCheck);
%  Reshape UVdCheck so easier to interpret
UVdReproj = reshape(UVdReproj ,[],2);

% Plot
hold on
plot(UVdReproj(:,1),UVdReproj(:,2),'g','linewidth',2)


%% Processing Using Buoy Runup
xyzCheck = [wd.e wd.n  wd.z.*0+1.3198];  % N x 3 matrix with rows= N pts, columns= x,y,z
% Transform xyz World Coordinates to Distorted Image Coordinates
[UVdReproj ] = xyz2DistUV(IOEO,xyzCheck);
%  Reshape UVdCheck so easier to interpret
UVdReproj = reshape(UVdReproj ,[],2);

% Plot
hold on
plot(UVdReproj(:,1),UVdReproj(:,2),'b','linewidth',2)

return
%% Plot Survey Lines onto Rectified Image
Ir=imread('C:\Users\Brittany\Documents\GitHub\CoastSnap_NonGuiWorkflow\X_JennettesExampleData\Rectifications\GRID_coastSnapJennettes_NCSP_1mResolution\World\20210122_1400_World.png');
load('C:\Users\Brittany\Documents\GitHub\CoastSnap_NonGuiWorkflow\X_JennettesExampleData\Grids\GRID_coastSnapJennettes_NCSP_1mResolution.mat')
f2=figure;
imagesc(X(1,:),Y(1,:),flipud(Ir))
set(gca,'ydir','normal')
title('Before Survey: Using 4 GCPs, Fixed EO, Float PP, Fx Using Tide (-.46m)')

hold on
plot(wd.e,wd.n,'m','linewidth',2)

% Test Tide
In{1}=I;
IOEOn{1}=IOEO;
[Ir2]= imageRectifier(In,IOEOn,X,Y,Z+ 0.83,0);

f3=figure;
imagesc(X(1,:),Y(1,:),(Ir2))
set(gca,'ydir','normal')
title('Before Survey: Using 4 GCPs, Fixed EO, Float PP, Fx Using surfacelevation (.8m)')
hold on
plot(wd.e,wd.n,'m','linewidth',2)



return

%% Reproject Survey Lines Onto Image
I=imread('C:\Users\Brittany\Documents\GitHub\CoastSnap_NonGuiWorkflow\X_JennettesExampleData\ObliqueImagery\20210122_1600.png');
f1=figure;
imshow((adapthisteq(rgb2gray(I))))
title('After Survey: Using 4 GCPs, Fixed EO, Float PP, Fx')



% Load IOEO
load('C:\Users\Brittany\Documents\GitHub\CoastSnap_NonGuiWorkflow\X_JennettesExampleData\AdjustedIOEO\20210122_1600_UVd_IOEO.mat')


xyzCheck = [wd.e wd.n  wd.z];  % N x 3 matrix with rows= N pts, columns= x,y,z
% Transform xyz World Coordinates to Distorted Image Coordinates
[UVdReproj ] = xyz2DistUV(IOEO,xyzCheck);
%  Reshape UVdCheck so easier to interpret
UVdReproj = reshape(UVdReproj ,[],2);

% Plot
hold on
plot(UVdReproj(:,1),UVdReproj(:,2),'g','linewidth',2)


%% Plot Survey Lines onto Rectified Image
Ir=imread('C:\Users\Brittany\Documents\GitHub\CoastSnap_NonGuiWorkflow\X_JennettesExampleData\Rectifications\GRID_coastSnapJennettes_NCSP_1mResolution\World\20210122_1600_World.png');
load('C:\Users\Brittany\Documents\GitHub\CoastSnap_NonGuiWorkflow\X_JennettesExampleData\Grids\GRID_coastSnapJennettes_NCSP_1mResolution.mat')
f2=figure;
imagesc(X(1,:),Y(1,:),flipud(Ir))
set(gca,'ydir','normal')
title('After Survey: Using 4 GCPs, Fixed EO, Float PP, Fx Using Tide (-.33m)')
hold on
plot(wd.e,wd.n,'g','linewidth',2)

% Test Tide
In{1}=I;
IOEOn{1}=IOEO;
[Ir2]= imageRectifier(In,IOEOn,X,Y,Z+ 0.766012875536481,0);

f3=figure;
imagesc(X(1,:),Y(1,:),(Ir2))
set(gca,'ydir','normal')
title('After Survey: Using 4 GCPs, Fixed EO, Float PP, Fx Using surfacelevation (.76m)')
hold on
plot(wd.e,wd.n,'g','linewidth',2)

    