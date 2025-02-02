


clc;
tic;
format long;

E = 100000;
n=10;
a=floor(n/2)+1;
b=floor((n + 1) / 2) + 1;
i=2;
L=1000;
F =4000; 
k =1000;
vps=[0,0,0;L,0,0]; 

minA=0.05*0.05*pi;

%x0=[linspace(0.1,0.75,a) linspace(0.01,0.075,b-1) ones(1,a+b)*12];
x0=[linspace(0.5,0.8,a) linspace(0.01,0.07,b-1) ones(1,a+b)*8];
%x0=[0.561066 0.561066 0.561066 0.561066 0.561066 0.612304 0.666486 0.710127 0.741769 0.760593 0.766997 0.01 0.0153318 0.0244227 0.0335136 0.0426045 0.0516955 0.0576959 0.0622238 0.065619 0.0678808 1.67357 2.70962 0.785398 3.11849 0.941655 3.73643 1.32489 4.44166 1.49318 5.23322 1.75049 5.81645 1.96128 6.26972 2.10495 6.61107 2.21226 6.83871 2.26905 6.95261 2.29561 3.85807 ];

%x0=[ones(1,a) ones(1,b-1)*0.5/b ones(1,a+b)*5];

%x0=H3T8{311}{5}.xOpt;
lb=[ones(1,a)*0.09999999 ones(1,b-1)*0.009999999 ones(1,a+b)*minA];
ub=[ones(1,a)*1.2 ones(1,b-1)*0.5 ones(1,a+b)*2000];

options = optimoptions('fmincon');%,'PlotFcn', {@optimplotfval, @optimplotconstrviolation}
options.StepTolerance=1e-6;
options.MaxIterations =1000;
options.MaxFunctionEvaluations=80000;
options.Display='iter';
options.UseParallel=true;
%options.Algorithm='active-set';

[x,fval,exitflag,output] = fmincon(@(x) objV(x,n,vps),x0,[],[],[],[],lb,ub,@(x) bcCons_GI(x,n,vps,F,k,E),options);


fprintf('n= %g;\n', n);
fmt=['x=[' repmat('%g ',1,numel(x)) '];\n'];
fprintf(fmt,x);
fprintf('v= %e;\n', fval);



elapsedTime=toc;
disp(['运行时间为',num2str(elapsedTime),'秒']);

print('1', '-dpng', '-r600');
