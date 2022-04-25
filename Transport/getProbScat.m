function [ prob ] = getProbScat ( Energy, e, TCS, ECS )
%lineáris interpolációval meghatározza a
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

%tot=TCS(l)+(TCS(l+1)-TCS(l))/(e(l+1)-e(l))*(Energy-e(l+1));
tot=logloginterp(TCS(l),TCS(l+1),e(l),e(l+1),Energy);

%es=ECS(l)+(ECS(l+1)-ECS(l))/(e(l+1)-e(l))*(Energy-e(l+1));
es=logloginterp(ECS(l),ECS(l+1),e(l),e(l+1),Energy);

prob=es/tot;

end

