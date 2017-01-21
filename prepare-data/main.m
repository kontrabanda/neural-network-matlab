% POBRANIE DANYCH

fileName = '../../resource/data/K_33.txt';
data = inputDataGetter(fileName);

disp(size(data))

%dataVisualization(data(:, 1:2), data(:, 5), 'v1 - v2');
%dataVisualization(data(:, [1 3]), data(:, 5), 'v1 - v3');
%dataVisualization(data(:, [1 4]), data(:, 5), 'v1 - v4');
%dataVisualization(data(:, 2:3), data(:, 5), 'v2 - v3');
%dataVisualization(data(:, [2 4]), data(:, 5), 'v2 - v4');
%dataVisualization(data(:, 3:4), data(:, 5), 'v3 - v4');

%sum(data(:, 5) == 1)
%sum(data(:, 5) == 2)
%sum(data(:, 5) == 3)

% PODZIAL DANYCH NA UCZACE I TESTOWE

dividedData = divisionData(data);

train = dividedData.train;
test = dividedData.test;

%dataVisualization(train(:, 1:2), train(:, 5), 'train: v1 - v2');
%dataVisualization(test(:, 1:2), test(:, 5), 'test: v1 - v2');

% NORMALIZACJA DANYCH

trainNorm = dataNormalization(train);
testNorm = dataNormalization(test);

%dataVisualization(trainNorm(:, 1:2), trainNorm(:, 5), 'trainNorm: v1 - v2');
%dataVisualization(testNorm(:, 1:2), testNorm(:, 5), 'testNorm: v1 - v2');


% CENTRALIZACJA DANYCH

trainCent = centralizedData(trainNorm);
testCent = centralizedData(testNorm);

%dataVisualization(trainCent(:, 1:2), trainCent(:, 5), 'trainCent: v1 - v2');
%dataVisualization(testCent(:, 1:2), testCent(:, 5), 'testCent: v1 - v2');


% REDUKCJA WYMIARÓW WEJŚCIOWYCH

dimensions = getDimensions(trainCent);
disp(dimensions)
trainFinal = trainCent(:, dimensions);
testFinal = testCent(:, dimensions);

%dataVisualization(trainFinal(:, 1:2), trainFinal(:, 3), 'trainFinal: v1 - v2');
%dataVisualization(testFinal(:, 1:2), testFinal(:, 3), 'testFinal: v1 - v2');

% ZAPISANIE DANYCH

%saveData(trainFinal, testFinal);















