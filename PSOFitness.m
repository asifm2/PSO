function fitness = PSOFitness(p)

%Evaluates objective function for each particle and returns a column vector
%p is a matrix, where each row represents the position of a particular particle

rb =@(x) (1-x(1))^2+100*(x(2)-x(1)^2)^2; %objective function

numPop = size(p,1);
fitness = zeros(numPop,1);

for i= 1:numPop
    fitness(i,1)= rb(p(i,:));
end




