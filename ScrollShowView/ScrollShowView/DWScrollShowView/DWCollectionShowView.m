//
//  DWScrollShowView.m
//  ScrollShowView
//
//  Created by mude on 2018/3/21.
//  Copyright © 2018年 mude. All rights reserved.
//

#import "DWCollectionShowView.h"
#import "DWScrollFlowLaout.h"
#import "DWScrollCollectionViewCell.h"

#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define SCREEN_WIDTH  ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

@interface DWCollectionShowView()<UICollectionViewDelegate,UICollectionViewDataSource>{
    CGRect _frame;
    CGFloat _gap;
    NSMutableArray *_textArr;
}
@property (assign,nonatomic) NSInteger currentIndex;
@property (assign,nonatomic) CGFloat dragStartX;
@property (assign,nonatomic) CGFloat dragEndX;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation DWCollectionShowView
- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)textArr withGap:(CGFloat)gap{
    self = [super initWithFrame:frame];
    if (self) {
        _frame = frame;
        _gap = gap;
        
        [self prepareCollection];
        _textArr = [[NSMutableArray alloc] init];
        for (int i=0; i<4; i++) {
            [_textArr addObjectsFromArray:textArr];
        }
        [_collectionView reloadData];
        [_collectionView layoutIfNeeded];
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_textArr.count/2 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        _currentIndex = _textArr.count/2;
    }
    return self;
}

- (void)prepareCollection{
    DWScrollFlowLaout *flowLayout = [[DWScrollFlowLaout alloc] init];
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH-_gap*2, 100);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.contentSize = CGSizeMake(_textArr.count*(SCREEN_WIDTH-80), 0);
    [_collectionView registerClass:[DWScrollCollectionViewCell class] forCellWithReuseIdentifier:@"DWScrollCollectionViewCell"];
    [self addSubview:_collectionView];
}


//配置cell居中
- (void)fixCellToCenter {
    //最小滚动距离
    float dragMiniDistance = self.bounds.size.width/20.0f;
    if (self.dragStartX -  self.dragEndX >= dragMiniDistance) {
        self.currentIndex -= 1;//向右
    }else if(self.dragEndX -  self.dragStartX >= dragMiniDistance){
        self.currentIndex += 1;//向左
    }
    NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;
    self.currentIndex = self.currentIndex <= 0 ? 0 : self.currentIndex;
    self.currentIndex = self.currentIndex >= maxIndex ? maxIndex : self.currentIndex;
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark --- UICollectionviewDelegate or dataSource
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _textArr.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   DWScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DWScrollCollectionViewCell" forIndexPath:indexPath];
    cell.label.text = _textArr[indexPath.row];
    cell.gap = _gap;
    cell.buttonBlock = ^(){
        //点击view切换到以该view为中心
        self.currentIndex = indexPath.row;
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //防止点击空白区域发生偏移
    [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - UIScrollViewDelegate

//手指拖动开始
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.dragStartX = scrollView.contentOffset.x;
}

//手指拖动停止
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (self.currentIndex == [_textArr count]/4*3) {
        NSIndexPath *path  = [NSIndexPath indexPathForItem:[_textArr count]/2 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.currentIndex = [_textArr count]/2;
    }else if(self.currentIndex == [_textArr count]/4){
        NSIndexPath *path = [NSIndexPath indexPathForItem:[_textArr count]/2 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.currentIndex = [_textArr count]/2;
    }
}

@end
