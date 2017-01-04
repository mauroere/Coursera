function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 0.3;
sigma = 0.1;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

params = [0.01 0.03 0.1 0.3 1.0 3 10 30]';
%params = [0.01 0.1 1.0 10]';
counts = length(params);
errors = zeros(counts*counts, 3);

for i = 1:counts
  C = params(i);
  for j = 1:counts
    lp = j+(i-1)*counts;
    sigma = params(j);
    model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
    predictions = svmPredict(model, Xval);
    errors(lp,1) = mean(double(predictions ~= yval));
    errors(lp,2) = C;
    errors(lp,3) = sigma;
  end
end

[e, ei] = min(errors(:,1));
C = errors(ei, 2)
sigma = errors(ei, 3)

% =========================================================================

end
