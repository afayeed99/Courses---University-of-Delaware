clc;clear
out=sim('Lab5_Si',200);
% %part 1
plot(out.tout,out.simout+210,'Linewidth',2,'color','b')
hold on
grid on
xlabel('time[min]')
ylabel('Die pressure[psig]')
title("Changes of Die pressure over time in respond to drive torque increase")
hold off

plot(out.tout,out.simout1+126,'Linewidth',2,'color','b')
hold on
grid on
xlabel('time[min]')
ylabel('Drive torque[Nm]')
title("Response of Drive Torque over time")
hold off

plot(out.tout,out.simout2+210,'Linewidth',2,'color','b')
hold on
grid on
xlabel('time[min]')
ylabel('Die pressure[psig]')
title("Changes of Die pressure over time in respond to drive torque increase")
xlim([0 150])
hold off

plot(out.tout,out.simout3+126,'Linewidth',2,'color','b')
hold on
grid on
xlabel('time[min]')
ylabel('Drive torque[Nm]')
title("Response of Drive Torque over time")
hold off


plot(out.tout,out.simout4+210,'Linewidth',2,'color','b')
hold on
grid on
xlabel('time[min]')
ylabel('Die pressure[psig]')
title("Changes of Die pressure over time in respond to drive torque increase")
xlim([0 150])
hold off

plot(out.tout,out.simout5+126,'Linewidth',2,'color','b')
hold on
grid on
xlabel('time[min]')
ylabel('Drive torque[Nm]')
title("Response of Drive Torque over time")
hold off
