function [ks,lens,Fs,addAs,vs1,vs2,lsnum,totalV]=nextGen(L,x,n,F0,E)
    a=floor(n/2)+1;
    b=floor((n + 1) / 2) + 1;
    ts=x(1:a);
    d=x(a+1:a+b-1);
    ds=[d 0.5-sum(d)];
    A=x2fullA(x,n);
    
    vps=[0,0,0;L,0,0]; 
    [ps,ls]=farMaoOpt(vps, n,ts,ds);
    
    K=stiffMatrix3D(ps, ls, A, E);
    frees = [0, 0, 0, 0, 0, 0, 0, 1, 0,zeros(1,length(ps)*3-15),1, 1, 1, 0, 1, 1];
    Fa=[zeros(length(ps)*3-7,1);-F0];
    Uc=zeros(1,6);

    [U,F]=calFandU(K, frees, Fa, Uc);
    fs=calStress3D(ps, ls, U, A, E);

    ks=[];
    lens=[];
    Fs=[];
    vs1=[];
    vs2=[];
    addAs=[];
    lsnum=[];
    totalV=0;
    for i=[1:n*9/2+3,n*9+7:n*9+9]
        Len=norm(ps(ls(i,1),:)-ps(ls(i,2),:));
        if fs(i)<0
            cbl=pi*A(i)*A(i)*E/(4*power(Len,2));
            if -fs(i)-cbl>0
                Aadd=sqrt(-fs(i)*4*power(Len,2)/(E*pi));
                if mod(i,9)==0
                    lsnum=[lsnum,i];
                    ks=[ks,A(i)*E/Len];
                    lens=[lens,Len];
                    Fs=[Fs,-fs(i)];
                    addAs=[addAs,Aadd];
                    vs1=[vs1,A(i)*Len];
                    vs2=[vs2,Aadd*Len];
                end
                totalV=totalV+Aadd*Len*2;
            else
                totalV=totalV+A(i)*Len*2;
            end
        else
            totalV=totalV+A(i)*Len*2;
        end
    end
    subN=n*9/2+1;
    subL=norm(ps(ls(subN,1),:)-ps(ls(subN,2),:));
    totalV=totalV-subL*A(subN)*3;
end