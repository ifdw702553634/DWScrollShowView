//
//  ViewController.m
//  ScrollShowView
//
//  Created by mude on 2018/3/21.
//  Copyright © 2018年 mude. All rights reserved.
//

#import "ViewController.h"
#import "DWCollectionShowView.h"
#import "DWScrollShowView.h"

#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define SCREEN_WIDTH  ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define KCellSpace    40 //cell之间的间距

@interface ViewController ()<DWRollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"demo";
    
    DWCollectionShowView *view = [[DWCollectionShowView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 100) withData:@[@"text_1",@"text_2",@"text_3",@"text_4",@"text_5",@"text_6"] withGap:20.f];
    [self.view addSubview:view];
    
    
    DWScrollShowView *rollView = [[DWScrollShowView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH - KCellSpace, 100) withDistanceForScroll:0 withGap:20.f];
    rollView.backgroundColor = [UIColor whiteColor];
    rollView.delegate = self;
    [rollView rollView:@[@"text_1",@"text_2",@"text_3",@"text_4",@"text_5",@"text_6"]];
    [self.view addSubview:rollView];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 滚动视图协议
- (void)didSelectViewWithIndexPath:(NSInteger)index{
    
    if (index != -1) {
        
        NSLog(@"%ld", (long)index);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
