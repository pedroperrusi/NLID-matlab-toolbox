function poly_gui(option,mdls,vafs)
% GUI application to choose the order of a polynomial
% 
% 
%  'option' is a control string.  It can take on the following values:
%    accept :  set the "done flag" and exit.
%    down   :  Decrease order by 1
%    init   :  Initialize the GUI, open figures, etc...
%    up     :  Increase order by 1
%

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../../copying.txt and ../../gpl.txt 


% globals common @wbose/nlident
global  dtw_poly_done dtw_poly_order

% globals common to previous calls to pdm_gui
global dtw_poly_vafs dtw_poly_mdls dtw_poly_figure


switch option
  case 'accept'
    clf
    poly_gui('plot');
    dtw_poly_done = 1;
    
  case 'init'
     dtw_poly_done = 0;
     dtw_poly_figure = figure;
     dtw_poly_mdls = mdls;
     dtw_poly_vafs = vafs;
     [val,pos] = min(mdls);
     dtw_poly_order = pos - 1;
     poly_gui('plot');
     poly_gui('ui_controls');

   case 'plot'
     % plot the singular values, hiliting the current order.
     % also show the corresponding first and second-order kernels
     figure(dtw_poly_figure);
     orders = [1:length(dtw_poly_mdls)]'-1;
     
     subplot(211)
     plot(orders,dtw_poly_vafs,'*');
     title('Variance Accounted For');
     xlabel('Polynomial Order');
     hold on
     plot(dtw_poly_order,dtw_poly_vafs(dtw_poly_order+1),'m*');
     hold off     
     
     
     subplot(212)
     semilogy(orders,dtw_poly_mdls,'*');
     title('MDL Cost Function');
     xlabel('Polynomial Order');
     hold on
     plot(dtw_poly_order,dtw_poly_mdls(dtw_poly_order+1),'m*');
     hold off     
     
   case 'ui_controls'
     %
     %  Set up the UI controls
     %
     figure(dtw_poly_figure)
     subplot(211)
     accept_button = uicontrol('style','pushbutton', 'units', 'normalized',...
        'pos', [0.75 0.65 0.12 0.0375], 'string',...
        'Accept','callback', 'poly_gui(''accept'');' );
     down_button =  uicontrol('style','pushbutton', 'units', 'normalized',...
        'pos', [0.75 0.6 0.05 0.0375], 'string',...
        '<','callback', 'poly_gui(''down'');' );
      up_button =  uicontrol('style','pushbutton', 'units', 'normalized',...
        'pos', [0.82 0.6 0.05 0.0375], 'string',...
        '>','callback', 'poly_gui(''up'');' );
    
  case 'up'
    max_order = length(dtw_poly_mdls)-1;
    if dtw_poly_order < max_order
      dtw_poly_order = dtw_poly_order + 1;
      poly_gui('plot');
    end
  case 'down'
    if dtw_poly_order > 0
      dtw_poly_order = dtw_poly_order - 1;
      poly_gui('plot');
    end
    
  otherwise
    error('unrecognized option');
end

  


