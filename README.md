FGGAutomaticScrollView(依赖于SDWebImage)：<br>
![演示](https://github.com/Insfgg99x/FGGAutomaticScrollView/blob/master/demo.gif)<br>
<br>
-----------------------------------------------------------------------------------------<br>
初始化方法：<br>
分为两种：<br>
1.从网络加载图片：-(instancetype)initWithFrame:(CGRect)frame<br>
                           placeHolderImage:(UIImage *)placeHolderImage<br>
                                  imageURLs:(NSArray *)URLArray<br>
                      imageDidSelectedBlock:(FGGImageClickBlock)didSelectedImageAtIndex;<br><br>

2.从本地加载图片：-(instancetype)initWithFrame:(CGRect)frame<br>
                           placeHolderImage:(UIImage *)placeHolderImage<br>
                            localImageNames:(NSArray *)imageNames<br> 
                      imageDidSelectedBlock:(FGGImageClickBlock) didSelectedImageAtIndex;<br><br>
3.若需要设置滚动时的回调，只需要给这个属性赋值：<br>
@property(nonatomic,copy)void (^imageDidScrolledBlock)(NSInteger index);<br><br>

提示：<br>
若不需要为图片添加点击事件，初始化时，点击图片的回调block置为nil就可以了。<br>
-----------------------------------------------------------------------------------------<br>
Copyright (c) 2016年 xia. All rights reserved.<br>


