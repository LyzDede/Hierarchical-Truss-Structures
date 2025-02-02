function [ps,ls]=farMaoOri(vps, n)
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
    for i =1:n
        centerP = vps(1) + axisVect * i * newD;
        ls(9*i-8:9*i-6,:)=[3*i-2,3*i-1;3*i-2,3*i;3*i-1,3*i];
        if mod(i,2)==1
            ls(9*i-5:9*i,:)=[3*i-2,3*i+1;3*i-2,3*i+3;3*i-1,3*i+1;3*i-1,3*i+2;3*i,3*i+2;3*i,3*i+3];
            ps(3*i-2:3*i,:)=[centerP + trivs0(1,:);centerP + trivs0(2,:);centerP + trivs0(3,:)];
        else
            ls(9*i-5:9*i,:)=[3*i-2,3*i+1;3*i-2,3*i+2;3*i-1,3*i+2;3*i-1,3*i+3;3*i,3*i+1;3*i,3*i+3];
            ps(3*i-2:3*i,:)=[centerP + trivs1(1,:);centerP + trivs1(2,:);centerP + trivs1(3,:)];
        end
    end
    centerP = vps(1) + axisVect * (n + 1) * newD;
    if mod(n,2)==0
        ps(3*n+1:3*n+3,:)=[centerP + trivs0(1,:);centerP + trivs0(2,:);centerP + trivs0(3,:)];
    else
        ps(3*n+1:3*n+3,:)=[centerP + trivs1(1,:);centerP + trivs1(2,:);centerP + trivs1(3,:)];
    end
    ls(9*n+1:9*n+3,:)=[3 * n+1, 3 * n + 2;3 * n+1, 3 * n + 3;3 * n + 2, 3 * n + 3];
    ls(9*n+4:9*n+6,:)=[1, 3 * n + 4;2, 3 * n + 4;3, 3 * n + 4];
    ls(9*n+7:9*n+9,:)=[3 * n + 3, 3 * n + 5;3 * n+2, 3 * n + 5;3 * n + 1, 3 * n + 5];
    ps(3*n+4:3*n+5,:)=[vps(1,:);vps(2,:)];
end