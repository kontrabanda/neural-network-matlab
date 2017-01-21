% POBRANIE DANYCH UCZACYCH
trainData = load('../../resource/data/train.txt');
testData = load('../../resource/data/test.txt');

% INDEPENDENT CLASSIFIER
independentClassifiers = IndependentClassifiers();
independentClassifiers.trainNetwork(trainData);

disp('INDEPENDENT: train data');
result = independentClassifiers.classify(trainData(:, 1:2));
%independentClassifiers.displayResult(trainData, result, 'independent: train data');
temp1 = zeros(10, 1);
temp2 = zeros(10, 1);
temp3 = zeros(10, 1);

test1 = zeros(10, 1);
test2 = zeros(10, 1);
test3 = zeros(10, 1);

%{
for i=1:10
    independentClassifiers.trainNetwork(trainData);
    result = independentClassifiers.classify(trainData(:, 1:2));

    correct1 = (result == trainData(:, 3) & result == 1);
    correct2 = (result == trainData(:, 3) & result == 2);
    correct3 = (result == trainData(:, 3) & result == 3);
    
    temp1(i) = sum(correct1)/sum(trainData(:, 3) == 1);
    temp2(i) = sum(correct2)/sum(trainData(:, 3) == 2);
    temp3(i) = sum(correct3)/sum(trainData(:, 3) == 3);
    
    result = independentClassifiers.classify(testData(:, 1:2));

    correct1 = (result == testData(:, 3) & result == 1);
    correct2 = (result == testData(:, 3) & result == 2);
    correct3 = (result == testData(:, 3) & result == 3);
    
    test1(i) = sum(correct1)/sum(testData(:, 3) == 1);
    test2(i) = sum(correct2)/sum(testData(:, 3) == 2);
    test3(i) = sum(correct3)/sum(testData(:, 3) == 3);
    
    temp2(i) = sum(correct)/all;
end

disp(sum(temp1)/10);
disp(sum(temp2)/10);
disp(sum(temp3)/10);

disp(sum(test1)/10);
disp(sum(test2)/10);
disp(sum(test3)/10);
%}
disp('INDEPENDENT: test data');
result = independentClassifiers.classify(testData(:, 1:2));
independentClassifiers.displayResult(testData, result, 'independent: test data');

%wyłapanie najlepszego klasyfikatora (klasyfikatory binarne)

%{
curr = 0;
[all, ~] = size(trainData);

for i = 1:10
    independentClassifiers.trainNetwork(trainData);
    result = independentClassifiers.classify(trainData(:, 1:2));
    
    correct = sum(result == trainData(:, 3))/all;
    
    
    if correct > curr
        curr = correct;
        independentClassifiers.save();
    end
end

disp(curr)
%}
% SINGLE CLASSIFIER
singleOutputClassifier = SingleOutputClassifier(5);
%singleOutputClassifier.trainNetwork(trainData);



disp('SINGLE: TRAIN DATA');
temp1 = zeros(10, 1);
temp2 = zeros(10, 1);

%{
for i=1:10
    singleOutputClassifier.trainNetwork(trainData);
    result = singleOutputClassifier.classify(trainData(:, 1:2));
    [all, ~] = size(trainData);
    correct = (result == trainData(:, 3));
    temp1(i) = sum(correct)/all;
    result = singleOutputClassifier.classify(testData(:, 1:2));
    [all, ~] = size(testData);
    correct = (result == testData(:, 3));
    temp2(i) = sum(correct)/all;
end
disp(sum(temp1)/10);
disp(sum(temp2)/10);
%}
%singleOutputClassifier.displayResult(trainData, result, 'single: train data');

%{
curr = 0;
[all, ~] = size(trainData);

for i = 1:10
    singleOutputClassifier.trainNetwork(trainData);
    result = singleOutputClassifier.classify(trainData(:, 1:2));
    
    correct = sum(result == trainData(:, 3))/all;
    
    
    if correct > curr
        curr = correct;
        singleOutputClassifier.save();
    end
end

disp(curr)
%}
disp('SINGLE: TEST DATA');
%result = singleOutputClassifier.classify(testData(:, 1:2));
%singleOutputClassifier.displayResult(testData, result, 'single: test data');

% SAVE WEIGHTS
%singleOutputClassifier.save();
%independentClassifiers.save();
