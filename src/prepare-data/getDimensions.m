%* funkcja wybierając dwie najbardziej istotne zmienne wejściowe
%  ostatnia kolumna to labelka!!!

function result = getDimensions(data)
    ranking = var_selection(data);
    disp(ranking)
    firstValue = ranking(1, 1);
    secondValue = ranking(1, 2);
    
    result = [firstValue secondValue 5];