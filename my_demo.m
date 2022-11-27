%% DIA homework1 

% by Sapphire-356
% modified from zhyx12's implemention

clear;
close all;
clc;

%% read Image

im1 = imread('test_images/three.bmp');      
im2 = imread('test_images/circle.jpg');      
im3 = imread('test_images/cups.jpg');      
im4 = imread('test_images/vessel.bmp');   
im5 = imread('test_images/twocells.bmp'); 

Img = im1;

%% 
if size(Img, 3) > 1
    U = rgb2gray(Img);
else
    U = Img;
end

[nrow, ncol] = size(U);

c0=3;
initialLSF = c0 * ones(size(U));
initialLSF(5:nrow-5, 5:ncol-5) = -c0;  
phi_0 = initialLSF;
figure; mesh(phi_0); title('initial contour')

%% parameters

delta_t = 5; % time step
lambda = 3;
mu = 0.04; 
nu = 2.0; 

epsilon = 1.5; 
sigma = 1.5;
I = double(U);
g = my_edge_indicator(I, sigma);
[gx, gy] = gradient(g);

%% Level set method

phi = phi_0;
figure(2);
imagesc(uint8(I));colormap(gray)
hold on;
plotLevelSet(phi, 0, 'r');

numIter = 1;
for k = 1:240
    % my_evolution_cv
    phi = my_evolution_cv(phi, g, gx, gy, mu, nu, lambda, delta_t, epsilon, numIter);   % update level set function
    if mod(k, 4) == 0
        pause(0.05);
        figure(2);
        imagesc(uint8(I));colormap(gray)
        hold on;
        plotLevelSet(phi, 0, 'r');
    end    
end
