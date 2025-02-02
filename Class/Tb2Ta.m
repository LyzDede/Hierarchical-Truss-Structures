function Ta=Tb2Ta(Tb,E,minA)
    Ta={};
    for i =1:length(Tb)
        TaN=loopSolve_GI(Tb{i},E,minA);
        Ta{end+1}=TaN;
    end
end