function y = nlsim ( sys, x )
% Simulate response of nlmsym object to input data set
y=eval(sys.Sym);
% nlm/nlsim
