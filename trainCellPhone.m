clc;clear;

% 导入标记的正样本
load('CellPhone.mat');

positiveInstances =CellPhone(:,1:2);
%%
% 加入图片路径
imDir ='~/work/ShapeRecognition/phone';
addpath(imDir);
%%
% 
negativeFolder = fullfile(imDir,'neg');
%读取负样本图片
negativeImages = imageDatastore(negativeFolder);
%%
% Train a cascade object detector called 'stopSignDetector.xml'
% using HOG features.
% NOTE: The command can take several minutes to run.
% trainCascadeObjectDetector('stopSignDetector.xml',positiveInstances, ...
%     negativeFolder,'FalseAlarmRate',0.1,'NumCascadeStages',5);

trainCascadeObjectDetector('CellPhoneDetector.xml',positiveInstances,negativeFolder,...
'FalseAlarmRate',0.05,'NumCascadeStages',4);

%%
detector = vision.CascadeObjectDetector('CellPhoneDetector.xml');
%%
% Read the test image.
img = imread('phone/pos/69.png');
%%
% Detect a stop sign.
bbox = step(detector,img); 
%%
% Insert bounding box rectangles and return the marked image.
 detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'CellPhone');
%%
% Display the detected stop sign.
figure; imshow(detectedImg);
%%
% Remove the image directory from the path.
rmpath(imDir); 