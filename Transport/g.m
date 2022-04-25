function [ x ] = g( lambda )
%lambda SI-ben
x=(1+1/(2*lambda^2))*erf(lambda)+exp(-lambda^2)/(sqrt(pi)*lambda);

end

