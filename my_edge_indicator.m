function g = my_edge_indicator(I, sigma)
%a general edge-detector g=1/(1+laplas(G_delta(x,y))*I)
I = BoundMirrorExpand(I); 
G=fspecial('gaussian',15,sigma);
X=conv2(I,G,'same');
[Ix,Iy]=gradient(X);
g=1./(1+Ix.^2+Iy.^2);
