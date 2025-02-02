classdef subTruss
    properties
        location
        vTimes
        topo
        length
        force
        volume
        xOpt
        replaceNum
        stiffness
    end
    
    methods
        function obj = subTruss(location,vtimes,topo,length,force,stiffness,volume,xOpt)
            obj.location = location;
            obj.vTimes=vtimes;
            obj.topo = topo;
            obj.length = length;
            obj.force = force;
            obj.stiffness = stiffness;
            obj.volume = volume;
            obj.xOpt = xOpt;
            obj.replaceNum=[];
        end
    end

end