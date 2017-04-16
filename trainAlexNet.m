clc;close;clear;
rootFolder = '3Dshape/';
categories ={'ball','banana','bottle','pillow','pyramid','none'};


%��ѵ�����ݴ�Ϊimds
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
%ͳ��ÿ������������
tbl = countEachLabel(imds);

%ѡȡ�����������ٵ�һ��
minSetCount = min(tbl{:,2}); 

%���ѡ��ÿ�������������С��Ŀ
imds = splitEachLabel(imds, minSetCount, 'randomize');

countEachLabel(imds);
net = alexnet();
% net.Layers;
% net.Layers(1);
% net.Layers(end);

numel(net.Layers(end).ClassNames);
imds.ReadFcn = @(filename)readAndPreprocessImage(filename);
%   30%����ѵ��������������֤
[trainingSet, testSet] = splitEachLabel(imds, 0.3, 'randomize');


% �ڶ���Ȩ�ؿ��ӻ�
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
% ��ȡѵ���ı�ǩ
trainingLabels = trainingSet.Labels;

%��������SVMѵ��������
classifier = fitcecoc(trainingFeatures, trainingLabels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');
% ��ȡ���Ե�CNN����
% testFeatures = activations(net, testSet, featureLayer, 'MiniBatchSize',32);

%  Ԥ��
% predictedLabels = predict(classifier, testFeatures);
% 
% testLabels = testSet.Labels;
% confMat = confusionmat(testLabels, predictedLabels);
% %ת��Ϊ�ٷֱ�
% confMat = bsxfun(@rdivide,confMat,sum(confMat,2));
% precision=mean(diag(confMat));
% disp(precision);
