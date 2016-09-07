//
//  FGGAutoScrollView.h
//  FGGAutoScrollView
//
//  Created by 夏桂峰 on 15/9/17.
//  Copyright (c) 2015年 夏桂峰. All rights reserved.
/*
 FGGAutomaticScrollView简介：
 -----------------------------------------------------------------------
 初始化方法：
 分为两种：
 1.从网络加载图片：[[FGGAutoScrollView alloc] initWithFrame:(CGRect)frame
                                               imageURLs:(NSArray *)URLArray
                                   imageDidSelectedBlock:(FGGImageClickBlock) didSelectedImageAtIndex];
 
 2.从本地加载图片：[[FGGAutoScrollView alloc] initWithFrame:(CGRect)frame
                                         localImageNames:(NSArray *)imageNames 
                                   imageDidSelectedBlock:(FGGImageClickBlock) didSelectedImageAtIndex;
 提示：
 若不需要为图片添加点击事件，初始化时，点击图片的回调block置为nil就可以了。
 ----------------------------------------------------------------------
   Copyright (c) 2015年 xia. All rights reserved.
 */
#import <UIKit/UIKit.h>

/**
 *  滚动时间间隔 可以自己修改
 */
static double kFGGScrollInterval = 3.0f;

typedef void(^FGGImageClickBlock)(NSInteger selectedIndex);
typedef void(^FGGScrollCallBack)(NSInteger currentIndex);
/**
 *  自动循环滚动的滚动视图
 */
@interface FGGAutoScrollView : UIView<UIScrollViewDelegate>

/**
 *  滚动视图对象（只读）
 */
@property(nonatomic,strong,readonly)UIScrollView        *scroll;
/**点击照片的回调*/
@property(nonatomic,copy,readonly)FGGImageClickBlock    didSelectedImageAtIndex;
/**滚动时的回调*/
@property(nonatomic,copy)FGGScrollCallBack              imageDidScrolledBlock;
/**图片的urlString链接数组*/
@property(nonatomic,strong)NSArray                      *imageURLArray;

/**
 *  加载网络图片滚动
 *
 *  @param frame    frame
 *  @param URLArray 包含图片URL字符串的数组
 *  @param didSelectedImageAtIndex 点击图片时回调的block
 *
 *  @return FGGAutoScrollView对象
 */
-(instancetype)initWithFrame:(CGRect)frame placeHolderImage:(UIImage *)placeHolderImage imageURLs:(NSArray *)URLArray imageDidSelectedBlock:(FGGImageClickBlock) didSelectedImageAtIndex;

/**
 *  加载本地图片滚动
 *
 *  @param frame      frame
 *  @param imageNames 本地图片名字数组
 *  @param didSelectedImageAtIndex 点击图片时回调的block
 *
 *  @return FGGAutoScrollView对象
 */
-(instancetype)initWithFrame:(CGRect)frame placeHolderImage:(UIImage *)placeHolderImage localImageNames:(NSArray *)imageNames imageDidSelectedBlock:(FGGImageClickBlock) didSelectedImageAtIndex;

@end
