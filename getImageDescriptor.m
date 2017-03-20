function hist = getImageDescriptor(model, im)   %获得hist描述子（就是每个K-means分类后不同的类别 到底有几个！）
% -------------------------------------------------------------------------

im = standarizeImage(im) ;
width = size(im,2) ;
height = size(im,1) ;
numWords = size(model.vocab, 2) ;

% get PHOW features
[frames, descrs] = vl_phow(im, model.phowOpts{:}) ;      %这里又是获取当前这个图像的phow特征（待分类的图片），保存了找到的每一个D-SIFT的信息

% quantize local descriptors into visual words
switch model.quantizer
  case 'vq'
    [drop, binsa] = min(vl_alldist(model.vocab, single(descrs)), [], 1) ;  %如果没有KD优化，那么就算算距离 判断在哪个类（就是SIFT分类后 一共300个）里。
  case 'kdtree'
    binsa = double(vl_kdtreequery(model.kdtree, model.vocab, ...           %如果KD树优化过了，就用KD树查找的方法 判断在哪个类里（SIFT分类后的那300个）
                                  single(descrs), ...
                                  'MaxComparisons', 50)) ;
end

for i = 1:length(model.numSpatialX)
  binsx = vl_binsearch(linspace(1,width,model.numSpatialX(i)+1), frames(1,:)) ;
  binsy = vl_binsearch(linspace(1,height,model.numSpatialY(i)+1), frames(2,:)) ;

  % combined quantization
  bins = sub2ind([model.numSpatialY(i), model.numSpatialX(i), numWords], ...
                 binsy,binsx,binsa) ;
  hist = zeros(model.numSpatialY(i) * model.numSpatialX(i) * numWords, 1) ;
  hist = vl_binsum(hist, ones(size(bins)), bins) ;
  hists{i} = single(hist / sum(hist)) ;
end
hist = cat(1,hists{:}) ;
hist = hist / sum(hist) ;                                                  %直方图归一化


end

