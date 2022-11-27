%% Matlad code implementing Chan-Vese model in the paper 'Active Contours Without Edges'(IEEE TIP 2001)
%   This method works well for bimodal images, for example the image 'three.bmp'

clear;
close all;
clc;

Img=imread('test_images/three.bmp');      % example that CV model works well
% Img=imread('test_images/circle.jpg');      % example that CV model works well
% Img=imread('test_images/vessel.bmp');    % Warning: example image that CV model does NOT work well
% Img=imread('test_images/twoCells.bmp');   % Warning: example image that CV model does NOT work well

if size(Img, 3) > 1
    U = rgb2gray(Img);
else
    U = Img;
end

[nrow,ncol] =size(U); % get the size

ic=nrow/2;
jc=ncol/2;
r=20;
phi_0 = sdf2circle(nrow,ncol,ic,jc,r); % construct the signed distance function
figure; mesh(phi_0); title('Signed Distance Function')

delta_t = 0.1;
lambda_1=1;
lambda_2=1;
nu=0;
h = 1;
epsilon = 1;
mu = 100; %0.01*255*255;

I=double(U);
% iteration should begin from here
phi=phi_0;
figure(2);
subplot(1,2,1); mesh(phi);
subplot(1,2,2); imagesc(uint8(I));colormap(gray)
hold on;
plotLevelSet(phi,0,'r');

numIter = 1;
seg_region_old = zeros(size(U));
seg_region_new = zeros(size(U));

for k=1:50
    phi = evolution_cv(I, phi, mu, nu, lambda_1, lambda_2, delta_t, epsilon, numIter);   % update level set function
    if mod(k,2)==0
        pause(.5);
        figure(2); clc; axis equal; 
        title(sprintf('Itertion times: %d', k));
        subplot(1,2,1); mesh(phi);
        subplot(1,2,2); imagesc(uint8(I));colormap(gray)
        hold on; plotLevelSet(phi,0,'r');
        
        if k == 2
            seg_region_old = (phi < 0);
        else
            seg_region_new = (phi < 0);
            dif_pixNum = sum(sum(abs(seg_region_old - seg_region_new)));
            if dif_pixNum < 1 % 零水平集包围的区域不再变化，则终止迭代
                fprintf('Level set evolution is converged.\n');
                break;
            else
                seg_region_old = seg_region_new;
            end
        end
    end    
end
