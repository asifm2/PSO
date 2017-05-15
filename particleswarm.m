%Particle Swarm Implemtnation for 2 dimension non-linear problem
%By Muhammad Asif 

%%Parameters-----------------------------------------------------------------
numPop = 5;
numVar = 5;
upperBound;
lowerBound;
T = 1000;

LFactor1 = 2;
LFactor2 = 2; 


%%Initialization%------------------------------------------------------------
p=PSOInit(numPop, upperBound, lowerBound); %position vector
v=PSOInit(numPop, upperBound, lowerBound); %velocity vector

pBest = zeros(numPop,numVar); 
gBest = zeros(1, numVar);

pBestVal=zeros(numPop,1); %stores current fitness valiues
gBest = zeros();

%%Exploration%------------------------------------------------------------

%Emulates a do-while loop
pBestVal=PSOFitness(p);
pBest = p;

[sortedMat, sortOrder] = sort(pBestVal 'ascend');
gBestVal = sortedMat(1,1); %Gets the best value

gBest = p(sortOrder(1),:); %Get the location of the best co-ordinate


%update Velocity
v=v+rand(numPop,numVar).*LFactor1.*(pbest-p)+rand(numPop,numVar).*LFactor2.*((repmat(gbest, numVar,1))-p);

p = p+v; %update Position


for i=1:T-1 %%Main Loop
    currentFit = PSOFitness(p);
    
    decisionVector = currentFit<=pBestVal;
    
    pBest = repmat(decisionVector, 1, numVar).p+repmat(decisionVector~=1,1,numVar).*pBest; %Update pBest
    pVal=  decisionVector.*(currentFit)+decisionVector~=1.*(pVal);
    
    [sortedMat, sortOrder] = sort(pVal);
    if sortedMat(1,1)<=gBestVal
        gBestVal = sortedMat(1,1);
        gBest = pBest(sortOrder(1),:) %update gBest position
    end
    
    %update velocity and position
    
    v=v+rand(numPop,numVar).*LFactor1.*(pbest-p)+rand(numPop,numVar).*LFactor2.*((repmat(gbest, numVar,1))-p);
    p = p+v;
    
end


    
    


    
    
    
    
    
    

