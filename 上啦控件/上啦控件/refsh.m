//
//  refsh.m
//  上啦控件
//
//  Created by 王建科 on 16/7/8.
//  Copyright © 2016年 第一小组. All rights reserved.
//

#import "refsh.h"





@interface refsh()
@property (weak, nonatomic) IBOutlet UIImageView *pullRef;
@property (weak, nonatomic) IBOutlet UILabel *pulllable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *dicatorView;

@property (nonatomic,weak) UIScrollView* superVie;
/**
 *  <#名字#>
 */


@end

@implementation refsh

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (void)setStates:(enum CZRefreshState *)states{
//    _states = states;
//    
//
//}


+ (instancetype)shardRefsh{
    
    UINib * nib = [UINib nibWithNibName:@"refsh" bundle:nil];
    
    refsh * fview =  [nib instantiateWithOwner:nil options:nil].lastObject;
    
    return fview;
}

- (void)setStates:(int)states{
    _states = states;
    
    switch (states) {
        case 0: {self.pulllable.text = @"使劲拉把....";
            [self.pullRef setHidden:NO];
            [UIView animateWithDuration:0.25 animations:^{
            self.pullRef.transform = CGAffineTransformIdentity;
            }];
            [self.dicatorView stopAnimating];
            
        }
            break;
            
        case 1: {self.pulllable.text = @"松手刷新...";
            [UIView animateWithDuration:0.25 animations:^{
            self.pullRef.transform = CGAffineTransformRotate(self.pullRef.transform, M_PI - 0.001);
            }] ;}
            break;
            
        case 2:{self.pulllable.text = @"正在刷新...";
            [self.dicatorView startAnimating];
             [self.pullRef setHidden:YES];
            
            
        }break;
        default:
            break;
    }
}


- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.states = 0;
    
    
    
}
//
//- (refsh *)r{
//    if (_r == nil) {
//        _r = [refsh shardRefsh];
//        
//    }
//    return  _r;
//}
//
//
//- (void)didMoveToSuperview{
//    [super didMoveToSuperview];
//    
//}
//
//- (void)willMoveToSuperview:(UIScrollView *)newSuperview{
//    
//    [super willMoveToSuperview:newSuperview];
//    
//    if (![newSuperview isKindOfClass:[UIScrollView  class]]) {
//        return ;
//    }
//    
//    _superVie = newSuperview;
//    
//    [newSuperview addObserver:self forKeyPath:@"contentOffset" options:0 context:0];
//    
//   
//}

//- (void)removeFromSuperview{
//    //一定在父视图删除前 注销(不注销KVO会崩溃)
//    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
//    [super removeFromSuperview];
//    
//}
//
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    
//    
//   
//    CGFloat height = _superVie.contentOffset.y + _superVie.contentInset.top;
//    printf("%f",height);
//    
//    self.frame = CGRectMake(0, height,_superVie.bounds.size.width , -height);
//    
//
//    
//}
//
//
//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        [self setUpUI];
//    }
//    return self;
//}
//
//
//
//#pragma mark -  搭建界面
//- (void)setUpUI{
//    
//    self.backgroundColor = [UIColor orangeColor];
////    [self addSubview:self.r];

//}
@end
