% 3x3 matrix
img = [10 20 30; 
       40 50 60; 
       70 80 90];
  
% Display the random matrix
disp('3x3 matrix:');
disp(img);

% Initialize N4 connectivity matrix with zeros
N4_matrix = zeros(3,3);

% Center pixel coordinates
r = 2;
c = 2;

% N4 neighbors
N4_coords = [r-1, c; r+1, c; r, c-1; r, c+1];

% Mark N4 neighbors in N4_matrix
for i = 1:size(N4_coords,1)
    N4_matrix(N4_coords(i,1), N4_coords(i,2)) = 1;
end

% Mark center pixel as 4
N4_matrix(r,c) = 4;

% Display N4 connectivity matrix
disp('N4 connectivity matrix (4=center, 1=neighbors):');
disp(N4_matrix);




% Initialize N8 connectivity matrix with zeros
N8_matrix = zeros(3,3);

% N8 neighbors: N4 + diagonals
N8_coords = [
    r-1, c;     % up
    r+1, c;     % down
    r, c-1;     % left
    r, c+1;     % right
    r-1, c-1;   % up-left diagonal
    r-1, c+1;   % up-right diagonal
    r+1, c-1;   % down-left diagonal
    r+1, c+1    % down-right diagonal
];

% Mark N8 neighbors in N8_matrix
for i = 1:size(N8_coords,1)
    N8_matrix(N8_coords(i,1), N8_coords(i,2)) = 1;
end

% Mark center pixel as 8
N8_matrix(r, c) = 8;

% Display N8 connectivity matrix
disp('N8 connectivity matrix (8=center, 1=neighbors):');
disp(N8_matrix);
