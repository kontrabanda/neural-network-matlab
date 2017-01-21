%* funkcja do podziału danych na zbiór uczący i testowy
% zwraca struktórę z polami train i test

function result = divisionData(data)
    [rows, ~] = size(data);
    
    randomIndexes = randperm(rows)';
    trainIndexesCount = round(rows/2);
    
    result.train = data(randomIndexes(1:trainIndexesCount, :), :);
    result.test = data(randomIndexes((trainIndexesCount+1):end, :), :);