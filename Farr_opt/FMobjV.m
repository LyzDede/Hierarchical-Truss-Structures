function minVolume=FMobjV(x,L)
    n=x(1);
    %n=20;
    num=9*n+9;
    r=x(2);
    L0 = sqrt(6) * L / (2 * n + 4);
    minVolume=L0*num*pi*r*r;
end
    