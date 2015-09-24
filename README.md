FGGAutomaticScrollView简介：<br>
![演示](https://github.com/Insfgg99x/FGGDownAutomaticScrollView/blob/master/demo.gif)<br>
<br>
-----------------------------------------------------------------------------------------<br>
初始化方法：<br>
分为两种：<br>
1.从网络加载图片：[[FGGAutoScrollView alloc] initWithFrame:(CGRect)frame
imageURLs:(NSArray *)URLArray
imageDidSelectedBlock:(FGGImageClickBlock) didSelectedImageAtIndex];<br>
<br>
2.从本地加载图片：[[FGGAutoScrollView alloc] initWithFrame:(CGRect)frame
localImageNames:(NSArray *)imageNames 
imageDidSelectedBlock:(FGGImageClickBlock) didSelectedImageAtIndex;<br>
<br>
提示：<br>
若不需要为图片添加点击事件，初始化时，点击图片的回调block置为nil就可以了。<br>
-----------------------------------------------------------------------------------------<br>
Copyright (c) 2015年 xia. All rights reserved.<br>


