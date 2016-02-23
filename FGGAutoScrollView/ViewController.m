//
//  ViewController.m
//  FGGAutoScrollView
//
//  Created by 夏桂峰 on 15/9/17.
//  Copyright (c) 2015年 夏桂峰. All rights reserved.
//

#import "ViewController.h"
#import "FGGAutoScrollView.h"

@interface ViewController ()

//自动循环滚动视图
@property(nonatomic,strong)FGGAutoScrollView *bannerView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self createUI];
    
    __weak typeof(self) wkSelf=self;
    //调下载完数据后再调用setter方法刷新视图
    [self downloadDataWithCompletionHandle:^(NSArray *imgsArray){
        wkSelf.bannerView.imageURLArray=imgsArray;
    }];
}
//初始化
-(void)setup
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"FGGAutoScrollView Demo";
    self.automaticallyAdjustsScrollViewInsets=NO;
}
//创建自动循环滚动视图
-(void)createUI
{
    //初始化自动循环滚动视图，并且定义图片的点击事件
    _bannerView=[[FGGAutoScrollView alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 200) placeHolderImage:nil imageURLs:nil imageDidSelectedBlock:^(NSInteger selectedIndex) {
        switch (selectedIndex) {
            case 0:
                NSLog(@"你选择了第%ld张图片",selectedIndex);
                break;
            case 1:
                NSLog(@"你选择了第%ld张图片",selectedIndex);
                break;
            case 2:
                NSLog(@"你选择了第%ld张图片",selectedIndex);
                break;
            default:
                break;
        }
    }];
    //还可以设置自动滚动时的回调事件（可不设置）
    _bannerView.imageDidScrolledBlock=^(NSInteger index){
        NSLog(@"滚动到了第%ld张",index);
    };
    [self.view addSubview:_bannerView];
}
//下载数据
-(void)downloadDataWithCompletionHandle:(void(^)(NSArray *imgsArray))completion
{
    //....下载数据...假设下载完得到的数据是array
    NSArray *array = @[@"http://i.okaybuy.cn/images/multipic/new/201506/fe/fe6b322427edad3dd6c7916116a9a15b.jpg",
                       @"http://i.okaybuy.cn/images/multipic/new/201505/88/888d8cf6a769c401af2ced0140fa90f3.jpg",
                       @"http://i.okaybuy.cn/images/multipic/new/201506/53/532a6028830f9d7e39b5bce9e5e60e52.jpg"];
    
    //完成后调用完成的回调代码块
    if(completion)
        completion(array);
}


@end
