% Script for EE476 Experiment 2
Jeq = 1.16e-6+.5*0.068*.0248^2;
kt = 0.0502;
Im = 1;
Io = 0;
I1 = 0;
I2 = 0;
L = 0.82e-3;
Rm = 10.6;
km = 0.0502;
tau_m = 0.005;
wf = 1/0.1;

K = 1/(km+Rm*Io);
% K = 14.7;
tau = Jeq*Rm/(kt*km+Rm*kt*Io);
Ktd = -Rm/(kt*km+Rm*kt*Io);
tau_td = Jeq*Rm/(kt*km+Rm*kt*Io);