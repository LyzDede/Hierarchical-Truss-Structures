
function [c,ceq]=bcCons_GI(x,n,vps,F0,k0,E)
    ctMax=1100;

    a=floor(n/2)+1;
    b=floor((n + 1) / 2) + 1;
    ts=x(1:a);
    d=x(a+1:a+b-1);
    ds=[d 0.5-sum(d)];
    
    c0a=-ones(1,2*a-2);
    for i=2:a
        c0a(2*i-1)=x(i-1)-x(i)-0.25;
        c0a(2*i)=x(i)-x(i-1)-0.25;
    end
    
    c0b=-ones(1,2*a-2);
    for i=2:a
        c0b(2*i-1)=ds(i-1)-ds(i)-0.15/(n/2+1);
        c0b(2*i)=ds(i)-ds(i-1)-0.15/(n/2+1);
    end
    %{
    for i=1:a
        c0b(2*a-2+i)=0.25/(n/2+1)-ds(i);
    end
    %}
    A=x2fullA(x,n);
    
    
    c1=-ds(end);
    ceq=[];
    
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
    
    %单杆屈曲约束 & 压拉约束
    sbs=-ones(1,round(length(ls)/6)+1);
    cts=-ones(1,round(length(ls)/6)+1);
    for i=1:round(length(ls)/6)
        if fs(3*i)<0 && ~mod(3*i,9)==0
            Len=norm(ps(ls(3*i,1),:)-ps(ls(3*i,2),:));
            cbl=pi*A(3*i)*A(3*i)*E/(4*power(Len,2));
            sbs(i)=-fs(3*i)-cbl;
        end
        cts(i)=abs(fs(3*i))-A(3*i)*ctMax;
    end
    dend=norm(ps(ls(length(ls),1),:)-ps(ls(length(ls),2),:));
    sbs(end)=-fs(end)-pi*A(end)*A(end)*E/(4*power(dend,2));
    cts(end)=abs(fs(end))-A(end)*ctMax;


    %整体屈曲约束
    G = geoStiffMatrix3D(ps, ls, A, E, U);
    Kaa = notFixMatrixG(K, frees);
    Gaa = notFixMatrixG(G, frees);
    kg=Kaa+Gaa;
    [vs,es]=eig(full(kg));
    u=diag(real(es))';
    c=[c1,c2,c3,sbs,cts,-u];%c0a,c0b,

end