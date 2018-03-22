//
//  DWScrollShowView.m
//  ScrollShowView
//
//  Created by mude on 2018/3/21.
//  Copyright © 2018年 mude. All rights reserved.
//

#import "DWScrollShowView.h"
#import "DWScrollShowViewCell.h"

@interface DWScrollShowView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *rollDataArr;//数据源

@property (nonatomic, assign) float halfGap;//图片间距的一半

@property (nonatomic, assign) NSInteger curIndex;
@end

@implementation DWScrollShowView

- (instancetype)initWithFrame:(CGRect)frame withDistanceForScroll:(float)distance withGap:(float)gap{
    self = [super initWithFrame:frame];
    if (self) {
        self.halfGap = gap / 2;
        _curIndex = 1;
        /** 设置 UIScrollView */
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(distance, 0, self.frame.size.width - 2 * distance, self.frame.size.height)];
        [self addSubview:self.scrollView];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.clipsToBounds = NO;
        /** 添加手势 */
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self.scrollView addGestureRecognizer:tap];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        /** 数据初始化 */
        self.rollDataArr = [NSArray array];
    }
    return self;
}

#pragma mark - 视图数据
- (void)rollView:(NSArray *)dataArr{
    self.rollDataArr = dataArr;
    //循环创建添加轮播图片, 前后各添加一张
    for (int i = 0; i < self.rollDataArr.count + 2; i++) {
        for (UIView *underView in self.scrollView.subviews) {
            if (underView.tag == 400 + i) {
                [underView removeFromSuperview];
            }
        }
        DWScrollShowViewCell *vCell = [[DWScrollShowViewCell alloc] initWithFrame:CGRectMake((2 * i + 1) * self.halfGap + i * (self.scrollView.frame.size.width - 2*self.halfGap) + 10, 0, (self.scrollView.frame.size.width - 2*self.halfGap), self.frame.size.height)];
        vCell.tag = 400 + i;
        
        if (i == 0) {
            vCell.label.text = self.rollDataArr[self.rollDataArr.count - 1];
        }else if (i == self.rollDataArr.count+1) {
            vCell.label.text = self.rollDataArr[0];
        }else {
            vCell.label.text = self.rollDataArr[i - 1];
        }
        [self.scrollView addSubview:vCell];
    }
    //设置轮播图当前的显示区域
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * (self.rollDataArr.count + 2), 0);
}

- (void)setViewAlpha{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    for (int i = 0; i < self.rollDataArr.count + 2; i++) {
        NSInteger index = i + 400;
        UIView *view = [self viewWithTag:index];
        CGRect rect=[view convertRect: view.bounds toView:window];
        if (i == _curIndex) {
            view.alpha = 1.0f;
        }else if (fabs(rect.origin.x) > self.scrollView.frame.size.width*2){
            view.alpha = 0;
        }else{
            view.alpha = 1-(fabs(rect.origin.x)/self.scrollView.frame.size.width)+0.4;
        }
    }
}

#pragma mark - UIScrollViewDelegate 方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _curIndex = scrollView.contentOffset.x  / self.scrollView.frame.size.width;
    if (_curIndex == self.rollDataArr.count + 1) {
        scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }else if (_curIndex == 0){
        scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * self.rollDataArr.count, 0);
    }
    [self setViewAlpha];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self setViewAlpha];
}

#pragma mark - 轻拍手势的方法
- (void)tapAction:(UITapGestureRecognizer *)tap{
    if ([self.rollDataArr isKindOfClass:[NSArray class]] && (self.rollDataArr.count > 0)) {
        [_delegate didSelectViewWithIndexPath:(self.scrollView.contentOffset.x / self.scrollView.frame.size.width)];
    }else{
        [_delegate didSelectViewWithIndexPath:-1];
    }
    
}


@end
