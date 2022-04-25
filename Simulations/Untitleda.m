tic
n=1e7;
for i=1:n
    s1=100*rand();
    s2=100*rand();
    e1=100*rand();
    e2=100*rand();
    e=100*rand();
    s=s1+(s2-s1)/(e2-e1)*(e-e1);
end
toc
tic
for i=1:n
    s1=100*rand();
    s2=100*rand();
    e1=100*rand();
    e2=100*rand();
    e=100*rand();
    s=s1*exp(log(s2/s1)/log(e2/e1)*log(e/e1));
end
toc
