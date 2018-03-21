//
//  DWScrollCollectionViewCell.h
//  ScrollShowView
//
//  Created by mude on 2018/3/21.
//  Copyright © 2018年 mude. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(void);

@interface DWScrollCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIButton *button;

@property (nonatomic, copy) ButtonBlock buttonBlock;

@end
