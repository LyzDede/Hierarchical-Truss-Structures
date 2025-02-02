function [c,ceq]=bcCons_onlyG(x,n,vps,F0,k0,E)
    ctMax=1100;

    a=floor(n/2)+1;
    b=floor((n + 1) / 2) + 1;
    ts=x(1:a);
    d=x(a+1:a+b-1);
    ds=[d 0.5-sum(d)];
    
    A=x2fullA(x,n);
    
    %几何约束
    c1=-ds(end);%[-ds(end) ds(end)-0.35];
    
    [ps,ls]=farMaoOpt(vps, n,ts,ds);
    K=stiffMatrix3D(ps, ls, A, E);

    frees = [0, 0, 0, 0, 0, 0, 0, 1, 0,zeros(1,length(ps)*3-15),1, 1, 1, 0, 1, 1];
    Fa=[zeros(length(ps)*3-7,1);-F0];
    Uc=zeros(1,6);

    [U,F]=calFandU(K, frees, Fa, Uc);
    fs=calStress3D(ps, ls, U, A, E);

    ceq=[];

    %刚度约束
    c2=k0*0.99-F0/abs(U(length(U)-2));
    c3=F0/abs(U(length(U)-2))-1.01*k0;
    
    %拉约�?
    cts=-ones(1,length(ls)/3);
    for i=1:length(ls)/3
        if fs(i*3)>0
            cts(i)=abs(fs(i*3))-A(i*3)*ctMax;
        end
    end
   
    %整体屈曲约束
    G = geoStiffMatrix3D(ps, ls, A, E, U);
    Kaa = notFixMatrixG(K, frees);
    Gaa = notFixMatrixG(G, frees);
    kg=Kaa+Gaa;
    [vs,es]=eig(full(kg));
    u=diag(real(es))';
    c=[c1,c2,c3,cts,-u];%

end