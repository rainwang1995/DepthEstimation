function im= standarizeImage( im )
%STANDARIZEIMAGE 此处显示有关此函数的摘要
%   此处显示详细说明

im = im2single(im) ;
if size(im,1) > 480, im = imresize(im, [480 NaN]) ; end

end

