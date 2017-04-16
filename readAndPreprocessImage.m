function Iout = readAndPreprocessImage(filename)
    %将图片大小置为AlexNet的输入大小
    I = imread(filename);

   
    if ismatrix(I)
        I = cat(3,I,I,I);
    end


    Iout = imresize(I, [227 227]);
end