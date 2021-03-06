
function [ Lap, rb ] = MakeLap2D(nx,ny,dx,dy, bctype,bcval)
%

bc_neu = 0;
bc_dir = 1;
bc_per = 2;

rdx = 1/dx;
rdy = 1/dy;
rdx2 = 1/dx^2;
rdy2 = 1/dy^2;

np = nx * ny;
nbuf = np * 5;

ind = reshape(1:np, nx,ny);
tuples = [];
rb = zeros(np,1);

for j = 1:ny
for i = 1:nx
    idx = ind(i,j);
    aa = 0;
    
    if i > 1
        cc = rdx2;
        aa = aa - cc;
        tuples(end+1,:) = [ idx, ind(i-1,j), cc];
    elseif bctype(1,1) == bc_per
        cc = rdx2;
        aa = aa - cc;
        tuples(end+1,:) = [ idx, ind(nx,j), cc];
    elseif bctype(1,1) == bc_neu
        rb(idx) = rb(idx) - bcval(1,1)*rdx;
    elseif bctype(1,1) == bc_dir
        cc = 2*rdx2;
        aa = aa - cc;
        rb(idx) = rb(idx) + bcval(1,1)*cc;
    end
    
    if i < nx
        cc = rdx2;
        aa = aa - cc;
        tuples(end+1,:) = [ idx, ind(i+1,j), cc];
    elseif bctype(1,2) == bc_per
        cc = rdx2;
        aa = aa - cc;
        tuples(end+1,:) = [ idx, ind(1,j), cc];
    elseif bctype(1,2) == bc_neu
        rb(idx) = rb(idx) + bcval(1,2)*rdx;
    elseif bctype(1,2) == bc_dir
        cc = 2*rdx2;
        aa = aa - cc;
        rb(idx) = rb(idx) + bcval(1,2)*cc;
    end
    
    if j > 1
        cc = rdy2;
        aa = aa - cc;
        tuples(end+1,:) = [ idx, ind(i,j-1), cc ];
    elseif bctype(2,1) == bc_per
        cc = rdy2;
        aa = aa - cc;
        tuples(end+1,:) = [ idx, ind(i,ny), cc ];
    elseif bctype(2,1) == bc_neu
        rb(idx) = rb(idx) - bcval(2,1)*rdy;
    elseif bctype(2,1) == bc_dir
        cc = 2*rdy2;
        aa = aa - cc;
        rb(idx) = rb(idx) + bcval(2,1)*cc;
    end
    
    if j < ny
        cc = rdy2;
        aa = aa - cc;
        tuples(end+1,:) = [ idx, ind(i,j+1), cc ];
    elseif bctype(2,2) == bc_per
        cc = rdy2;
        aa = aa - cc;
        tuples(end+1,:) = [ idx, ind(i,1), cc ];
    elseif bctype(2,2) == bc_neu
        rb(idx) = rb(idx) + bcval(2,2)*rdy;
    elseif bctype(2,2) == bc_dir
        cc = 2*rdy2;
        aa = aa - cc;
        rb(idx) = rb(idx) + bcval(2,2)*cc;
    end
    
    % diag
    tuples(end+1,:) = [ idx, idx, aa ];
end
end

Lap = sparse(tuples(:,1), tuples(:,2), tuples(:,3), np,np);

return
end


