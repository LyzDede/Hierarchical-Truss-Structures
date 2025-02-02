function [U,F]=calFandU(K, frees, Fa, Uc)
    Kaa=K;
    if0=find(frees==0);
    if1=find(frees==1);
    Kaa(if1,:)=[];
    Kaa(:,if1)=[];
    
    Kca=K;    
    Kca(if0,:)=[];
    Kca(:,if1)=[];

    Ua=Kaa\Fa;  %-transpose(Kca)*Uc
    Fc=Kca*Ua;  % + Kcc*Uc

    U=sparse(if1,1,Uc,length(K),1)+sparse(if0,1,Ua,length(K),1);
    F=sparse(if1,1,Fc,length(K),1)+sparse(if0,1,Fa,length(K),1);

    
end