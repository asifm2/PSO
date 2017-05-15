%Particle Swarm Implemtnation for n dimension optimization problem
%By Muhammad Asif 

clearvars;
%%Parameters-----------------------------------------------------------------
numPop = 10;
numVar = 2;
upperBound =  [2 2];
lowerBound =  [-2 -2];
T = 50;

LFactor1 = 2;
LFactor2 = 2; 


%%Initialization%------------------------------------------------------------
p=PSOInit(numPop, upperBound, lowerBound); %position vector
v=PSOInit(numPop, upperBound, lowerBound); %velocity vector

pBest = zeros(numPop,numVar); 
gBest = zeros(1, numVar);

pBestVal=zeros(numPop,1); %stores current fitness valiues
gBestVal = zeros(1,1);

v = zeros(numPop, numVar);

%%Exploration%------------------------------------------------------------

%Emulates a do-while loop
pBestVal=PSOFitness(p);
pBest = p;

[sortedMat, sortOrder] = sort(pBestVal);
gBestVal = sortedMat(1,1); %Gets the best value
gBest = p(sortOrder(1),:); %Get the location of the best co-ordinate


%update Velocity
%v=v+rand(numPop,numVar).*LFactor1.*(pBest-p)+rand(numPop,numVar).*LFactor2.*((repmat(gBest, numPop,1))-p);

v = rand(numPop,numVar).*repmat(upperBound-lowerBound,numPop,1)+repmat(lowerBound, numPop, 1);


for i=1:T-1 %%Main Loop
    
    %update velocity and position
    %gbest needs to repmatted because it is only a vector
    
    v=v+rand(numPop,numVar).*LFactor1.*(pBest-p)+rand(numPop,numVar).*LFactor2.*((repmat(gBest, numPop,1))-p);
    p = p+v; %ezZZZZZZZZZZ
    
    
    currentFit = PSOFitness(p);
    
    %Assuming minimum optimization is desired
    decisionVector = currentFit<=pBestVal;
    
    pBest = repmat(decisionVector, 1, numVar).*p+repmat(decisionVector~=1,1,numVar).*pBest; %Update pBest
    pBestVal=  decisionVector.*(currentFit)+decisionVector~=1.*(pBestVal);
    
    [sortedMat, sortOrder] = sort(pBestVal);
    if sortedMat(1,1)<=gBestVal
        gBestVal = sortedMat(1,1);
        gBest = pBest(sortOrder(1),:) ;%update gBest position
    end
    
  
    
    
    
    disp(gBestVal);
    disp(i);
    
end


    
    


    
    
    
    
    
    

