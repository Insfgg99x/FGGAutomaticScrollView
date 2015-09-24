//
//  FGGAutoScrollView.m
//  FGGAutoScrollView
//
//  Created by 夏桂峰 on 15/9/17.
//  Copyright (c) 2015年 夏桂峰. All rights reserved.
//

#import "FGGAutoScrollView.h"

@implementation FGGAutoScrollView
{
    //定时器
    NSTimer *_timer;
    //照片的链接
    NSArray *_URLArray;
    //页码控制器
    UIPageControl *_pageControl;
}


//加载网络图片的方法
-(instancetype)initWithFrame:(CGRect)frame imageURLs:(NSArray *)URLArray imageDidSelectedBlock:(FGGImageClickBlock)didSelectedImageAtIndex
{
    if(self=[super initWithFrame:frame])
    {
        if(URLArray.count>0)
        {
            _URLArray=URLArray;
            _didSelectedImageAtIndex=didSelectedImageAtIndex;
            [self createScrollView];
        }
    }
    return self;
}
//加载本地的图片的方法
-(instancetype)initWithFrame:(CGRect)frame localImageNames:(NSArray *)imageNames imageDidSelectedBlock:(FGGImageClickBlock)didSelectedImageAtIndex
{
    if(self=[super initWithFrame:frame])
    {
        if(imageNames.count>0)
        {
            NSMutableArray *fullPathArray=[NSMutableArray array];
            for(int i=0;i<imageNames.count;i++)
            {
                NSString *path;
                NSString *name=imageNames[i];
                if([name hasSuffix:@"jpg"]||[name hasSuffix:@"png"])
                    path=[[NSBundle mainBundle] pathForResource:name ofType:nil];
                else
                    path=[[NSBundle mainBundle] pathForResource:name ofType:@"png"];
                NSString *fullPath=[NSString stringWithFormat:@"file://%@",path];
                [fullPathArray addObject:fullPath];
            }
            _URLArray=fullPathArray;
            _didSelectedImageAtIndex=didSelectedImageAtIndex;
            [self createScrollView];
        }
    }
    return self;
}
//构建循环滚动视图
-(void)createScrollView
{
    _scroll=[[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:_scroll];
    _scroll.delegate=self;
    _scroll.contentSize=CGSizeMake((_URLArray.count+1)*self.bounds.size.width, self.bounds.size.height);
    
    _scroll.pagingEnabled=YES;
    _scroll.showsHorizontalScrollIndicator=NO;
    _timer=[NSTimer scheduledTimerWithTimeInterval:kFGGScrollInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    for(int i=0;i<=_URLArray.count;i++)
    {
        CGFloat xpos=i*self.bounds.size.width;
        UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(xpos, 0, self.bounds.size.width, self.bounds.size.height)];
        imv.backgroundColor=[UIColor lightGrayColor];
        imv.userInteractionEnabled=YES;
        
        //添加点击图片的手势
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)];
        [imv addGestureRecognizer:tap];
        [_scroll addSubview:imv];
        NSString *key;
        if(i<_URLArray.count)
            key=_URLArray[i];
        else
            key=_URLArray[0];
        //从持久化读取
        NSData *cachedData=[[NSUserDefaults standardUserDefaults] objectForKey:key];
        imv.image=[UIImage imageWithData:cachedData];
        //读取不到，就下载
        if(!imv.image)
        {
            //指示器
            UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            indicator.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
            [imv addSubview:indicator];
            [indicator startAnimating];
            
            //开辟线程，加载图片
            dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                NSURL *url=[NSURL URLWithString:key];
                if(url)
                {
                    NSData *data=[NSData dataWithContentsOfURL:url];
                    //写入持久化储存
                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    //返回主线程刷新UI
                    dispatch_async(dispatch_get_main_queue(), ^{
                        imv.image=[UIImage imageWithData:data];
                        [indicator removeFromSuperview];
                    });
                }
            });
        }
    }
    _pageControl=[[UIPageControl alloc]init];
    _pageControl.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height-10);
    _pageControl.numberOfPages=_URLArray.count;
    _pageControl.currentPage=0;
    _pageControl.pageIndicatorTintColor=[UIColor darkGrayColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:181/255.f green:0 blue:0 alpha:1];
    [self addSubview:_pageControl];
}
/**
 *  自动循环滚动
 */
-(void)automaticScroll
{
    if(_URLArray.count>0)
    {
        NSInteger index=_scroll.contentOffset.x/self.bounds.size.width;
        index++;
        if(index==_URLArray.count)
            index=0;
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
    if(index==_URLArray.count)
        index=0;
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
@end
