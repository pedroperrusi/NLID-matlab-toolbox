function Vector=fastrmt2(N,n,nx,ny,ne,x,y,e);
% Forms a regressor matrix with specified dimensions.
% 
%   Vector=fastrmt2(N,n,nx,ny,ne,x,y,e);
% 
%  This function computes the regressor matrix (PHI) in a linear regression 
%  problem; i.e. Y=PHI*THETA
%
%  Y= the output from the system provided by the user
%  PHI= the regressor matrix 
%  
%   N=  how many rows wanted in the regressor matrix
%  nx=  number of lagged inputs 
%  ny=  number of lagged outputs 
%  ne=  number of lagged errors 
%   n=  degree of polynimial
%   
%  The regressor matrix is setup in the following format:
%
%  Vector=[G_zu G_zue G_e] where 
%
%  G_zu contains the order in which terms containing z and u terms appear 
%  in the first partition of the regressor matrix.
%  
%  G_zue contains the order in which terms containing  z, u and e appear 
%  in the second partition of the regressor matrix. 
%  
%  G_e contains the order in which terms containing e only appear 
%  in the third partition of the regressor matrix. 
%
%  Also see name2.m
%
%       Sunil L. Kukreja  12 May 1998  (revised 2 December 1998)
%       Copyright Sunil L. Kukreja

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

extend=max(max(nx,ny),ne);
ZE=zeros(1,extend);

 
xt=[ZE x];
yt=[ZE y];
et=[ZE e];

max_loop=nx+ny+ne+2;
max_n=n-1;

%  start to form vector H consisting of all possible u's y's and e's and 1
for k=1:N
 for j=1:max_loop,  
     if j==1   H(k,j)=1;
     elseif ((j>1)&(j<=nx+2))  H(k,j)=xt(k-j+2+extend);
     elseif ((j>nx+2)&(j<=nx+ny+2)) H(k,j)=yt(k-j+nx+2+extend);
     else 
     H(k,j)=et(k-j+nx+ny+2+extend);
     end
 end
end 
 
%  Four different counters for Gu Gzu Gzue and Ge

l_u=0;
l_zu=0;
l_zue=0;
l_e=0;

for q1=1:max_loop,
if n==1 q1t=(max_loop); else q1t=q1; end;    
for q2=q1t:(max_loop),    
if n==2 q2t=(max_loop); else q2t=q2;end;
for q3=q2t:(max_loop),
if n==3 q3t=(max_loop); else q3t=q3;end;
for q4=q3t:(max_loop),
if n==4 q4t=(max_loop); else q4t=q4;end;
for q5=q4t:(max_loop),
if n==5 q5t=(max_loop); else q5t=q5;end;
for q6=q5t:(max_loop),
if n==6 q6t=(max_loop); else q6t=q6;end;
for q7=q6t:(max_loop),
if n==7 q7t=(max_loop); else q7t=q7;end;
for q8=q7t:(max_loop),
if n==8 q8t=(max_loop); else q8t=q8;end;
for q9=q8t:(max_loop),
if n==9 q9t=(max_loop); else q9t=q9; end;
for q10=q9t:(max_loop),

result=[];
for i=1:n,
  eval(['result(' num2str(i) ')=(q' num2str(i) '==1)|(q' num2str(i) '<=nx+2);']);
end
res=sum(result);
if (res~=n)
command1='value=';
for i=1:max_n,
command1=[command1 'H(:,q' num2str(i) ').*'];
end;
command1=[command1 'H(:,q' num2str(n) ');'];
eval(command1);
else 
end

result=[];

for i=1:n,
  eval(['result(' num2str(i) ')=(q' num2str(i) '==1)|(q' num2str(i) '<=nx+2);']);
end
res=sum(result);
if (res==n)
%	l_u=l_u+1; %**comment out for fast regressor
%	Gu(:,l_u)=value; %**
else
	for i=1:n,
		eval(['result(' num2str(i) ')=(q' num2str(i) '<=nx+ny+2);']);
	end
      res=sum(result);
      if (res==n)
      	l_zu=l_zu+1;
            Gzu(:,l_zu)=value;
	else

	for i=1:n,
      	eval(['result(' num2str(i) ')=(q' num2str(i) '>nx+ny+2)|(q' num2str(i) '==1);']);
      end
      res=sum(result);
	if  (res==n)
		l_e=l_e+1;
		Ge(:,l_e)=value;
	else
		l_zue=l_zue+1;
		Gzue(:,l_zue)=value;
	end
      end
end




end
end
end

end
end

end
end
end

end
end


%if ne==0 & n~=1
%Vector=[Gu Gzu];
%elseif ne~=0 & n==1
%Vector=[Gu Gzu Ge];
%elseif ne==0 & n==1
%Vector=[Gu Gzu];
%else
%Vector=[Gu Gzu Gzue Ge];
%end

if ne==0 & n~=1
Vector=[Gzu];
elseif ne~=0 & n==1
Vector=[Gzu Ge];
elseif ne==0 & n==1
Vector=[Gzu];
else
Vector=[Gzu Gzue Ge];
end

