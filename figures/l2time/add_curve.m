function add_curve(x, cpu_usage, net_usage, linespec);
  
% ADD_CURVE(X,CPU,NET, LINESPEC) will add a curve to the plot, holding the
% current contents.

  hold on;
  new_curve=x*0.01*cpu_usage*net_usage;
%  semilogx(x,new_curve,linespec);
  plot(x,new_curve,linespec);
  hold off;
  return;
