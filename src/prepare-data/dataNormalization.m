%* funkcja do normalizacji danych wejściowych
% ostania kolumnę traktuję jak labelkę!!!!

function result = dataNormalization(data)
    [~, columns] = size(data);
    
    result = data;
    
    for i=1:(columns - 1)
        maxValue = max(data(:, i));
        minValue = min(data(:, i));
        
        result(:, i) = (data(:, i) - minValue)/(maxValue - minValue);
    end