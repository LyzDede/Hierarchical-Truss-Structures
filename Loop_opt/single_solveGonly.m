function [x,v]=single_solveGonly(L,F0,k0,E,n,minA)%,mm

    a=floor(n/2)+1;
    b=floor((n + 1) / 2) + 1;
    vps=[0,0,0;L,0,0];

    x0=[20 8];
    lb0=[2 0.00001];
    ub0=[200 200000];
    fmX =fmincon(@(x) FMobjV(x,L),x0,[],[],[],[],lb0,ub0,@(x) FMCons(x,L,F0,E,k0),[]);
    r0=fmX(2);
    
    xs=[];
    vs=[];
    
    for i = 1:30
        if length(vs)<2 %|| min(vs)> 2*L*L*k0/E
            ran1=0.1+rand()*0.01;
            %ran2=0.5+1/(9-mm)+rand()*0.1;
            ran2=1.3+rand()*0.1;
            ran3=0.01+rand()*0.001;
            ran4=0.1-rand()*0.01;
           % ran5=r0*(i*2-rand()*1);
            ran5=r0*i*0.5+rand()*0.5;

            x0=[linspace(ran1,ran2,a) linspace(ran3,ran4,b-1) ones(1,a+b)*ran5];
            %x0=[ones(1,a)*1 ones(1,b-1)*1/(n+2) ones(1,a+b)*ran5];
            %x0=[linspace(0.11,1.5,a) linspace(0.011,0.15,b-1) ones(1,a+b)*ran5];

            lb=[ones(1,a)*0.1 ones(1,b-1)*0.01 ones(1,a+b)*minA];
            ub=[ones(1,a)*1.5 ones(1,b-1)*0.5 ones(1,a+b)*10000000000];

            options = optimoptions('fmincon');
            options.StepTolerance=1e-6;
            options.ConstraintTolerance=1e-4;
            options.MaxIterations =600;
            options.MaxFunctionEvaluations=24000;
            options.Display='iter';
            options.UseParallel=true;
            %options.Algorithm='active-set';
            %options.FiniteDifferenceStepSize=1e-4;
            
            [rx,rv,exitflag,output] = fmincon(@(x) objV(x,n,vps),x0,[],[],[],[],lb,ub,@(x) bcCons_onlyG(x,n,vps,F0,k0,E),options);
            if exitflag==2 || (exitflag==0 && output.constrviolation<1e-5)||exitflag==4||exitflag==5
                xs(end+1,:)=rx;
                vs(end+1)=rv;
            end
            
        end
    end

    v=min(vs);
    x=xs(vs == v,:);


end