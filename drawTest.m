clc;
disp(strcat('required volume for a solid stable bar: ',num2str(v0)));
[ps1,ls1,As1]=drawTrussH1(T{1});

if length(T{2})>length(T{1})
    [ps2,ls2,As2,repls2]=drawTrussH2(T{2});
else
    disp('Maximum hierarchy is 1');
end

if length(T{3})>length(T{2})
    [ps3,ls3,As3,repls3]=drawTrussH3(T{3});
else
    disp('Maximum hierarchy is 2');
end
