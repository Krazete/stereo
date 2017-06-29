function S = disparity2mesh(D, I)
% Generates a mesh from a disparity map.
% 
% function S = disparity2mesh(D, I)
% 
%   D: disparity map (MxN)
%   I: color or grayscale image (MxNx1 or MxNx3) (optional)

% check if an image is provided
if nargin > 1
    % check that I and D are the same size
    [Ih, Iw, ~] = size(I);
    [Dh, Dw] = size(D);
    if Ih ~= Dh || Iw ~= Dw
        error('The image must have the same height and width as the disparity map.');
    end
end

S = surf(D, I, 'EdgeColor', 'none');

end
