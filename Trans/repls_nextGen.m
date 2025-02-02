function lsnums=repls_nextGen(n,replaceNum)
   
    lsnums=[];
    for i=1:length(replaceNum)
        if replaceNum(i)==9*n+9
            lsnum=linspace(9*n+4,9*n+9,6);
        else
            lsnum=[linspace(replaceNum(i)-5,replaceNum(i),6) linspace(9*n+4-replaceNum(i),9*n+9-replaceNum(i),6)];
        end
        lsnums=[lsnums lsnum];
    end

   
end