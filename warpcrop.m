I = im2double(imread('niss.jpg'));
[h, w, ~] = size(I);
A = [1, 1,
     w, 1;
     1, h,
     w, h];

figure(1); clf;
imshow(I);
B = ginput(4);

[X, Y] = meshgrid(1:w, 1:h);
X = X(:);
Y = Y(:);
imshow(X);

A = affine2d(H);
W = imwarp(I, A);

figure(2); clf;
imshow(W);
