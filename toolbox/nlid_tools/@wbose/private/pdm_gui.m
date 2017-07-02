function pdm_gui(option,ss,uu)
% GUI application to choose number of principal dynamic modes in a 
% Wiener-Bose model
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
global  dtw_pdm_done dtw_pdm_nfilt

% globals common to previous calls to pdm_gui
global dtw_pdm_ss dtw_pdm_uu dtw_pdm_figure


switch option
  case 'accept'
    clf
    pdm_gui('plot');
    dtw_pdm_done = 1;
    
  case 'init'
     dtw_pdm_done = 0;
     dtw_pdm_figure = figure;
     dtw_pdm_ss = ss;
     dtw_pdm_uu = uu;
     pdm_gui('plot');
     pdm_gui('ui_controls');

   case 'plot'
     % plot the singular values, hiliting the current order.
     % also show the corresponding first and second-order kernels
     figure(dtw_pdm_figure);
     subplot(211)
     semilogy(dtw_pdm_ss,'*');
     title('Singular Values');
     xlabel('Mode Number');
     hold on
     plot(dtw_pdm_nfilt,dtw_pdm_ss(dtw_pdm_nfilt),'m*');
     hold off     
     
     [nr,nc] = size(dtw_pdm_uu);
     tau = [0:nr-1]';
     Us = dtw_pdm_uu(:,1:dtw_pdm_nfilt);
     Ss = dtw_pdm_ss(1:dtw_pdm_nfilt);
     k1 = Us*Ss;
     k2 = Us*diag(Ss)*Us';     
     subplot(223)
     plot(tau,k1);
     subplot(224)
     mesh(tau,tau,k2);
     
   case 'ui_controls'
     %
     %  Set up the UI controls
     %
     figure(dtw_pdm_figure)
     subplot(211)
     accept_button = uicontrol('style','pushbutton', 'units', 'normalized',...
        'pos', [0.75 0.85 0.12 0.0375], 'string',...
        'Accept','callback', 'pdm_gui(''accept'');' );
     down_button =  uicontrol('style','pushbutton', 'units', 'normalized',...
        'pos', [0.75 0.8 0.05 0.0375], 'string',...
        '<','callback', 'pdm_gui(''down'');' );
      up_button =  uicontrol('style','pushbutton', 'units', 'normalized',...
        'pos', [0.82 0.8 0.05 0.0375], 'string',...
        '>','callback', 'pdm_gui(''up'');' );
    
  case 'up'
    if dtw_pdm_nfilt < length(dtw_pdm_ss)
      dtw_pdm_nfilt = dtw_pdm_nfilt + 1;
      pdm_gui('plot');
    end
  case 'down'
    if dtw_pdm_nfilt > 1
      dtw_pdm_nfilt = dtw_pdm_nfilt - 1;
      pdm_gui('plot');
    end
    
  otherwise
    error('unrecognized option');
end

  


