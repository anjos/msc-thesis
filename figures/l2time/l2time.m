% This MatLab file plots the Number of processors needed to run L2. The L2
% processes are Real-Time processes that arrive at each 0.00001 seconds (10
% us) and, if one cannot cope with the number of events, a critical loss
% will occur. So, this makes it a hard-real-time application. If the number
% of CPUS increase, one can have more processes/events comming to the
% system. The number of CPUS depends also on the CPU usage. If a CPU is not
% well-used more CPUs will have to be available. One also has to discount
% time used for data communication. Let's assume for now this will happen in
% N% of the time an event needs to be processed.

x = 1:100:2800;
y = x*0.01;

%semilogx(x,y);
plot(x,y);
grid on;
xlabel('Number of Processing Nodes');
ylabel('Time Spent per Event (in ms)');
title('L2 Time Requirements');
add_curve(x,0.9,0.9,'r-.');
add_curve(x,0.5,0.8,'r--');
legend('100% of CPU usage/100% of Net usage','90% of CPU usage/90% of Net usage','80% of CPU usage/50% of Net usage');


gtext('Time = Processors * 0.01 * CPU-usage * NET-usage');

  

