function mdot = ddx(m)
% computes the derivative of the polynomial, m(x), with respect to its
% argument.
%
% Syntax:  mdot = ddx(m);
%
% where m and mdot are polynom objects

% Copyright 1991-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt


mdot = m;
old_type = get_nl(mdot,'type');

% turn the polynomial into a power series
mdot = nlident(mdot,'type','power');
coeff = get_nl(mdot,'coef');
order = length(coeff);

% differentiate the power series term by term
coeff = coeff(2:order).*[1:order-1]';
set(mdot,'coef',coeff);

% change back to the original polynomial type.
mdot = nlident(mdot,'type',lower(old_type));
