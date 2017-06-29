function [L, R] = stereoread(imname)
% Takes a stereo image base name and returns the left and right images.
% 
% function [L, R] = loadstereo(imname)
% 
%   imname: stereo image base name (string)
% 
%   L:      left image (MxNx1 or MxNx3)
%   R:      right image (MxNx1 or MxNx3)

% determine format (file extension and stereo type) of input image
for e = {'jpg', 'jpeg', 'png', 'bmp', 'tif', 'tiff'}
    ext = ['.', char(e)];
    if exist([imname, ext], 'file')
        % load anaglyph image
        I = im2double(imread([imname, ext]));
        % extract red filter
        L = I(:, :, 1);
        % extract cyan filter by computing a weighted average of green and
        % blue filters that preserves color luminance (see rgb2gray notes)
        R = 0.8374 * I(:, :, 2) + 0.1626 * I(:, :, 3);
        break;
    elseif exist([imname, '_crosseye', ext], 'file')
        % load crosseye image
        I = im2double(imread([imname, '_crosseye', ext]));
        % split into left and right images
        mid = floor(size(I, 2) / 2);
        L = I(:, 1 + mid:end, :);
        R = I(:, 1:mid, :);
        break;
    elseif exist([imname, '_parallel', ext], 'file')
        % load parallel image
        I = im2double(imread([imname, '_parallel', ext]));
        % split into left and right images
        mid = floor(size(I, 2) / 2);
        L = I(:, 1:mid, :);
        R = I(:, 1 + mid:end, :);
        break;
    elseif exist([imname, '_left', ext], 'file') && ...
           exist([imname, '_right', ext], 'file')
        % load left and right images
        L = im2double(imread([imname, '_left', ext]));
        R = im2double(imread([imname, '_right', ext]));
        break;
    end
end

if ~exist('L', 'var')
    error('Invalid stereo image base name.');
end

end
