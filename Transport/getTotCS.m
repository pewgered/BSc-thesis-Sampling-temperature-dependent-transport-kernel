function [ tot ] = getTotCS( Energy, CS, e)
%lineáris interpolációval meghatározza a hatáskeresztmetszet értékét
%bináris keresést használ
l=1;
r=size(e,1);
while l+1<r
   mid=ceil((l+r)/2);

   if Energy<e(mid)
       r=mid;
   else
       l=mid;
   end
end

%tot=CS(l)+(CS(l+1)-CS(l))/(e(l+1)-e(l))*(Energy-e(l+1));
tot=logloginterp(CS(l),CS(l+1),e(l),e(l+1),Energy);
end

