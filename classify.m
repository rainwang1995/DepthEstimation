function [className, score] = classify(model, im)                          %分类函数
% -------------------------------------------------------------------------

hist = getImageDescriptor(model, im) ;
psix = vl_homkermap(hist, 1, 'kchi2', 'gamma', .5) ;
scores = model.w' * psix + model.b' ;                                      
[score, best] = max(scores) ;                                              %哪个SIFT块分最高就归为哪个
className = model.classes{best} ;
end