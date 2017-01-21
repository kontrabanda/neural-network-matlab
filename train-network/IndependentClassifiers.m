classdef IndependentClassifiers < handle
   properties
    classCount = 3
    networks
    neuronCount
   end
   methods
       function obj = IndependentClassifiers()
           obj.neuronCount(1) = 4;
           obj.neuronCount(2) = 5;
           obj.neuronCount(3) = 6;
       end
       
       function trainNetwork(obj, trainData)
        for i = 1:obj.classCount
            currentLabels = trainData(:, 3) == i;
            [net] = train_net(trainData(:, 1:2), currentLabels, obj.neuronCount(i));
            obj.networks(i).net = net;
        end
       end
       
       function result = getNetworks(obj)
        result = obj.networks;
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
               
               textExt = strcat(text, ' class: ', num2str(i));
               dataVisualization(data(:, 1:2), data(:, 3), weights, bias, textExt);
           end
       end
       
       function save(obj)
           for i = 1:obj.classCount
               weights = obj.networks(i).net.IW{1};
               bias  = obj.networks(i).net.b{1};
               params = [weights bias];
               
               fileName = strcat('./weights/independent-weights-class-', num2str(i), '.txt');
               save(fileName, 'params', '-ascii');
               
               net = obj.networks(i);
               fileName = strcat('./networks/independent-net-class-', num2str(i), '.mat');
               save(fileName, 'net')
           end
           
           
       end
   end
end