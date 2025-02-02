function Ta =loopSolve_GI(Tb,E,minA)

    hier=length(Tb{end}.location);
    Ta=Tb;
    
    for j =1:length(Tb)
        tbj=Tb{j};
        if length(tbj.location)==hier
            [ks,lens,Fs,addAs,vs1,vs2,lsnum,totalV]=nextGen(tbj.length,tbj.xOpt,tbj.topo,tbj.force,E);
            Ta{j}.replaceNum=lsnum;
            for k=1:length(ks)
                loc=[tbj.location lsnum(k)];
                [xa,va,topo]=single_solveGI(lens(k),Fs(k),ks(k),E,minA);
                TaN=subTruss(loc,1, topo,lens(k),Fs(k),ks(k),va,xa);
                if lsnum(k)==9*tbj.topo+9
                    TaN.vTimes=tbj.vTimes*6;
                else
                    TaN.vTimes=tbj.vTimes*12;
                end
                Ta{end+1}=TaN;

            end
        end
    end
end
  
%}
    