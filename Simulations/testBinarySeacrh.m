E=11;
x=(1:1:1000).';
left=1;
right=size(x,1);
while left+1<right
   mid=ceil((left+right)/2)

   if E<x(mid)
       right=mid
   else
       left=mid
   end
end

left
right
