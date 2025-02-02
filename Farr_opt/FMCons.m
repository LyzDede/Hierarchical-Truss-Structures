function [c,ceq]=FMCons(x,L,F,E,k0)
    %n=20;
    n=x(1);
    r=x(2);
    L0 = sqrt(6) * L / (2 * n + 4);

    B = 0.245;
    k = pi * r * r*E/L0;
    c(1)=F - B * (power(L0,3)) * k * pi * pi / (L * L);

    f=F/sqrt(6);
    a=pi*r*r;
    c(2)=f-pi*a*a*E/(4*power(L0,2));


    K=36*k/(11*n+43);
    c(3)=k0*0.99-K;
    c(4)=K-k0*1.01;
    ceq=[];
end
    