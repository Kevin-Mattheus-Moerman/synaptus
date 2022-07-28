close all
clearvars
clc

%% Add path to necessary functions
toolboxPath=fileparts(fileparts(mfilename('fullpath'))); %Get the toolbox path

%Add core and misc path
addpath(fullfile(toolboxPath,'core'),fullfile(toolboxPath,'misc'));

%% Load data
load(fullfile(toolboxPath,'datasets','LineScan2D_PinsPlexiAluSDH.mat'),'fs','ptx','tDelay',...
    'fLow','fHigh','thick','xStep','cc','fc');

%% Parameters
[nT,nX] = size(ptx);        % Size of B-scan matrix
tPlot = (0:(nT-1))/fs + tDelay;    % Time vector for y axis
xPlot = (0:(nX-1))*xStep;        % X vector for x axis

interpol = 'linear';    % Stolt interpolation method, options 'linear', 'chirpz'

%% Focus
tic
[im,xIm,zIm] = mulok(ptx,fs,tDelay,cc,thick,fLow,fHigh,xStep,'fc',fc,...
    'interpol',interpol);
toc

%% Plot raw data
figure
imagesc(xPlot*1e3,tPlot*1e6,logImage(abs(hilbert(ptx))))
colorbar
set(gca,'CLim',[-30 0])
xlabel('X [mm]')
ylabel('Time [\mu s]')
title('Raw data')

%% Plot focused image
figure
for ii = 1:3
    subplot(3,1,ii)
    imagesc(xIm*1e3,zIm{ii}*1e3,logImage(im{ii}))
    set(gca,'CLim',[-30 0])
    ylabel('Z [mm]')
    title(['Focused image, layer ' num2str(ii)])
end
xlabel('X [mm]')
