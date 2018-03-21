//
//  DWScrollFlowLaout.m
//  ScrollShowView
//
//  Created by mude on 2018/3/21.
//  Copyright © 2018年 mude. All rights reserved.
//

#import "DWScrollFlowLaout.h"

@implementation DWScrollFlowLaout

//设置放大动画
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
    //屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        //移动的距离和屏幕宽度的的比例
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
        //CGFloat scale = fabs(cos(apartScale * M_PI/4));
        //设置透明度变化 范围固定到 -π/4到 +π/4这一个范围内
        CGFloat alpha = fabs(cos(apartScale * M_PI/4));
        attributes.alpha = alpha;
        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
        attributes.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
    return arr;
}
//防止报错 先复制attributes
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes
{
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

//是否需要重新计算布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return true;
}
@end
