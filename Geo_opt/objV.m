function minVolume=objV(x,n,vps)
    a=floor(n/2)+1;
    b=floor((n + 1) / 2) + 1;
    ts=x(1:a);
    d=x(a+1:a+b-1);
    
    ds=[d 0.5-sum(d)];
    
    A=x2fullA(x,n);
    
    [ps,ls]=farMaoOpt(vps, n,ts,ds);

    minVolume=0;
    for i=1:length(ls)
        Len=norm(ps(ls(i,1),:)-ps(ls(i,2),:));
        minVolume=minVolume+Len*A(i);
    end
end

