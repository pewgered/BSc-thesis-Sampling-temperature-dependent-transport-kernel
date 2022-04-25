function [ x ] = g( lambda )

x=(1+1/(2*lambda^2))*erf(lambda)+exp(-lambda^2)/(sqrt(pi)*lambda);

end

