function [Q,R]=rmmgs(Q,R,A,c);
% QR factorization using the remodified Modified Gram-Schmidt (MGS) Algorithm
%
% Given the QR factorization of A_old, and the new updated matrix A_new 
% [Q,R]=modreg(Q,R,A_new,c) computes the fast orthogonal-triangular 
% decomposition of A_new
% 
%
% This can be used when the entire matrix, A_new, does not need to be 
% re-orthogonalized.  The "updated or new" columns of A_new are orthogonalized 
% relative to the previously orthogonalized and unchanged columns of A_old.
% 
% The matrix A is assumed to be in two partitions.  The first, A', does not 
% change while the second partition, A'', is updated or new.  A=[A' A'']
%
% Q,R - Orthogonal-triangular decomposition of A_old
% A   - A_new   mxn matrix m >= n
% c   - number of columns of A_old that do not change
% 
% Q   - an m x n unitary matrix Q so that A_new = Q*R
% R   - an n x n upper triangular matrix 
%  
%  
%  
%  
% References: 
%             Matrix Computations, Gene H. Golub and Charles F. Van Loan, 
%             3rd Ed., pp. 231-2, The Johns Hopkins University Press, 1996. 
%
%             Linear Algebra with Applications, Steven J. Leon, 3rd Ed., 
%             pp. 240, Macmillan Pubilishing Co., 1990.
%
%
%
%
%  Also see mgs.m
%
%       Sunil L. Kukreja  09 December 1998  
%       Copyright Sunil L. Kukreja

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[m,n]=size(A);

for k=1:n
    for j=c+1:n
        if j==k
	   R(k,k)=sqrt(sum(A(:,k).^2)); %compute the 2-norm norm(A(:,k))
	   Q(:,k)=A(:,k)/R(k,k);
	elseif j>k
           R(k,j)=Q(:,k)'*A(:,j);
           A(:,j)=A(:,j)-Q(:,k)*R(k,j);
        end
    end
end


