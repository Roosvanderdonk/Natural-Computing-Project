function [ edges ] = combineEdgesHSI( ~, edges_s, edges_i)
%combineEdges Combines the three input edges into one, using the specified
%method.
%   edges_h, edges_s, edges_i = equal sized 2d matrices, ones and zeros
%   method = 'or', 'majority', 'threshold'

edges = edges_s | edges_i;

end

