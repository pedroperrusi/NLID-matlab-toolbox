function plot (sys)
% Overlaid plot operator for nlmsym objects
x1=.2;
x2=.8;
y1=.3;
y2=.7;
y3=(y1+y2)/2;
x=[0 x1 x1 x1  x2 x2  1 x2 x2 x1 ];
y=[y3 y3 y1 y2 y2 y3 y3 y3 y1 y1];
plot (x,y);
h=text (.5,.5,char(sys.Sym));
set(h,'horizontalalignment', 'center');
set(h,'verticalalignment','middle');
axis ([0 1 0 1]);
axis off;

