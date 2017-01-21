classdef IndependentClassifiers < handle
   properties
    classCount = 3
    networks
    neuronCount
   end
   methods
       function obj = IndependentClassifiers()
           for i = 1:obj.classCount
               fileName = strcat('./networks/independent-net-class-', num2str(i), '.mat');
               readData = load(fileName);
               net = readData.net.net;
               
               obj.networks(i).net = net;
           end
       end

       function result = classify(obj, data)
           mask = zeros(size(data(:, 1)));
           
           for i = 1:obj.classCount
               net = obj.networks(i).net;
               labels(i).value = round(net(data')');
               % aby wyeliminowac podwojnie sklasyfikowane elementy
               mask = mask + labels(i).value;
           end
           
           % mask == 0 - nieprzyporzadkowane
           % mask == 1 - przyporzadkowane poprawnie
           % mask > 1 - przyporzadkowane kilkakrotnie
           
           correctIndexes = (mask == 1);
           result = zeros(size(data(:, 1)));
           
           for i = 1:obj.classCount
              labels(i).value = labels(i).value .* correctIndexes * i;
              result = result + labels(i).value;
           end
       end
       
       function displayResult(obj, data, result, text) 
            [all, ~] = size(data);
            correct = (result == data(:, 3));

            disp(sum(correct)/all);
            obj.drawNetworkPlot(data, text);
       end
       
       function drawNetworkPlot(obj, data, text)
           for i = 1:obj.classCount
               net = obj.networks(i).net;
               
               weights = net.IW{1};
               bias = net.b{1};
               
               %params = [-weights(:, 1) ./ weights(:, 2), -bias ./ weights(:, 2)];
               textExt = strcat(text, ' class: ', num2str(i));
               dataVisualization(data(:, 1:2), data(:, 3), weights, bias, textExt);
           end
       end
   end
end