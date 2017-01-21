%* funkcja do rysowania wykresów
% data - bierze dwie pierwsze kolumny (jako x i y) 
% label - labelki

function dataVisualization(data, label, name)
    firstClass = data(label(:, 1) == 1, :);
    secondClass =  data(label(:, 1) == 2, :);
    thirdClass =  data(label(:, 1) == 3, :);

    figure();
	plot(firstClass(:, 1),  firstClass(:, 2), 'xr', secondClass(:, 1),  secondClass(:, 2), 'xg', thirdClass(:, 1),  thirdClass(:, 2), 'xb');
	title(name);
