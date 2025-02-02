function TV=totalTrussV(T)
	TV=0;
    for i =1:length(T)
        Vi= T{i}.volume;
        
        n=T{i}.topo;
        x=T{i}.xOpt;
        a=floor(n/2)+1;
        b=floor((n + 1) / 2) + 1;
        ts=x(1:a);
        d=x(a+1:a+b-1);
        ds=[d 0.5-sum(d)];
        
        A=x2fullA(x,n);

        vps=[0,0,0;T{i}.length,0,0]; 
        [ps,ls]=farMaoOpt(vps, n,ts,ds); 
        
        for j=T{i}.replaceNum 
            Len=norm(ps(ls(j,1),:)-ps(ls(j,2),:));
            if j==9*n+9
                Vi=Vi-Len*A(j)*6;
            else
                Vi=Vi-Len*A(j)*12;
            end
        end
        %{
        for j=1:size(T{i}.thickNum,1)
            k=T{i}.thickNum(j,:);
            Len=norm(ps(ls(k(1),1),:)-ps(ls(k(1),2),:));
            if k==9*n+9
                Vi=Vi-Len*A(k(1))*6+k(2)*6;
            else
                Vi=Vi-Len*A(k(1))*12+k(2)*12;
            end
        end
        %}
        TV=TV+Vi*T{i}.vTimes;
        
    end
end