function [ps,ls]=farMaoOpt(vps, n,ts,ds)
    ps=ones(3*n+5,3);
    ls=ones(9*n+9,2);
    barLength=norm(vps(2,:)-vps(1,:));
    newD = barLength / (n + 2);
    axisVect = (vps(2,:)-vps(1,:)) / barLength;
    if axisVect(2)~=0 || axisVect(3)~=0
        dd = sqrt(3 *power( axisVect(2) ,2) +3 *power( axisVect(3) ,2));
        triV01 =[0, -axisVect(3) * newD / dd, axisVect(2) * newD / dd];
    else
        triV01 =[0, -newD / 2, -newD * sqrt(3) / 6];
    end
    
    triV01=triV01/norm(triV01)* (newD / sqrt(2));
    triV02 = rotateVector(axisVect, pi * 2 / 3, triV01);
    triV03 = rotateVector(axisVect, -pi * 2 / 3, triV01);
    triV11 = rotateVector(axisVect, pi * 1 / 3, triV01);
    triV12 = rotateVector(axisVect, pi, triV01);
    triV13 = rotateVector(axisVect, -pi * 1 / 3, triV01);
    trivs0 = [triV01; triV02; triV03];
    trivs1 = [triV11; triV12; triV13];

    if mod(n,2)==0
        tts=[ts flip(ts(1:length(ts)-1))];
        dds=[ds flip(ds)];
    else
        dds=[ds flip(ds(1:length(ds)-1))];
        tts=[ts flip(ts)];
    end
    
    for i =1:n
        totalD = sum(dds(1:i));
        centerP = vps(1,:) + axisVect  * totalD * barLength;
        ls(9*i-8:9*i-6,:)=[3*i-2,3*i-1;3*i-2,3*i;3*i-1,3*i];
        if mod(i,2)==1
            ls(9*i-5:9*i,:)=[3*i-2,3*i+1;3*i-2,3*i+3;3*i-1,3*i+1;3*i-1,3*i+2;3*i,3*i+2;3*i,3*i+3];
            ps(3*i-2:3*i,:)=[centerP + trivs0(1,:)*tts(i);centerP + trivs0(2,:)*tts(i);centerP + trivs0(3,:)*tts(i)];
        else
            ls(9*i-5:9*i,:)=[3*i-2,3*i+1;3*i-2,3*i+2;3*i-1,3*i+2;3*i-1,3*i+3;3*i,3*i+1;3*i,3*i+3];
            ps(3*i-2:3*i,:)=[centerP + trivs1(1,:)*tts(i);centerP + trivs1(2,:)*tts(i);centerP + trivs1(3,:)*tts(i)];
        end
    end
    centerP = vps(1,:) + axisVect * (1-dds(end))* barLength;
    if mod(n,2)==0
        ps(3*n+1:3*n+3,:)=[centerP + trivs0(1,:)*tts(end);centerP + trivs0(2,:)*tts(end);centerP + trivs0(3,:)*tts(end)];
    else
        ps(3*n+1:3*n+3,:)=[centerP + trivs1(1,:)*tts(end);centerP + trivs1(2,:)*tts(end);centerP + trivs1(3,:)*tts(end)];
    end
    ls(9*n+1:9*n+3,:)=[3 * n+1, 3 * n + 2;3 * n+1, 3 * n + 3;3 * n + 2, 3 * n + 3];
    ls(9*n+4:9*n+6,:)=[1, 3 * n + 4;2, 3 * n + 4;3, 3 * n + 4];
    ls(9*n+7:9*n+9,:)=[3 * n + 3, 3 * n + 5;3 * n+2, 3 * n + 5;3 * n + 1, 3 * n + 5];
    ps(3*n+4:3*n+5,:)=[vps(1,:);vps(2,:)];
end