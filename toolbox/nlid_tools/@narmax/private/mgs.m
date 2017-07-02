function [Q,R]=mgs(X);
% QR factorization using the Modified Gram-Schmidt (MGS) Algorithm
%
% Given X E R^mxn with rank(X)=n -->  X=Q*R where Q E R^mxn has orthogonal
% columns and R E R^mxm is upper triangular.
%
% Orthogonal-triangular decomposition.
%      [Q,R] = mgs(X) produces an upper triangular matrix R of the same
%      dimension as X and a unitary matrix Q so that X = Q*R.
% 
%  
% References: 
%             Matrix Computations, Gene H. Golub and Charles F. Van Loan, 
%             3rd Ed., pp. 232, The Johns Hopkins University Press, 1996. 
%
%             Linear Algebra with Applications, Steven J. Leon, 3rd Ed., 
%             pp. 240, Macmillan Pubilishing Co., 1990.
%
%
%
%
%  Also see rmmgs.m
%
%       Sunil L. Kukreja  08 December 1998  
%       Copyright Sunil L. Kukreja

%A=[1 -2 3;1 4 5;7 -4 9;3 1 1] original
%A=[1 -2 1;1 4 3;7 -4 5;3 1 7] 1 column changes (last one)
%A=[1 9 1;1 -2 3;7 3 5;3 -6 7] 2 columns change (last two)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[m,n]=size(X);

for k=1:n
    R(k,k)=sqrt(sum(X(:,k).^2)); %compute the 2-norm norm(X(:,k))
%    Q(:,k)=X(:,k)/R(k,k);
    X(:,k)=X(:,k)/R(k,k); %X is overwritten by Q

    for j=k+1:n
%        R(k,j)=Q(:,k)'*X(:,j);
%        X(:,j)=X(:,j)-Q(:,k)*R(k,j);
        R(k,j)=X(:,k)'*X(:,j);
        X(:,j)=X(:,j)-X(:,k)*R(k,j);
    end

end

Q=X;
