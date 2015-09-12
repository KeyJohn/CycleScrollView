//
//  CycleScrollView.m
//  ScrollDemo
//
//  Created by keyzhang on 15/9/8.
//  Copyright (c) 2015年 keyzhang. All rights reserved.
//

#import "CycleScrollView.h"

@interface CycleScrollView ()
{
    UIImageView *leftImgView;   //左
    UIImageView *centerImgView; //中
    UIImageView *rightImgView;  //右
}

@end

@implementation CycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _costomInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self _costomInit];
}

- (void)_costomInit
{
    
    self.delegate = self;
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;

    self.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    
    self.pagingEnabled = YES;
    
    //控制视图
    leftImgView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:leftImgView];
    centerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:centerImgView];
    rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:rightImgView];
    
    
    
    self.contentOffset = CGPointMake(self.frame.size.width, 0);
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat xOff = scrollView.contentOffset.x;
    if (xOff == 0) {    //向右滑动
        if (_selectedIndex == 0) {
            _selectedIndex = self.imgs.count - 1;
        }else {
            _selectedIndex = _selectedIndex - 1;
        }
    } else if (xOff == self.frame.size.width * 2) {   //向左滑动
        if (_selectedIndex == self.imgs.count -1) {
            _selectedIndex = 0;
        }else {
            _selectedIndex = _selectedIndex + 1;
        }
    }
    
//    NSLog(@"%ld", _selectedIndex);
    
    //设置左边图片
    if (_selectedIndex == 0) {
        leftImgView.image = self.imgs.lastObject;
    }else {
        leftImgView.image = self.imgs[_selectedIndex - 1];
    }
    
    //设置中间图片
    centerImgView.image = self.imgs[_selectedIndex];
    
    
    //设置右边图片
    if (_selectedIndex == self.imgs.count - 1) {
        rightImgView.image = self.imgs[0];
    }else {
        rightImgView.image = self.imgs[_selectedIndex + 1];
    }
    
    //每次都显示中间的视图
    scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
}

- (void)setImgs:(NSArray *)imgs
{
    NSMutableArray *selfImgs = [NSMutableArray arrayWithArray:imgs];
    
    //优化
    if (imgs.count < 3) {
        [selfImgs addObjectsFromArray:imgs];
        [selfImgs addObjectsFromArray:imgs];
    }
    
    _imgs = selfImgs;
    
    leftImgView.image = _imgs.lastObject;
    centerImgView.image = _imgs[0];
    rightImgView.image = _imgs[1];
}


@end
