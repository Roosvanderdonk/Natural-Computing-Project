 function [FIG, EVAL] = Eval_Pheromones(GROUNDTRUTH, PHEROMONES)

% This fucntion calculates a binary image from a pheromone matrix by selecting the NRPIXELS highest values as positives.
% Then it evaluates the performance of the classification model by 
% calculating the common performance measures: Accuracy, Sensitivity, 
% Specificity, Precision, Recall, F-Measure, G-mean.
% Input:  
%		 PHEROMONES = Column matrix with floats depicting the pheromones layed on every location.
%        GROUNDTRUTH = Column matrix with predicted class labels by the
%                    classification model
% Output: EVAL = Row matrix with all the performance measures

 
%get binary image by selecting the NRPIXELS highest values in the PHEROMONES matrix and make them black.

%make sure the GROUNDTRUTH matrix is binary
if max(GROUNDTRUTH(:))==255
    GROUNDTRUTH=GROUNDTRUTH/255;
end

%calculate the number of black pixels in the groundtruth 
[p1,p2] = size(GROUNDTRUTH);
NRPIXELS = p1*p2-sum(GROUNDTRUTH(:));
disp('nr of black pixels in groundtruth =')
disp(NRPIXELS)

%assign the calculated nr of black pixels in the ground truth to the
%highest values in the PHEROMONES matrix:
[d1,d2] = size(PHEROMONES);
B=-(1:NRPIXELS);

%sort the pheromones matrix 
[si si] = sort(PHEROMONES(:), 'descend');

%make a figure of the same size as the pheromone matrix
FIG = ones(d1,d2);

%make the pixels with high pheromone values black
FIG(si(1:NRPIXELS))=0;

% EVALUATE the figure by comparing it to the GROUNDTRUTH
ACTUAL = FIG;
idx = (ACTUAL()==1);

p = length(ACTUAL(idx));
n = length(ACTUAL(~idx));
N = p+n;

tp = sum(ACTUAL(idx)==GROUNDTRUTH(idx));
tn = sum(ACTUAL(~idx)==GROUNDTRUTH(~idx));
fp = n-tn;
fn = p-tp;

tp_rate = tp/p;
%tn_rate = tn/n;

%accuracy = (tp+tn)/N;
sensitivity = tp_rate;
%specificity = tn_rate;
precision = tp/(tp+fp);
recall = sensitivity;
f_measure = 2*((precision*recall)/(precision + recall));
%gmean = sqrt(tp_rate*tn_rate);

%output vector
EVAL = [f_measure tp tn fp fn];


