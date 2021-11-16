%% Function Description
close all
clear all


%% Load Wet Dry Line
F=fopen('C:\CoastSnap\CoastSnap_NonGuiWorkflow-master\CoastSnap_NonGuiWorkflow-master\X_Analysis\wetdrylinelook\20210623_jennettes_highwater3.txt');
 A=textscan(F,'%f%f%f%f%s','delimiter','\t');

 wd.e=A{2};
 wd.n=A{3};
 wd.z=A{4};
 

%% Load Image (before survey)
I=imread('C:\CoastSnap\CoastSnap_NonGuiWorkflow-master\CoastSnap_NonGuiWorkflow-master\X_JennettesExampleData\ObliqueImagery\1624482780.Wed.Jun.23_16_13_00.EST.2021.jennettes.snap.anonymous.jpg');
f1=figure;
imshow((adapthisteq(rgb2gray(I))))
title('Before Survey: Using 4 GCPs, Fixed EO, Float PP, Fx')
title('Before Survey: Using 4 GCPs, Fixed xyz, Float pose, Fx Using Tide (-.46m)')


%% Reproject Survey Lines Onto Image

% Load IOEO
load('C:\CoastSnap\CoastSnap_NonGuiWorkflow-master\CoastSnap_NonGuiWorkflow-master\X_JennettesExampleData\IOEO_walked_shorelines\20210623_IOEO')

xyzCheck = [wd.e wd.n  wd.z];  % N x 3 matrix with rows= N pts, columns= x,y,z
% Transform xyz World Coordinates to Distorted Image Coordinates
[UVdReproj ] = xyz2DistUV(IOEO,xyzCheck);
%  Reshape UVdCheck so easier to interpret
UVdReproj = reshape(UVdReproj ,[],2);

% Plot
hold on
plot(UVdReproj(:,1),UVdReproj(:,2),'b','linewidth',2)


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
xyzCheck = [wd.e wd.n  wd.z.*0+(-0.29)];  % N x 3 matrix with rows= N pts, columns= x,y,z
% Transform xyz World Coordinates to Distorted Image Coordinates
[UVdReproj ] = xyz2DistUV(IOEO,xyzCheck);
%  Reshape UVdCheck so easier to interpret
UVdReproj = reshape(UVdReproj ,[],2);

% Plot
hold on
plot(UVdReproj(:,1),UVdReproj(:,2),'c','linewidth',2)


%% Processing Using NOAA Predicted
xyzCheck = [wd.e wd.n  wd.z.*0+0.03];  % N x 3 matrix with rows= N pts, columns= x,y,z
% Transform xyz World Coordinates to Distorted Image Coordinates
[UVdReproj ] = xyz2DistUV(IOEO,xyzCheck);
%  Reshape UVdCheck so easier to interpret
UVdReproj = reshape(UVdReproj ,[],2);

% Plot
hold on
plot(UVdReproj(:,1),UVdReproj(:,2),'r','linewidth',2)

%% Processing Using NOAA Measured
xyzCheck = [wd.e wd.n  wd.z.*0+(0.029)];  % N x 3 matrix with rows= N pts, columns= x,y,z
% Transform xyz World Coordinates to Distorted Image Coordinates
[UVdReproj ] = xyz2DistUV(IOEO,xyzCheck);
%  Reshape UVdCheck so easier to interpret
UVdReproj = reshape(UVdReproj ,[],2);

% Plot
hold on
plot(UVdReproj(:,1),UVdReproj(:,2),'g','linewidth',2)

%% Processing Using Buoy Runup
xyzCheck = [wd.e wd.n  wd.z.*0+(1.145)];  % N x 3 matrix with rows= N pts, columns= x,y,z
% Transform xyz World Coordinates to Distorted Image Coordinates
[UVdReproj ] = xyz2DistUV(IOEO,xyzCheck);
%  Reshape UVdCheck so easier to interpret
UVdReproj = reshape(UVdReproj ,[],2);

% Plot
hold on
plot(UVdReproj(:,1),UVdReproj(:,2),'b','linewidth',2)

return
