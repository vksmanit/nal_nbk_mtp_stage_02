function x = nal_nbk_mcg(A,b)
% --------------------------------------------------------------------------------------------
% Syntax :- x = nal_nbk_mcg(A,b) 
%
% This is modified conjugate gredient method to solve the system of  equation Ax = b,
% here we have take x = zeros(length(b),1) as our initial guess.
% --------------------------------------------------------------------------------------------

% -------------------------------- written on : Mar 12, 2018 ---------------------------------

    x = zeros(length(b),1);
    r = b - A*x;
    p = r;
    iter = 1;
    for k = 1:100 %length(b) % since modified CG generate the exact solution to linear system 
                       % Ax = b in at most n step 
                       % this is not working with length(b) --> TODO
       %iter = iter + 1 ;% variable for iteration
    Ap = A * p;
    alpha = (r(1:3)'*p(1:3) - r(4:7)'*p(4:7))/(p(1:3)' * Ap(1:3) - p(4:7)'*Ap(4:7));
    x = x + alpha * p;
    % x = x - alpha * p;  % -ve sign is in paper but +ve sign is working
    rold = r;
    r = r - alpha * Ap;
    if ( abs(r-rold) < 1e-6)
        % iter
        break;
    end
     beta = -(r(1:3)'*Ap(1:3) -r(4:7)'*Ap(4:7))/(p(1:3)' * Ap(1:3) - p(4:7)'*Ap(4:7));
     p = r + beta * p;
  %     k
end
