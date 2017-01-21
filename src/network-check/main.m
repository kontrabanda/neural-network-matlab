trainData = load('../../resource/data/train.txt');
testData = load('../../resource/data/test.txt');

independentClassifiers = IndependentClassifiers();
result = independentClassifiers.classify(testData(:, 1:2));
independentClassifiers.displayResult(testData, result, 'TEST - ind');

singleOutputClassifier = SingleOutputClassifier();
%result = singleOutputClassifier.classify(testData(:, 1:2));
%singleOutputClassifier.displayResult(testData, result, 'TEST - sing');

disp('ONE');
checkOne = QualityCheck(1, testData, result);
checkOne.disp();

disp('TWO');
checkTwo = QualityCheck(2, testData, result);
checkTwo.disp();

disp('THREE');
checkThree = QualityCheck(3, testData, result);
checkThree.disp();