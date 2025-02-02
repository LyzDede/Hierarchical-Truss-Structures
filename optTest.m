E=100000;            % Young's Modulus
w=8;                 % topology parameter for Modelβ
minA=0.000001;       % minium bar cross sectional area


L=1000;                  % total truss length
F= 8100;                 % uniaxial compressive load
k0=2*sqrt(F*E/pi);       % required stiffness for a stable bar
v0=k0*L*L/E;             % required volume for a stable bar
k=k0/10;                 % required stiffness for the optimal truss 
% if k=k0, there's no need to replace the bar with a truss

hier=3;                  % maximum hierarchy

[xa,va,topo]=single_solveGI(L,F,k,E,minA); 
Ta1={subTruss(1,1, topo,L,F,k,va,xa)};          % optimal truss gained by Model_Alpha (with one hierarchy)

Tb=loopSolve_onlyG(L,F,k,E,w,minA,hier);        % trusses gained by Model_Beta (contain unstable bars)
Ta=Tb2Ta(Tb,E,minA);                            % trusses gained by Model_Alpha (with more than one hierarchy)

T=[{Ta1} Ta];                                   % optimal trusses

%%%% to visualize the rsults, please run drawTest.m

