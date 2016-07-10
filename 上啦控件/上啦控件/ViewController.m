//
//  ViewController.m
//  上啦控件
//
//  Created by 王建科 on 16/7/8.
//  Copyright © 2016年 第一小组. All rights reserved.
//

#import "ViewController.h"
#import "refshControl.h"

@interface ViewController ()
/**
 *  名字
 */
@property (nonatomic,strong) UITableView* tableV;
/**
 *  <#名字#>
 */
@property (nonatomic,weak) refshControl* ref;

@end

@implementation ViewController

- (void)loadView{
    _tableV = [UITableView new];
    self.view = _tableV;
    _tableV.frame = self.view.bounds;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark -  搭建界面
- (void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets = NO;

    _tableV.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);

    refshControl *ref = [[refshControl alloc] init];
    [self.view addSubview:ref];
    [ref beginRefreshing];
      [ref beginRefreshing];
    [ref addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    _ref = ref;
    [self loadData];
}

- (void)loadData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.ref  endRefreshing];
         [self.ref  endRefreshing];
    });
    
}

@end
