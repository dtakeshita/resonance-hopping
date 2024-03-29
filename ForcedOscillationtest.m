clear; close all;
load testdata.mat
nd = 1;
tmp = savedata{nd};
g = 9.8;
%T = 0.4;
T = tmp.T;
%T = 0.64;
omegaFwd = 2*pi/T;
omega_n = sqrt(tmp.K/tmp.M);
tend = 1*T;
tspan = [0 tend];
tsim = 0:tmp.dt:tend;
ic = [tmp.X_MTC0; tmp.V0];
X_CC0 = tmp.X_MTC0 - tmp.X_SEC0;
F_SEC = tmp.M*(g-tmp.Afloor) - tmp.C*tmp.Vfloor;
dX_SEC = F_SEC/tmp.K;
X_SEC = tmp.X_SEC0 + dX_SEC;
X_CC = tmp.Yfloor - X_SEC;
Amp_CC = (max(X_CC) - min(X_CC))/2;
Amp_CC_opt = (omega_n^2 - omegaFwd^2)/omegaFwd^2*tmp.M*g/tmp.K
Xfwd_CC = (Amp_CC)*(1 - cos(omegaFwd*tsim)) + X_CC0;
opts = odeset('RelTol',1e-4,'AbsTol',1e-4);
[t,y] = ode45(@(t,y) focrceoscifcn(t,y,tsim,Xfwd_CC,tmp.M,tmp.K,tmp.C,tmp.X_SEC0,g), tspan, ic, opts);

plot(t,y(:,1))