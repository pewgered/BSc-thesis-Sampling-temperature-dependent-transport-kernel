function [ CS ] = logloginterp( CS1,CS2,e1,e2,E )

CS=CS1*exp(log(CS2/CS1)/log(e2/e1)*log(E/e1));

end

