clc;close;clear;
rootFolder = '3Dshape/';
categories ={'ball','banana','bottle','pillow','pyramid','none'};


%将训练数据存为imds
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
%统计每类样本的数量
tbl = countEachLabel(imds);

%选取样本数量最少的一类
minSetCount = min(tbl{:,2}); 

%随机选择每类的数量等于最小数目
imds = splitEachLabel(imds, minSetCount, 'randomize');

countEachLabel(imds);
net = alexnet();
% net.Layers;
% net.Layers(1);
% net.Layers(end);

numel(net.Layers(end).ClassNames);
imds.ReadFcn = @(filename)readAndPreprocessImage(filename);
%   30%用于训练，其余用来验证
[trainingSet, testSet] = splitEachLabel(imds, 0.3, 'randomize');


% 第二层权重可视化
w1 = net.Layers(2).Weights;
% Scale and resize the weights for visualization
w1 = mat2gray(w1);
w1 = imresize(w1,5);
figure;
montage(w1);
title('First convolutional layer weights');
featureLayer = 'fc7';
trainingFeatures = activations(net, trainingSet, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');
% 获取训练的标签
trainingLabels = trainingSet.Labels;

%利用线性SVM训练分类器
classifier = fitcecoc(trainingFeatures, trainingLabels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');
% 提取测试的CNN特征
% testFeatures = activations(net, testSet, featureLayer, 'MiniBatchSize',32);

%  预测
% predictedLabels = predict(classifier, testFeatures);
% 
% testLabels = testSet.Labels;
% confMat = confusionmat(testLabels, predictedLabels);
% %转化为百分比
% confMat = bsxfun(@rdivide,confMat,sum(confMat,2));
% precision=mean(diag(confMat));
% disp(precision);
