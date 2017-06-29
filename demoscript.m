%% demoscript.m
% 
% This script converts a pair of rectified stereo images into a mesh.
% The im folder must be located in the same directory.
% 
%   L:  rectified left image  R:  rectified right image
%   LD: left disparity map    RD: right disparity map

%% prepare images

% clear everything
clc; clear; close all;

% load images by stereo base name
imname = 'piano';
[L, R] = stereoread(['im/', imname]);

% display images
figure(1); clf;
imshow([R, L]);
title(imname);

%% make disparity maps

% make maps
[RD, LD] = stereo2disparity(L, R, floor(size(L, 2) / 4), 4);

% display maps
figure(2); clf;
subplot(1, 2, 2); imagesc(LD); title([imname, ' left disparity']);
axis image; colormap jet;
subplot(1, 2, 1); imagesc(RD); title([imname, ' right disparity']);
axis image; colormap jet;

%% display surfaces

figure(3); clf;
subplot(1, 2, 2);
M = disparity2mesh(LD, L);
axis vis3d;
title([imname, ' left surface']);
subplot(1, 2, 1);
M = disparity2mesh(RD, R);
axis vis3d;
title([imname, ' right surface']);
