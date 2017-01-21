%* funkcja do rysowania wykresów
% data - bierze dwie pierwsze kolumny (jako x i y) 
% label - labelki

function dataVisualization(data, label, weights, bias, text)
    firstClass = data(label() == 1, :);
    secondClass =  data(label() == 2, :);
    thirdClass =  data(label() == 3, :);

    figure();
	plot(firstClass(:, 1),  firstClass(:, 2), 'xr', secondClass(:, 1),  secondClass(:, 2), 'xg', thirdClass(:, 1),  thirdClass(:, 2), 'xb');
	grid on;
    title(text);
    legend('show');
    legend({'1 class', '2 class', '3 class'});
    
    for i=1:size(weights)
       plotpc((weights(i,:)), (bias(i)));
    end
axis([-0.5 0.5 -0.5 0.5]);