
clc;
format short;
E = 100000;
%nn=1;
%L=lens(nn);F= Fs(nn);k0=ks(nn);
L=1000;F= 4000; k=1000;   V1=10000; V2=2.256758334191025e+05;
%L=5000;F=500000;k0=100000;v1=3125000;v2=44603102.9;

x0=[20 8];
lb=[2 0.00001];
ub=[200 200000];

%x0=[1.5];
%lb=[0.5];
%ub=[2000];

[x,fval,exitflag,output,lambda] =fmincon(@(x) FMobjV(x,L),x0,[],[],[],[],lb,ub,@(x) FMCons(x,L,F,E,k),[])
