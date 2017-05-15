%% Particle Swarm Optimization
% A collaborative effort by Muhammad Asif and Parsa Behesti
%
% Created on May 15 2017

%% Source Code


%% Constants

numPop = 10;
numParam = 2;

upperBound = [1 1];
lowerBound = [-1 -1];

%% Used for updating position and velocity, can be tuned depending on the problem
lfactor1= 2;
lfactor2 = 2;

%% Initialization

[solutionDB, objValDB, gbestDB] = init(numPop, numParam, upperBound, lowerBound);

%% Loop

while (1>0) %TO BE REPLACED
    
    %% Update Particle Velocity using lfactors and RNG.
        randmat = rand(numPop, numParam);
        
        solutionDB.vel = solutionDB.vel+ lfactor1.*randmat.*(solutionDB.bestparams-solutionDB.params)+ lfactor2.*randmat.*(repmat(gbestDB.params, numPop, 1)-solutionDB.params);
        
        %% Clamp Velocity values to upperbound and lowerbound. 
        %
        % * Values which are above upperBound are clamped to upperBound
        % * Values which are below lowerBound are clamped to lowerBound
        % * Values which are in the correct region remain unchanged
        
        decisionMatrixUp = solutionDB.vel>repmat(upperBound,numPop,1); %Elements that are too big correspond to ones in this Decision Matrix
        decisionMatrixLow =solutionDB.vel<repmat(lowerBound, numPop,1); %Elements that are too small corresponds to ones in this Decision Matrix
        
        decisionMatrixUnchanged = decisionMatrixUp | decisionMatrixLow;
        decisionMatrixUnchanged = decisonMatrixUnchanged~=1;
        
        
        
        solutionDB.vel = decisionMatrixUp.*repmat(upperBound, numPop,1)+decisionMatrixLow.*repmat(lowerBound, numPop, 1) +decisionMatrixUnchanged.*(solutionDB.vel);
                         
        %% Update Particle Position
        
        solutionDB.params = solutionDB.params+solutionDB.vel;
        
        %% Update Particle Objective Values
        
        for i= 1:numPop
            objValDB(i).objVal = PSOfun(solutionDB.params(i,:));
        end
        
        %% Update Particle  Best Values
        
        decisionMatrix = objValDB.objVal<objValDB.best;
        
        objValDB.best = decisionMatrix.*(objValDB.objVal)+~decisionMatrix.*(objValDB.best);
        
        
        %% Update Particle Best Positions
        
        solutionDB.bestparams = repmat(decisionMatrix, 1, numParam).*(solutionDB.params)+repmat(~decisionMatrix, 1, numParam).*(solutionDB.bestparams);
        
        %% Update Global Best Value and Position
        
        [gbestDB.val, minIndex] = min(objValDB.best); %gets the minimum value
        gbestDB.params = solutionDB(minIndex).params; %minimum value location
        
        
end
                         
      
                         
                         
    
        
        

