function sys = nlmsym (sysin, varargin)
% NonLinear Symbolic object
% Parent: nltop

if nargin== 0,
   sys=mknlmsym;
elseif isa (sysin,'sym');
   sys=mknlmsym;
   sys.Sym=sysin;
elseif isa (sysin,'nlmsym');
   sys=sysin;
else
   error(['nlm does not support inputs of this class ' class(s)])
end
return
%
%
function sys= mknlmsym
sys.Sym = sym;
	nlt=nltop;
   sys=class(sys,'nlmsym',nlt);
   return
   
