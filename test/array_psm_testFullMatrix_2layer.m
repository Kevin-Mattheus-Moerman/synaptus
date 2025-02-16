% Note: The dataset used here is a full-matrix recording of a copper block
% with side-drilled holes immersed in water. This script is used to test
% the ability of the algorithm to work on multilayer structures.

%% Close / clear
close all
clearvars

%% Show test header (useful when run as part of test suite)
disp('-----------------------------------------------------------------')
disp('-----   SYNAPTUS TEST: array_psm_testFullMatrix_2layer.m    -----')
disp('-----          PSM algorithm adapted for arrays             -----')
disp('-----   Full matrix dataset from linear array, 2 layer      -----')
disp('-----------------------------------------------------------------')
disp('')
disp('NOTE: Loading data may generate warnings, including "no constructor".') 
disp('      These can be safely ignored.')
disp(' ')

%% Add path to necessary functions
toolboxPath=fileparts(fileparts(mfilename('fullpath'))); %Get the toolbox path

% Add core and misc path
addpath(fullfile(toolboxPath,'core'),fullfile(toolboxPath,'misc'));

%% Load test data
disp('Loading data')
load(fullfile(toolboxPath,'datasets','ArrayCuBlockStationary.mat'),'data','MWB');
mwb = MWB*1e-6;         % Measurement window begin

%% Parameters
cc = [1480 4660];       % Water/copper sound speed
fLow = 1e6;             % Lower cutoff frequency
fHigh = 7e6;            % Higher cutoff frequency
fs = 50e6;              % Sampling frequency
thick = [0.0235 0.04];  % Thickness of water layer (distance from transducer to end of ROI)
aPitch = 0.001;         % Array element pitch
pulseDelay = 0.7e-6;    % Approximate

%% Convert cell to matrix
tmpCell = cell(1,1,length(data));
tmpCell(1,1,:) = data;
ptxw = cell2mat(tmpCell);
[nT,nX,nW] = size(ptxw);

%% Zero-pad according to measurement window begin
ptxw = [zeros(round(mwb*fs),nX,nW); ptxw];

%% Plot example raw data: Received field when middle element is excited
tPlot = ((0:(nT-1))/fs + mwb);
xPlot = (0:(nX-1))*aPitch;
figure
colormap(gray(256))
imagesc(xPlot*1e3,tPlot*1e6,logImage(ptxw(:,:,round(nW/2))))
caxis([-50 0])
colorbar
xlabel('x [mm]')
ylabel('t [us]')
title({'Envelope of wavefield (dB) received by all elements',...
    ' when middle element is excited'})

%% Focus
disp('Processing data')
tic
txDelay = eye(nX) - 1;  % Zero transmit delay, only one element at a time
[im,xIm,zIm] = array_psm(ptxw,fs,txDelay,cc,thick,fLow,fHigh,aPitch,...
    'pulseDelay',pulseDelay,'skipLayers',1);
toc 
    
%%
figure
colormap(gray(256))
imagesc(xIm*1e3,zIm{2}*1e3,logImage(im{2}))
colorbar
caxis([-50 -10])
xlabel('x [mm]')
ylabel('z [mm]')
title({'Focused image (dB) of immersed copper block ', ' based on all transmitted waves'})

%% Add blank line (nicer formatting for test text output).
disp(' ')