function [L,U,P] = luFactor(A)
%luFactor generates the L, U, and P matrixes needed to use LuDecomposition
%Connor Worrell - Hw15
%
%Inputs:
%   A - Square coefficient matrix to solve
%Outputs:
%   L - Lower triangular matrix which holds multipliers used
%   U - Upper triangular matrix which holds modified matrix
%   P - Pivot matrix which holds how partial pivots were used

if(nargin~=1)
    error('input must be a 1 square matrix');
end

[n, m] = size(A);
if(n ~= m)
    error('input must be a square matrix');
end

P = eye(length(A));%Define Initial pivot matrix
U = A;%define initial matrixes used
L = zeros(3,3);

for rideth = 2:length(U)%rideth is the ammount to the right that the current operation is occuring on
    
    %Pivot code
    [~, Inde] = max(abs(U(rideth-1:length(U),rideth-1)));%find largest number in current opperating collum
    Inde = Inde + rideth-2;%correct for collumb height ie: collum starts at row 2 and ends at row 4
    if(Inde ~= rideth-1)%if highest number is at the top of the opperating collumb
        TempA = U(Inde,:);%pivot working matrix
        U(Inde,:)= U(rideth-1,:);
        U(rideth-1,:) = TempA;
        
        TempP = P(Inde,:);%pivot Pivot matrix
        P(Inde,:)= P(rideth-1,:);
        P(rideth-1,:) = TempP;
        
        TempL=L(Inde,:);%pivot L matrix
        L(Inde,:)=L(rideth-1,:);
        L(rideth-1,:)=TempL;
    end
    
    for depth = rideth:length(U)
        Mult = (U(depth,rideth-1)/U(rideth-1,rideth-1));%calculate multiplication factor for row
        U(depth,:) = U(depth,:)-U(rideth-1,:).*Mult;%multiply and subtract working row
        
        L(depth,rideth-1) = Mult;%keep track of mult in the L matrix
        
    end
end

for Wideth = 1:length(L)%add diagonal of ones to L
    L(Wideth,Wideth)=1;
end

if(L*U ~= P*A)%check to see if L*U is the same as P*A
    error('something went wrong');
end

end

