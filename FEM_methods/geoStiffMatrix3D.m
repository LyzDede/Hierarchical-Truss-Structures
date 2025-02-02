function G=geoStiffMatrix3D(ps, ls, A, E, U)
    lenK=length(ps)*3;
    G=sparse(zeros(lenK));
    
    
    for i =1:size(ls,1)
        barLength=dist(ps(ls(i,1),:),ps(ls(i,2),:));
        
        cosX=(ps(ls(i,1),1)-ps(ls(i,2),1))/barLength;
        cosY=(ps(ls(i,1),2)-ps(ls(i,2),2))/barLength;
        cosZ=(ps(ls(i,1),3)-ps(ls(i,2),3))/barLength;

        minC=min([abs(cosX),abs(cosY),abs(cosZ)]);
        if abs(cosX)==minC
            deltaE=[0, -cosZ, cosY];
        elseif abs(cosY)==minC
            deltaE=[-cosZ,0,cosX];
        else
            deltaE=[-cosY,cosX,0];
        end

        gamE=[cosX, cosY, cosZ];
        deltaE = deltaE / norm(deltaE);
        etaE = cross(gamE, deltaE);

        I=[ls(i,1)*3-2 ls(i,1)*3-1 ls(i,1)*3 ls(i,2)*3-2 ls(i,2)*3-1 ls(i,2)*3 ];
        Vg=[gamE -gamE];
        Vd=[deltaE -deltaE];
        Ve=[etaE -etaE];
        
        gamG=sparse(I,1,Vg,lenK,1);
        deltaG=sparse(I,1,Vd,lenK,1);
        etaG=sparse(I,1,Ve,lenK,1);
        
        gks = A(i) * E * gamG'*U / power(barLength,2);
        G=G+gks*(deltaG*deltaG'+etaG*etaG');
    end
end