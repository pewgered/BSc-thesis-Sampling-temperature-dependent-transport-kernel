function [transfDir] = transformDirection(origDir, refDir)
%origDir, transfDir  sorvektor, refDir mindegy

if (refDir(1)==0 && refDir(2)==0)
    if refDir(3)>0
        transfDir=origDir;
    else
        transfDir=-origDir;
    end
else
    %refDir=refDir/(refDir(1)^2+refDir(2)^2+refDir(3)^2);
    rho=sqrt(refDir(1)^2+refDir(2)^2);

    T=[refDir(2)/rho, refDir(1)*refDir(3)/rho, refDir(1)
    -refDir(1)/rho, refDir(2)*refDir(3)/rho, refDir(2)
    0, -rho, refDir(3)];

    transfDir=(T*(origDir'))';
end

end

