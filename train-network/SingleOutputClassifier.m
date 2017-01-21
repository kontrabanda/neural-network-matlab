classdef SingleOutputClassifier < handle
   properties
    classCount = 3
    network
    neuronCount
   end
   methods
       function obj = SingleOutputClassifier(neuronCount)
           obj.neuronCount = neuronCount;
       end
       
       function result = prepareLabels(obj, labels) 
           [rows, ~] = size(labels);
           result = zeros(rows, obj.classCount);
           
           for i = 1:rows
               result(i, labels(i, 1)) = 1;
           end
       end
       
       function trainNetwork(obj, trainData)
            train_set = trainData(:, 1:2);
            labels = obj.prepareLabels(trainData(:, 3));
            hidden_neurons_count = obj.neuronCount;
            
            net=newff(train_set',labels',hidden_neurons_count,...
              {'tansig', 'purelin'},'traingd');
          
            rand('state',sum(100 * clock));
            net.layers{2}.size = 3;
            
            
            net=init(net);
            net.trainParam.goal = 0.01;
            net.trainParam.epochs = 100;
            net.trainParam.showWindow = false;
            net=train(net, train_set', labels');

            net.trainFcn = 'trainlm';
            net.trainParam.goal = 0.01;
            net.trainParam.epochs = 200;
            net.trainParam.showWindow = false;
            
            view(net)
            
            obj.network = train(net, train_set', labels');
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
            
            dataVisualization(data(:, 1:2), data(:, 3), weights, bias, text);
       end
       
       function result = getWeights(obj)
           result = obj.network.IW{1};
       end
       
       function result = getBias(obj)
           result = obj.network.b{1};
       end
       
       function save(obj)
          weights = obj.getWeights();
          bias = obj.getBias();
          
          params = [weights bias];
          save('./weights/single-weights.txt', 'params', '-ascii');
          
          net = obj.network;
          save('./networks/single-net.mat', 'net');
       end
   end
end