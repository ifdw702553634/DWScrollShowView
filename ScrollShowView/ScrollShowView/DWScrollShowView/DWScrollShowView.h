//
//  DWScrollShowView.h
//  ScrollShowView
//
//  Created by mude on 2018/3/21.
//  Copyright © 2018年 mude. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DWRollViewDelegate <NSObject>
- (void)didSelectViewWithIndexPath:(NSInteger)index;
@end

@interface DWScrollShowView : UIView

@property (nonatomic, assign) id<DWRollViewDelegate> delegate;

/**
 @param frame 设置View大小
 @param distance 设置Scroll距离View两侧距离
 @param gap 设置Scroll内部 图片间距
 @return 初始化返回值
 */
- (instancetype)initWithFrame:(CGRect)frame withDistanceForScroll:(float)distance withGap:(float)gap;

//设置数据源
- (void)rollView:(NSArray *)dataArr;

@end
