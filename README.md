##FGGAutomaticScrollView
...................................................................................
###Introduction
A class with ad. pics auotmatic scrolling.
![](https://github.com/Insfgg99x/FGGAutomaticScrollView/blob/master/demo.gif)
###Installtion
Manual:

Download This Project and drag the FGGAutomaticScrollView folder into your peroject, do not forget to ensure "copy item if need" being selected.

Cocoapods:
```
pod 'FGGAutoScrollView', '~> 1.0.0'
```

###Usage

- 加载网络图片：
```
-(instancetype)initWithFrame:(CGRect)frame
                           placeHolderImage:(UIImage *)placeHolderImage
                                  imageURLs:(NSArray *)URLArray
                      imageDidSelectedBlock:(FGGImageClickBlock)didSelectedImageAtIndex;
```

- 加载本地图片：
```
-(instancetype)initWithFrame:(CGRect)frame
                           placeHolderImage:(UIImage *)placeHolderImage
                            localImageNames:(NSArray *)imageNames
                      imageDidSelectedBlock:(FGGImageClickBlock) didSelectedImageAtIndex;
```
- 若需要设置滚动时的回调，只需要给这个属性赋值：
```
@property(nonatomic,copy)void (^imageDidScrolledBlock)(NSInteger index);
```

###Explain：
若不需要为图片添加点击事件，初始化时，点击图片的回调block置为nil就可以了。
...............................................................................
Copyright (c) 2016年 CGPointZero. All rights reserved.<br>