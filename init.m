%% *Initialization Function for PSO*
%
% Created May 15 2017
% By Parsa Behestri, adapted for PSO by Muhammad Asif

%% Function I/O
% *Input*:
% 
% * *numPop*: # of solutions the search is started with; determines # of
% rows for data matrix sampleData.
%
% * *numParam*: # of design parameters we are exploring; determines # of
%      columns for data matrix sampleData.
%
% * *upperBound*: row vector representing the upper bound for each
%     parameter in sampleData.
%
% * *lowerBound*: row vector representing the lower bound for each
%     parameter in sampleData.
%
% *Output*:
%
% * *solutionDB*: Data structure of candidate solutions, as well as their
%                   velocities and best locations
%
% * *objValDB*: Data structure of candidate solutions' objective values, as
%           well as their best values so far
%
%
% * *gbest*: Data Structure with swarm's current best objective value and
%               its position

%% Source Code

function [solutionDB, objValDB, gbest] = init(numPop, numParam, upperBound, lowerBound)

    %% 
    % Generates a random number betweeen 0 and 1 in the same size as the
    % sample matrix. 
    
    randMat = rand(numPop,numParam);
    randMat2 = rand(numPop, numParam); %Used for velocites
    
    genData = (repmat((upperBound-lowerBound), numPop, 1) .* randMat) + repmat(lowerBound,  numPop, 1);
    
    velData = (repmat((upperBound-lowerBound), numPop, 1) .* randMat2) + repmat(lowerBound,  numPop, 1);
    
    %%
    % Initializes two structures and a matrix:
    %
    % * *solutionDB*: Candidate solutions;
    % * *objValDB*: Objective Values, scouted count, and best objective
    % values for corresponding candidate solutions;
    
    solutionDB = repmat(struct('x',1,'params',[], 'vel', [], 'bestparams', []), numPop, 1);
    objValDB = repmat(struct('x',1,'objVal',0, 'best', 0),numPop,1);
    gbestDB = struct('val', 0, 'params', []);
    
    %%
    % Inserts generated data into the structures.
    
    %Fitness values have been calculated and placed into data structure.
    for i=1:numPop
        solutionDB(i).x = i;
        solutionDB(i).params = genData(i,:);
        solutionDB(i).bestparams = genData(i,:);
        solutionDB(i).vel = velData(i,:);
        
        objValDB(i).x = i;
        objValDB(i).objVal = PSOfun(genData(i,:));
        objValDB(i).best = objValDB(i).objVal;
    end
    
    %%
    % gbestDB keeps track of the value and position of the best overall
    % swarm position
    
    [gbestDB.val, minIndex] = min(objValDB.best); %gets the minimum value
    gbestDB.params = solutionDB(minIndex).params; %minimum value location
    
    
    
    
    
end


