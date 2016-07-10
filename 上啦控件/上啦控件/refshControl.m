//
//  refshControl.m
//  上啦控件
//
//  Created by 王建科 on 16/7/9.
//  Copyright © 2016年 第一小组. All rights reserved.
//

#import "refshControl.h"
#import "refsh.h"


enum CZRefreshState {
    Normal = 0,
    Pulling = 1,
    WillRefresh = 2,
};
@interface refshControl()

/**
 *  视图
 */
@property (nonatomic,weak) refsh * ref;
/**
 *  父视图
 */
@property (nonatomic,weak) UIScrollView* superVie;
@end

@implementation refshControl

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpUI];
    }
    return self;
}

#pragma mark -  搭建界面
- (void)setUpUI{
    self.backgroundColor = self.superVie.backgroundColor;
//    self.backgroundColor = [UIColor orangeColor];
    UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
    
    v.backgroundColor = [UIColor darkGrayColor];
    refsh * re = [refsh shardRefsh];
    [self addSubview:re];
    [self addSubview:v];
    _ref = re;
    
    v.translatesAutoresizingMaskIntoConstraints = NO;
        re.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self  addConstraint:[ NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];

    [self  addConstraint:[ NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self  addConstraint:[ NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];

    [self  addConstraint:[ NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:1/[UIScreen mainScreen].scale]];

    
        [self  addConstraint:[ NSLayoutConstraint constraintWithItem:re attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
        [self addConstraint:[NSLayoutConstraint  constraintWithItem:re attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
        [self addConstraint:[NSLayoutConstraint  constraintWithItem:re attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:re.bounds.size.width]];
    
    
        [self addConstraint:[NSLayoutConstraint  constraintWithItem:re attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:re.bounds.size.height]];
    
}

- (void)willMoveToSuperview:(UIScrollView *)newSuperview{
    
    [super willMoveToSuperview:newSuperview];
        if (![newSuperview isKindOfClass:[UIScrollView  class]]) {
            return ;
        }
    
        _superVie = newSuperview;
    
        [newSuperview addObserver:self forKeyPath:@"contentOffset" options:0 context:0];
        
   
    

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    CGFloat height = _superVie.contentOffset.y + _superVie.contentInset.top;
    self.frame = CGRectMake(0, height, _superVie.bounds.size.width, -height );
    
   
    
    if (height>0 ) {
        return;
    }
    
    if (self.superVie.isDragging) {
        
    
    if (-height > 60 &&  (_ref.states == 0) ) {
        
        _ref.states = 1;
        printf("%zd",_ref.states);
        
    }else if (-height <= 60 && _ref.states == 1 ){
        
        _ref.states = 0;
         printf("%zd",_ref.states);
    }
    } else if( _ref.states == 1 ){
        
         printf("%f",height);
        [self beginRefreshing];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
}
//删除KVO
- (void)removeFromSuperview{
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    [super removeFromSuperview];
    
}

- (void)beginRefreshing{
    
    if (_ref.states == 2) {
        return;
    }
    _ref.states = 2;
    
    CGFloat offset = self.superVie.contentInset.top;
    offset = offset + 60;
    self.superVie.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);
    
    
}

- (void)endRefreshing{
    
    if (_ref.states == 2) {
        self.superVie.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
        _ref.states = 0;
    }
    
}

@end
