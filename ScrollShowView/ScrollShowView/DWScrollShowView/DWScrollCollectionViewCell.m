//
//  DWScrollCollectionViewCell.m
//  ScrollShowView
//
//  Created by mude on 2018/3/21.
//  Copyright © 2018年 mude. All rights reserved.
//

#import "DWScrollCollectionViewCell.h"

#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define SCREEN_WIDTH  ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

@implementation DWScrollCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-20, frame.size.height)];
        _view.backgroundColor = [UIColor orangeColor];
        [self addSubview:_view];
        _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-20, frame.size.height)];
        _button.backgroundColor = [UIColor clearColor];
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        
        _label = [[UILabel alloc] init];
        _label.center = self.view.center;
        _label.frame = CGRectMake(0, 20, _view.bounds.size.width, 40);
        _label.font = [UIFont systemFontOfSize:17];
        _label.textColor = [UIColor whiteColor];
        [_view addSubview:_label];
    }
    return self;
}

- (void)buttonClick:(UIButton *)btn{
    self.buttonBlock();
}

@end
