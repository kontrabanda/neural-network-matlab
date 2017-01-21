classdef SingleOutputClassifier < handle
   properties
    classCount = 3
    network
    neuronCount
   end
   methods
       function obj = SingleOutputClassifier()
           readData = load('./networks/single-net.mat');
           obj.network = readData.net;
       end
       
       function result = classify(obj, data)
           classified = round(obj.network(data')');
           [rows, ~] = size(data);
           result = zeros(rows, 1);
           
           for i = 1:rows
               index = find(classified(i, :) == 1, 1);
               
               if(index)
                   result(i, 1) = index;
               else
                   result(i, 1) = 0;
               end               
           end
       end
       
       function displayResult(obj, data, result, text) 
            [all, ~] = size(data);
            correct = (result == data(:, 3));
            disp(sum(correct)/all);
            
            weights = obj.getWeights();
            bias = obj.getBias();
            
            %params = [-weights(:, 1) ./ weights(:, 2)];
            
            dataVisualization(data(:, 1:2), data(:, 3), weights, bias, text);
       end
       
       function result = getWeights(obj)
           result = obj.network.IW{1};
       end
       
       function result = getBias(obj)
           result = obj.network.b{1};
       end
   end
end