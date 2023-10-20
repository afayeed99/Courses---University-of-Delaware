%% 1
clc;clear

out=sim('Lab1P2Si',15);

subplot(2,1,1)
plot(out.tout,out.input_u1,'r-','LineWidth',1.5)
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Exerting force (N)','fontname','times','fontweight','bold')
xlim([0,15]); ylim([0,1.2]); 
set(gca,'linewidth',1.5,'fontname','times')

subplot(2,1,2)
plot(out.tout,out.result_y1,'r-','Linewidth',1.5)
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Output (m)','fontname','times','fontweight','bold')
xlim([0,15]); ylim([0,0.6]); 
set(gca,'linewidth',1.5,'fontname','times')

print -djpeg part2_1
%% 2

clc;clear, close all

out=sim('Lab1P2Si',15);
plot(out.tout,out.result_y2,'r-','Linewidth',1.5)
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Output (m)','fontname','times','fontweight','bold')
xlim([0,15]); ylim([0,0.6]); 
set(gca,'linewidth',1.5,'fontname','times')

print -djpeg part2_2
%% 3
clc;clear, close all

out=sim('Lab1P2Si',15);
plot(out.tout,out.result_y3,'r-','Linewidth',1.5)
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Output (m)','fontname','times','fontweight','bold')
xlim([0,15]); ylim([-0.2,1.2]); 
set(gca,'linewidth',1.5,'fontname','times')

print -djpeg part2_3