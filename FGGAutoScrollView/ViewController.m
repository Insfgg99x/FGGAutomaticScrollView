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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *array = @[@"http://i.okaybuy.cn/images/multipic/new/201506/fe/fe6b322427edad3dd6c7916116a9a15b.jpg",
                       @"http://i.okaybuy.cn/images/multipic/new/201505/88/888d8cf6a769c401af2ced0140fa90f3.jpg",
                       @"http://i.okaybuy.cn/images/multipic/new/201506/53/532a6028830f9d7e39b5bce9e5e60e52.jpg"];
    FGGAutoScrollView *scrollView=[[FGGAutoScrollView alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 200) imageURLs:array imageDidSelectedBlock:^(NSInteger selectedIndex) {
        switch (selectedIndex) {
                case 0:
                NSLog(@"你选择了第%ld张图片",selectedIndex);
                break;
                case 1:
                NSLog(@"你选择了第%ld张图片",selectedIndex);
                break;
                case 2:
                NSLog(@"你选择了第%ld张图片",selectedIndex);
            default:
                break;
        }
    }];
    [self.view addSubview:scrollView];
}



@end
