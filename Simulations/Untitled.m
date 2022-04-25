tic
N=2e5;
energies=floor(10*rand(N,1));
j=1;
egybolkiszokes=0;
for i=1:N
    if energies(i)==0
        egybolkiszokes=egybolkiszokes+1;
    else
        e(j)=energies(i);
        j=j+1;
    end
end
ecdf(e)
toc