function [vlabel,lenu]=name2(n,nx,ny,ne);
%  Forms the row names for the prameter vector in linear regression.
%   
%  [vlabel,lenu]=name2(n,nx,ny,ne);
%   
%   
%  This function computes the names of all the parameters in the parameter 
%  vector. 
%  
%   n=  degree of polynimial
%  nx=  number of lagged inputs 
%  ny=  number of lagged outputs 
%  ne=  number of lagged errors 
%   
%  vlabel - contains the names of all the columns of the regressor matrix
%  lenu   - the number of columns depending on only the input and DC term
%
%       Sunil L. Kukreja  12 May 1998 (revised 2 December 1998)
%       Copyright Sunil L. Kukreja


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Four different counters for Gu Gzu Gzue and Ge

l_u=0;
l_zu=0;
l_zue=0;
l_e=0;

max_loop=nx+ny+ne+2;
max_n=n-1;

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


command2='str=[';
for i=1:max_n,
command2=[command2 ' getname(q' num2str(i) ',nx,ny,ne)'];
end;
command2=[command2 ' getname(q' num2str(n) ',nx,ny,ne)];'];
eval(command2);



result=[];

for i=1:n,
  eval(['result(' num2str(i) ')=(q' num2str(i) '==1)|(q' num2str(i) '<=nx+1+1);']);
end
res=sum(result);
if (res==n)
	l_u=l_u+1;
	Gu{1,l_u}=str;
else
	for i=1:n,
		eval(['result(' num2str(i) ')=(q' num2str(i) '<=nx+ny+1+1);']);
	end
      res=sum(result);
      if (res==n)
      	l_zu=l_zu+1;
	Gzu{1,l_zu}=str;
	else

	for i=1:n,
      	eval(['result(' num2str(i) ')=(q' num2str(i) '>nx+ny+1+1)|(q' num2str(i) '==1);']);
      end
      res=sum(result);
	if  (res==n)
		l_e=l_e+1;
	Ge{1,l_e}=str;
	else
		l_zue=l_zue+1;
	Gzue{1,l_zue}=str;
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


%Gu, pause, Gzu, pause, Gzue, pause, Ge, pause,

lenu=length(Gu);

if ne==0 & n~=1
vlabel=[Gu Gzu];
elseif ne~=0 & n==1
vlabel=[Gu Gzu Ge];
elseif ne==0 & n==1
vlabel=[Gu Gzu];
else
vlabel=[Gu Gzu Gzue Ge];
end

