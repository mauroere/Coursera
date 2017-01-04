function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%

h = X * theta;
e = h - y;
e_2 = e .^ 2;
J = sum(e_2) / (2 * m);
r = sum(theta(2:end).^2) * (lambda / (2 * m));
J = J + r;

% =========================================================================

e_grad = h - y;
delta = X' * e_grad;
grad = delta / m;
thetaReg = (lambda / m) .* theta;
thetaReg(1) = 0;
grad = grad + thetaReg;

grad = grad(:);

end
