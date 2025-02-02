function Kaa=notFixMatrixG(K,frees)
    Kaa=K;
    if1=find(frees==1);
    Kaa(if1,:)=[];
    Kaa(:,if1)=[];
end