function [psss,lss,Ass,replss]=drawTrussH3(T)
    %[psss,lss,Ass,replss]=drawTrussH3(Ta{2})
    nvps1=[0 0 0 ;T{1}.length 0 0];
    nvps2=nvps_nextGen(nvps1,T{1}.topo,T{1}.xOpt,T{1}.replaceNum);

    ith=1;
    tnvps3={};
    for i=1:length(T)
        tnvps={};
        if length(T{i}.location)==2 
            if ~isempty(T{i}.replaceNum)
                for j=1:length(nvps2{ith})/2
                    vps=nvps2{ith}(2*j-1:2*j,:);
                    nvps=nvps_nextGen(vps,T{i}.topo,T{i}.xOpt,T{i}.replaceNum);
                    tnvps{end+1}=nvps;
                end
                tnvps3{end+1}=tnvps;
            end
            ith=ith+1;
        end
    end

    nvps3={};
    for i=1:length(tnvps3)
        for j=1:length(tnvps3{i}{1})
            nvpsj=[];
            for k=1:length(tnvps3{i})
                nvpsj=[nvpsj; tnvps3{i}{k}{j}];
            end
            nvps3{end+1}=nvpsj;
        end
    end

    nvpss=[nvps1 nvps2 nvps3];

    psss={};
    lss={};
    Ass={};

    for i=1:length(nvpss)
        pss={};
        for j=1:length(nvpss{i})/2
            vps=nvpss{i}(2*j-1:2*j,:);
            n=T{i}.topo;
            x=T{i}.xOpt;

            a=floor(n/2)+1;
            b=floor((n + 1) / 2) + 1;
            ts=x(1:a);
            d=x(a+1:a+b-1);
            ds=[d 0.5-sum(d)];
            [ps,ls]=farMaoOpt(vps, n,ts,ds);
            As=x2fullA(x,n);
            pss{end+1}=ps;
        end
        psss{end+1}=pss;
        lss{end+1}=ls;
        Ass{end+1}=As;
    end

    replss={};
    for i=1:length(T)
        replss{end+1}=repls_nextGen(T{i}.topo,T{i}.replaceNum);
    end
    
    figure
    for i=1:length(lss)
        for j=1:length(psss{i})
            ps=psss{i}{j};
            ls=lss{i};
            As=Ass{i};
            for k=1:length(ls)
                if ~ismember(k,replss{i})
                    plot3([ps(ls(k,1),1) ps(ls(k,2),1)],[ps(ls(k,1),2) ps(ls(k,2),2)],[ps(ls(k,1),3) ps(ls(k,2),3)],'k','LineWidth',sqrt(As(k)/pi))
                    hold on
                end
            end
        end
    end
    axis equal
    v=totalTrussV(T);
    title(strcat('Truss Volume =',num2str(v),', Hierarchy = 3'));
    
end

