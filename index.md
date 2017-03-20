## 王润 邓信 程驰 袁振威 黎文盛  

<div style="text-align:center" markdown="1">
<img src="http://reso2.yiihuu.com/1077246-z.jpg">
</div>


### Week1 
* **选定题目**   
在对比了5个题目，队员结合自己对题目的熟悉程度后，选定做 2D and 3D Shape Recognition。  
* **建立项目网站**  
利用GitHub Pages，可以利用markdown来进行编写，比较方便。  
* **查找资料**  
文献：  
[1] Chang et al., ShapeNet: An Information-Rich 3D Model Repository .arXiv:1512.03012   
[2] Wu et al., 3D ShapeNets: A Deep Representation for Volumetric Shape.CVPR 2015  
[3] Philip Shilane et al., The Princeton Shape Benchmark Shape Modeling International, June 2004   
[4] HangSu et al., Multi-View Convolutional Neural Networks for 3D Shape Recognition.ICCV 2015  
数据集网站:  
[https://shapenet.cs.stanford.edu/shrec16/](https://shapenet.cs.stanford.edu/shrec16/)  
[http://modelnet.cs.princeton.edu/](http://modelnet.cs.princeton.edu/)  

***   
### Week2  
* **2D Shape Recognition**
大体思路：检测+识别  
问题：  
1.找不到充分适合的数据集  
2.算法选择  

***
### Week3
* **2D Shape Recognition**
解决上周问题：
问题1解决方案：自制数据集
数据集描述：主要分为5类图形和背景图形，5类2D图像分别为：triangle（三角形），rectangle（矩形），circle（圆形），star（五角星）和pentagon（五边形）
其中部分数据集的图案如下所示：
问题2解决方案：选择SIFT+BOVW算法
实验测试结果如下所示：
