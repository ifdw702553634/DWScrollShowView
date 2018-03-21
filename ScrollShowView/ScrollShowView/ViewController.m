//
//  ViewController.m
//  ScrollShowView
//
//  Created by mude on 2018/3/21.
//  Copyright © 2018年 mude. All rights reserved.
//

#import "ViewController.h"
#import "DWScrollShowView.h"

#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define SCREEN_WIDTH  ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"demo";
    
    DWScrollShowView *view = [[DWScrollShowView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 100) withData:@[@"text_1",@"text_2",@"text_3",@"text_4",@"text_5",@"text_6"]];
    [self.view addSubview:view];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
