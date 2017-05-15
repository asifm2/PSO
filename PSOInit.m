function output = PSOInit(numPop, upperBound, lowerBound)

numVar = length(upperBound); %Number of variables

output = rand(numPop,numVar).*repmat(upperBound-lowerBound,numPop,1)+repmat(lowerBound, numPop, 1); 

end


%Initialize positions, velocities randomly for numPop objects of interest
%UpperBound and LowerBound are 1 by m vectors