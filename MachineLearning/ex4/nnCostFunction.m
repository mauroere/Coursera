function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

%size(Theta1)
%size(Theta2)
% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

z2 = [ones(m,1) X] * Theta1';
h1 = sigmoid(z2); %5000x25
z3 = [ones(m,1) h1] * Theta2';
h2 = sigmoid(z3); %5000x10

y10 = zeros(m,num_labels); %5000x10
for i = 1:m
  y10(i,y(i)) = 1;
end

a = -y10 .* log(h2);
b = (1 - y10) .* log(1 - h2);
c = a - b;
d = sum(c, 2);
J = sum(d) / m;

% -------------------------------------------------------------

t1 = Theta1(:,2:input_layer_size + 1);
t2 = Theta2(:,2:hidden_layer_size + 1);
tt1 = t1.^2;
tt2 = t2.^2;
tt1_sum = sum(tt1(:));
tt2_sum = sum(tt2(:));
J = J + (lambda / (2 * m))*(tt1_sum + tt2_sum);

% =========================================================================

a1 = [ones(m,1) X]'; %401x5000
z2 = Theta1 * a1; %25x401 401x5000 : 25x5000
a2 = [ones(1,m); sigmoid(z2)]; %26x5000
z3 = Theta2 * a2; %10x26 26x5000 : 10x5000
a3 = sigmoid(z3); %10x5000
h = a3; %10x5000

yT = y10'; %10x5000
delta3 = h - yT; %10x5000
g2 = a2 .* (1 - a2); %26x5000
delta2 = (Theta2' * delta3) .* g2; %26x10 10x5000 : 26x5000
delta2 = delta2(2:end,:);
Delta2 = delta3 * a2'; %10x5000 5000x26 : 10x26
D2 = Delta2 / m;
Delta1 = delta2 * a1'; %25x5000 5000x401 : 25x401
%Delta1 = Delta1(2:end,:);
D1 = Delta1 / m;

L1 = Theta1 * (lambda / m);
L1 = [zeros(size(D1,1),1) L1(:,2:end)];
D1 = D1 + L1;

L2 = Theta2 * (lambda / m);
L2 = [zeros(size(D2,1),1) L2(:,2:end)];
D2 = D2 + L2;

Theta1_grad = D1;
Theta2_grad = D2;
%size(Theta1_grad)
%size(Theta2_grad)
% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];

end
