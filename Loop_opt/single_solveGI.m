%function [n,v]=single_solveGI(L,F0,k0,E) %
function [x,v,topo]=single_solveGI(L,F0,k0,E,minA) %   

    x0=[20 8];
    lb0=[2 0.00001];
    ub0=[200 200000];
    fmX =fmincon(@(x) FMobjV(x,L),x0,[],[],[],[],lb0,ub0,@(x) FMCons(x,L,F0,E,k0),[]);

    n=floor(fmX(1));
    if mod(n,2)==1
        n=n+1;
    end
    r=fmX(2);

    vs=[];
    xs={};
    topos=[];

    if n>20
        topo=14;
    elseif n>12
        topo=n-6;   
    else
        topo=6;
    end

    for i = 1:30
        if length(vs)<2
            for n= topo:2:topo+6

                a=floor(n/2)+1;
                b=floor((n + 1) / 2) + 1;
                vps=[0,0,0;L,0,0]; 

                ran1=0.1+rand()*0.01;
                ran2=1-rand()*0.1;
                ran3=0.01+rand()*0.001;
                ran4=0.1-rand()*0.01;
                ran5=r*(i*2+rand());

                x0=[linspace(ran1,ran2,a) linspace(ran3,ran4,b-1) ones(1,a+b)*ran5];
                lb=[ones(1,a)*0.1 ones(1,b-1)*0.01 ones(1,a+b)*minA];
                ub=[ones(1,a)*1.2 ones(1,b-1)*0.5 ones(1,a+b)*10000000];

                options = optimoptions('fmincon');
                options.StepTolerance=1e-6;
                options.MaxIterations =400;
                options.MaxFunctionEvaluations=80000;
                options.Display='iter';
                options.UseParallel=true;
                %options.Algorithm='active-set';

                [rx,rv,exitflag,output] = fmincon(@(x) objV(x,n,vps),x0,[],[],[],[],lb,ub,@(x) bcCons_GI(x,n,vps,F0,k0,E),options);
                if exitflag==2 || (exitflag==0 && output.constrviolation<1e-5)|| exitflag==4|| exitflag==5
                    xs{end+1}=rx;
                    vs(end+1)=rv;
                    topos(end+1)=n;
                end
            end
        end
    end
    v=min(vs);
    x=xs{vs == v};
    topo=topos(vs == v);
    %}
end