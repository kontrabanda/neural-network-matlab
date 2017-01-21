classdef QualityCheck < handle
    properties
        class
        TP
        FP
        TN
        FN
        unclassified
    end
    methods
        function obj = QualityCheck(class, data, result)
            obj.class = class;
            obj.setTP(data, result);
            obj.setFP(data, result);
            obj.setTN(data, result);
            obj.setFN(data, result);
            obj.setUnclassified(result);
        end
        
        function setTP(obj, data, result)
            mask = data(:, 3) == obj.class & result == data(:, 3) & result ~= 0; 
            obj.TP = sum(mask);
        end
        
        function setFP(obj, data, result)
            mask = data(:, 3) ~= obj.class & result ~= data(:, 3) & result ~= 0;
            obj.FP = sum(mask);
        end
        
        function setTN(obj, data, result)
            mask = data(:, 3) ~= obj.class & result == data(:, 3) & result ~= 0;
            obj.TN = sum(mask);
        end
        
        function setFN(obj, data, result)
            mask = data(:, 3) == obj.class & result ~= data(:, 3) & result ~= 0;
            obj.FN = sum(mask);
        end
        
        function setUnclassified(obj, result)
            mask = result == 0;
            obj.unclassified = sum(mask);
        end
        
        function result = getP(obj)
            result = obj.TP + obj.FN;
        end
        
        function result = getN(obj)
            result = obj.FP + obj.TN;
        end
        
        function result = getTPRate(obj)
            result = obj.TP/obj.getP();
        end
        
        function result = getFPRate(obj)
            result = obj.FP/obj.getN();
        end
        
        function result = getPrecision(obj)
            result = obj.TP/(obj.TP + obj.FP);
        end
        
        function result = getAccuracy(obj)
            result = (obj.TP + obj.TN)/(obj.getP() + obj.getN());
        end
        
        function result = getSpecificity(obj)
            result = obj.TN/(obj.FP + obj.TN);
        end
        
        function disp(obj)
            text = strcat('Unclassified: ', num2str(obj.unclassified));
            disp(text);
            
            text = strcat('SUM: ', num2str(obj.getP() + obj.getN()));
            disp(text);
            
            text = strcat('P: ', num2str(obj.getP()),...
                ', N: ', num2str(obj.getN()));
            disp(text);
            
            text = strcat(...
                'TP: ', num2str(obj.TP),...
                ', FP: ', num2str(obj.FP),...
                ', TN: ', num2str(obj.TN),...
                ', FN: ', num2str(obj.FN));
            disp(text);
            
            disp(strcat('tp rate: ', num2str(obj.getTPRate())));
            disp(strcat('fp rate: ', num2str(obj.getFPRate())));
            disp(strcat('precision: ', num2str(obj.getPrecision())));
            disp(strcat('accuracy: ', num2str(obj.getAccuracy())));
            disp(strcat('specificity: ', num2str(obj.getSpecificity())));
        end
    end
end