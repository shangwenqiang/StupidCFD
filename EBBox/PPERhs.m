% ## Copyright (C) 2013 homu
% ## 
% ## This program is free software; you can redistribute it and/or modify
% ## it under the terms of the GNU General Public License as published by
% ## the Free Software Foundation; either version 3 of the License, or
% ## (at your option) any later version.
% ## 
% ## This program is distributed in the hope that it will be useful,
% ## but WITHOUT ANY WARRANTY; without even the implied warranty of
% ## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% ## GNU General Public License for more details.
% ## 
% ## You should have received a copy of the GNU General Public License
% ## along with Octave; see the file COPYING.  If not, see
% ## <http://www.gnu.org/licenses/>.

% ## PPERhs

% ## Author: homu <homu@HOMU-PC>
% ## Created: 2013-08-07

function [ rhs ] = PPERhs (ustar,vstar,nx,ny,dx,dy,dt)

EBGlobals;

I = 2:nx+1;
J = 2:ny+1;
divu = 1/dx*(ustar(I+1,J)-ustar(I,J)) + 1/dy*(vstar(I,J+1)-vstar(I,J));
rhs = -1/dt * rho * divu;

% BC correction
rhs(nx,1:ny) = rhs(nx,1:ny) + 1/dx^2 * POut;

% return as a vector
rhs = reshape(rhs,nx*ny,1);
return
end
