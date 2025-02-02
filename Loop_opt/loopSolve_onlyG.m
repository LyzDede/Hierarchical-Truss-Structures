function Tb =loopSolve_onlyG(L0,F0,k0,E,n,minA,hier)
    
    [xb,vb]=single_solveGonly(L0,F0,k0,E,n,minA);
    Tb={};
    loc=1;
    Tb{end+1}={subTruss(loc,1, n,L0,F0,k0,vb,xb)};
    
    if hier>2
        for i = 1:hier-2
            Tb_now=Tb{end};
            lc=length(Tb{end}{end}.location);
            for j =1:length(Tb{end})
                tbj=Tb{end}{j};
                if length(tbj.location)==lc
                    [ks,lens,Fs,addAs,vs1,vs2,lsnum,totalV]=nextGen(tbj.length,tbj.xOpt,tbj.topo,tbj.force,E);
                    Tb_now{j}.replaceNum=lsnum;
                    for k=1:length(ks)
                        loc=[tbj.location lsnum(k)];
                        if lsnum(k)==9*tbj.topo+9
                            vT=6;
                        else
                            vT=12;
                        end
                        [xb,vb]=single_solveGonly(lens(k),Fs(k),ks(k),E,n,minA);
                        TbN=subTruss(loc,1, n,lens(k),Fs(k),ks(k),vb,xb);
                        TbN.vTimes=tbj.vTimes*vT;
                        Tb_now{end+1}=TbN;
                    end
                end
            end
            Tb{end+1}=Tb_now;
        end
    end
end
      