function [ dist ] = getDistToSphere( R, r0, n0 )

dist=-r0*n0'-sqrt((r0*n0')^2-(r0*r0'-R^2));

end

