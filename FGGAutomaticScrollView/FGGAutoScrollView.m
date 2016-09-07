//
//  FGGAutoScrollView.m
//  FGGAutoScrollView
//
//  Created by 夏桂峰 on 15/9/17.
//  Copyright (c) 2015年 夏桂峰. All rights reserved.
//

#import "FGGAutoScrollView.h"
#import "UIImageView+WebCache.h"

@implementation FGGAutoScrollView
{
    //定时器
    NSTimer *_timer;
    //页码控制器
    UIPageControl *_pageControl;
    /**默认图片*/
    UIImage *_placeHolderImage;
}

//加载网络图片的方法
-(instancetype)initWithFrame:(CGRect)frame placeHolderImage:(UIImage *)placeHolderImage imageURLs:(NSArray *)URLArray imageDidSelectedBlock:(FGGImageClickBlock)didSelectedImageAtIndex{
    
    if(self=[super initWithFrame:frame]){
        
        _placeHolderImage=placeHolderImage;
        _imageURLArray=URLArray;
        _didSelectedImageAtIndex=didSelectedImageAtIndex;
        [self createScrollView];
      
    }
    return self;
}
//加载本地的图片的方法
-(instancetype)initWithFrame:(CGRect)frame placeHolderImage:(UIImage *)placeHolderImage localImageNames:(NSArray *)imageNames imageDidSelectedBlock:(FGGImageClickBlock)didSelectedImageAtIndex
{
    if(self=[super initWithFrame:frame])
    {
        if(imageNames.count>0)
        {
            _placeHolderImage=placeHolderImage;
            NSMutableArray *fullPathArray=[NSMutableArray array];
            for(int i=0;i<imageNames.count;i++)
            {
                NSString *path;
                NSString *name=imageNames[i];
                if([name hasSuffix:@"jpg"]||[name hasSuffix:@"png"])
                    path=[[NSBundle mainBundle] pathForResource:name ofType:nil];
                else
                    path=[[NSBundle mainBundle] pathForResource:name ofType:@"png"];
                NSString *fullPath=[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                [fullPathArray addObject:fullPath];
            }
            _imageURLArray=fullPathArray;
            _didSelectedImageAtIndex=didSelectedImageAtIndex;
            [self createScrollView];
        }
    }
    return self;
}
//构建循环滚动视图
-(void)createScrollView
{
    if(_scroll)
    {
        for(UIView *sub in _scroll.subviews)
            [sub removeFromSuperview];
        _scroll=nil;
    }
    _scroll=[[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:_scroll];
    _scroll.delegate=self;
    _scroll.contentSize=CGSizeMake((_imageURLArray.count+1)*self.bounds.size.width, self.bounds.size.height);
    
    _scroll.pagingEnabled=YES;
    _scroll.showsHorizontalScrollIndicator=NO;
    if(_timer)
    {
        [_timer invalidate];
        _timer=nil;
    }
    _timer=[NSTimer scheduledTimerWithTimeInterval:kFGGScrollInterval
                                            target:self
                                          selector:@selector(automaticScroll)
                                          userInfo:nil
                                           repeats:YES];
    for(int i=0;i<=_imageURLArray.count;i++)
    {
        CGFloat xpos=i*self.bounds.size.width;
        UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(xpos, 0, self.bounds.size.width, self.bounds.size.height)];
        //设置灰色底
        imv.image=_placeHolderImage;
        imv.userInteractionEnabled=YES;
        
        //添加点击图片的手势
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)];
        [imv addGestureRecognizer:tap];
        [_scroll addSubview:imv];
        NSString *urlString;
        if(i<_imageURLArray.count)
            urlString=_imageURLArray[i];
        else
            urlString=_imageURLArray[0];
        NSURL *url=[NSURL URLWithString:urlString];
        [imv sd_setImageWithURL:url placeholderImage:_placeHolderImage];
    }
    if(_pageControl)
        _pageControl=nil;
    _pageControl=[[UIPageControl alloc]init];
    _pageControl.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height-10);
    _pageControl.numberOfPages=_imageURLArray.count;
    _pageControl.currentPage=0;
    _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
    [self addSubview:_pageControl];
}
/**
 *  自动循环滚动
 */
-(void)automaticScroll
{
    if(_imageURLArray.count>0)
    {
        NSInteger index=_scroll.contentOffset.x/self.bounds.size.width;
        index++;
        if(index==_imageURLArray.count)
            index=0;
        if(self.imageDidScrolledBlock)
            self.imageDidScrolledBlock(index);
        _pageControl.currentPage=index;
        __weak typeof(self) weakSelf=self;
        //添加滚动动画
        [UIView animateWithDuration:0.2 animations:^{
           weakSelf.scroll.contentOffset=CGPointMake(index*self.bounds.size.width, 0);
        }];
    }
}
#pragma mark - UIScrollView
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index=_scroll.contentOffset.x/self.bounds.size.width;
    if(index==_imageURLArray.count)
        index=0;
    if(self.imageDidScrolledBlock)
        self.imageDidScrolledBlock(index);
    _pageControl.currentPage=index;
    _scroll.contentOffset=CGPointMake(self.bounds.size.width*index, 0);
}
//点击图片时回调代码块
-(void)tapImage
{
    if(self.didSelectedImageAtIndex)
    {
        self.didSelectedImageAtIndex(_pageControl.currentPage);
    }
}
//销毁
-(void)dealloc
{
    if(_timer)
    {
        [_timer invalidate];
        _timer=nil;
    }
}
/**图片数组的setter方法*/
-(void)setImageURLArray:(NSArray *)imageURLArray
{
    if(![imageURLArray isKindOfClass:[NSArray class]])
        return;
    _imageURLArray=imageURLArray;
    if(_imageURLArray.count==0)
        return;
    [self createScrollView];
}

@end
