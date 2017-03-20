clc;clear;close all;
load data/shape-model.mat
vid=videoinput('winvideo',1);
string='None';
while 1
    frame=getsnapshot(div);
    [className, score] = classify(model, frame);
    string=['shape: ',className];
    RGB = insertText(frame,[20,20],string,'FontSize',44);
    imshow(RGB);
end
