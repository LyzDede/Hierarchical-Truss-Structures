function A=varA2fullA(Avar,n)
    a=floor(n/2)+1;
    b=floor((n + 1) / 2) + 1;
    A1=[Avar(1:a+b-1) flip(Avar(1:a+b-2)) Avar(end) Avar(end)];
    A=ones(1,9*n+9);

    for i=1:n
        for j=-8:-6
            A(9*i+j)=A1(2*i-1);
        end
        for j=-5:0
            A(9*i+j)=A1(2*i);
        end
    end
    for i=-8:-6
        A(length(A)+i)=A1(length(A1)-2);
    end
    for i=-5:0
        A(length(A)+i)=A1(end);
    end
end
