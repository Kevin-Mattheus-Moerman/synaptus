close all
clearvars

%% Show test header (useful when run as part of test suite)
disp('-----------------------------------------------------------------')
disp('-----         SYNAPTUS TOOLBOX TEST: mulok_test3D           -----')
disp('-----      Multi-layer omega-k migration, 3D dataset        -----')
disp('-----------------------------------------------------------------')
disp(' ')

%% Add path to necessary functions
toolboxPath=fileparts(fileparts(mfilename('fullpath'))); %Get the toolbox path

%Add core and misc path
addpath(fullfile(toolboxPath,'core'),fullfile(toolboxPath,'misc'));

%% Load data
disp('Loading data');
load(fullfile(toolboxPath,'datasets','PlaneScan3D_PlexiAluFBH.mat'),...
    'fs','ptxy','tDelay','fLow','fHigh','fc','thick','xStep','yStep','cc');

interpol = 'chirpz';    % Stolt interp. method, options 'linear', 'chirpz'
% interpol = 'linear';    % Stolt interp. method, options 'linear', 'chirpz'

%% Focus
disp('Processing data');
tic
[im,xIm,yIm,zIm] = mulok(ptxy,fs,tDelay,cc,thick,fLow,fHigh,[xStep yStep],...
    'fc',fc,'interpol',interpol);
toc

%% Plot raw and focused image
test3D_plot

%% Add blank line (nicer formatting for test text output).
disp(' ')