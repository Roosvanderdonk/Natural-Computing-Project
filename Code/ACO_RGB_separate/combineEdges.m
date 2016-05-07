function [ edges ] = combineEdges( edges_r, edges_g, edges_b, method )
%combineEdges Combines the three input edges into one, using the specified
%method.
%   edges_r, edges_g, edges_b = equal sized 2d matrices, ones and zeros
%   method = 'or', 'majority', 'threshold'

% every pixel in the three input edges is copied to the new edges
if strcmp(method, 'or')
    edges = (edges_r | edges_g | edges_b);
% if the pixel exists in at least 2 of the 3 edges, the pixel is copied
elseif strcmp(method,'majority')
    temp = edges_r + edges_g + edges_b;
    edges = temp>=2;
% the edges are taken as probabilities, and a new threshold is computed
% using the func_seperate_two_class() method
elseif strcmp(method,'threshold')
    temp = edges_r + edges_g + edges_b;
    temp = temp./3;
    threshold = func_seperate_two_class(temp);
    edges = abs((temp >= threshold).*255-255);
else
    error('Combination method undefined');   
end

end

