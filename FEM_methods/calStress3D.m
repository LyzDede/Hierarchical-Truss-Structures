function fs=calStress3D(ps, ls, U, A, E)
      
    pvs=ps(ls(:,2),:)-ps(ls(:,1),:);
    lengths=sqrt(diag(pvs*pvs'));
    angles=pvs./repmat(lengths,1,3);
    dU=[U(ls(:,2)*3-2)-U(ls(:,1)*3-2) U(ls(:,2)*3-1)-U(ls(:,1)*3-1) U(ls(:,2)*3)-U(ls(:,1)*3)];
    
    fs=E*diag(angles*dU').*A'./lengths;
    
end