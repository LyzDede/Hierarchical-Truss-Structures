function nvpss=nvps_nextGen(vps,n,x,replaceNum)
   


    a=floor(n/2)+1;
    b=floor((n + 1) / 2) + 1;
    ts=x(1:a);
    d=x(a+1:a+b-1);
    ds=[d 0.5-sum(d)];
    
    [ps,ls]=farMaoOpt(vps, n,ts,ds);
    
    lsnums={};
    for i=1:length(replaceNum)
        if replaceNum(i)==9*n+9
            lsnum=linspace(9*n+4,9*n+9,6);
        else
            lsnum=[linspace(replaceNum(i)-5,replaceNum(i),6) linspace(9*n+4-replaceNum(i),9*n+9-replaceNum(i),6)];
        end
        lsnums{end+1}=lsnum;
    end

    nvpss={};
    for i=1:length(lsnums)
        nvps=[];
        for j=1:length(lsnums{i})
            nvps=[nvps;ps(ls(lsnums{i}(j),1),:) ;ps(ls(lsnums{i}(j),2),:)];
        end
        nvpss{end+1}=nvps;
    end
 
end