function [LD, RD] = stereo2disparity(L, R, steps, radius)
% Computes the disparity map with sum of squared differences.
% 
% function [LD, RD] = stereo2disparity(L, R, layers, radius)
% 
%   L:      left image
%   R:      right image
%   steps:  number of disparity buckets
%   radius: radius of window
% 
%   LD:     left disparity map
%   RD:     right disparity map

% initialize buckets, filter window, and color setting
kernel = fspecial('disk', radius);
color = size(L, 3) == 3;

% get right disparity
% initialize cost matrix
C = zeros(size(L, 1), size(L, 2), steps);
for i = 1:steps
    % overlap
    Rt = imtranslate(R, [i, 0]);
    % get cost
    C(:, :, i) = imfilter((L(:, :, 1) - Rt(:, :, 1)).^2, kernel);
    if color
        C(:, :, i) = C(:, :, i) + imfilter((L(:, :, 2) - Rt(:, :, 2)).^2, kernel, 'same');
        C(:, :, i) = C(:, :, i) + imfilter((L(:, :, 3) - Rt(:, :, 3)).^2, kernel, 'same');
    end
    % add the cost of distance
    C(:, :, i) = C(:, :, i) * 1.05^i;
end
% get disparity map
[~, RD] = min(C, [], 3);

% get left disparity
% initialize cost matrix
C = zeros(size(L, 1), size(L, 2), steps);
for i = 1:steps
    % overlap
    Lt = imtranslate(L, [-i, 0]);
    % get cost
    C(:, :, i) = imfilter((Lt(:, :, 1) - R(:, :, 1)).^2, kernel);
    if color
        C(:, :, i) = C(:, :, i) + imfilter((Lt(:, :, 2) - R(:, :, 2)).^2, kernel);
        C(:, :, i) = C(:, :, i) + imfilter((Lt(:, :, 3) - R(:, :, 3)).^2, kernel);
    end
    % add the cost of distance
    C(:, :, i) = C(:, :, i) * 1.05^i;
end
% get disparity map
[~, LD] = min(C, [], 3);

end
