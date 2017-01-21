%* funkcja do centralizacji danych wejściowych
% ostatnia kolumna traktowana jako labelka!!!

function result = centralizedData(data)
    [~, columns] = size(data);
    
    result = data;
    
    for i=1:(columns - 1)
        meanValue = mean(data(:, i));
        
        result(:, i) = data(:, i) - meanValue;
    end