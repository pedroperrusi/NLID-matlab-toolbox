function display(tpl)
%TEMPLATE Display a template object in Matlab window
%  DISPLAY(TPL) displays informations about the content of template 
%  object TPL:
%     Template Object: root '.', 2 files, 9 keys, comment unknowns.
%  root element of template files, number of template files, number of 
%  keywords defined and the way of handling unknowns tags.

%  Copyright (C) 2003 Guillaume Flandin <Guillaume@artefact.tk>
%  $Revision: 1.1.1.1 $Date: 2004/06/06 20:29:12 $

disp(' ');
disp([inputname(1),' = ']);
disp(' ');
for i=1:prod(size(tpl))
	disp([blanks(length(inputname(1))+3) char(tpl(i))]);
end
disp(' ');
