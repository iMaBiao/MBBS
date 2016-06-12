//
//  MBEssenceController.m
//  MBBS
//
//  Created by 浩渺 on 16/5/31.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBEssenceController.h"
#import "MBEssenceTagsController.h"

#import "MBAllViewController.h"
#import "MBWordViewController.h"
#import "MBVideoViewController.h"
#import "MBVoiceViewController.h"
#import "MBPictureViewController.h"

@interface MBEssenceController ()<UIScrollViewDelegate>
/** 标签栏底部的红色指示器 */
@property(nonatomic,weak)UIView *indicatorView;
/** 当前选中的按钮 */
@property(nonatomic,weak)UIButton *selectedButton;

/** 顶部的所有标签 */
@property(nonatomic,weak)UIView  *titlesView;

/** 底部的所有内容 */
@property(nonatomic,weak)UIScrollView *contentView;

@end

@implementation MBEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航栏
    [self setNavigation];
    
//    初始化子控制器
    [self setChildViewControllers];
    
    // 设置顶部的标签栏
    [self setTitlesView];
    
    // 底部的scrollView
    [self setContentView];
}

/**
 *  初始化子控制器
 */
- (void)setChildViewControllers{
    MBAllViewController *all = [[MBAllViewController alloc]init];
    [self addChildViewController:all];
    
    MBVideoViewController *video = [[MBVideoViewController alloc]init];
    [self addChildViewController:video];
    
    MBVoiceViewController *voice = [[MBVoiceViewController alloc]init];
    [self addChildViewController:voice];
    
    MBPictureViewController *picture = [[MBPictureViewController alloc]init];
    [self addChildViewController:picture];
    
    MBWordViewController *word = [[MBWordViewController alloc]init];
    [self addChildViewController:word];
}

/**
 *  底部的scrollView
 */
- (void)setContentView{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    //设置水平方向上的内容尺寸
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    
    self.contentView = contentView;
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x ;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    // 设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
    
}
/**
 *  设置顶部的标签栏
 */
- (void)setTitlesView{
    
    // 标签栏整体
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    titleView.width = self.view.width;
    titleView.height  = 35;
    titleView.y = 64;
    [self.view addSubview:titleView];
    self.titlesView = titleView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titleView.height - indicatorView.height;
    self.indicatorView = indicatorView;

    
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width = titleView.width / titles.count;
    CGFloat height = titleView.height;
    for (NSInteger i = 0; i < titles.count; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [titleView addSubview:indicatorView];
}
- (void)titleClick:(UIButton *)button{
    
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
     // 滚动
    CGPoint  offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
}

- (void)setNavigation{
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.view.backgroundColor = MBGlobaBg;
}


- (void)tagClick {
    MBLogFunc;
    MBEssenceTagsController *tags = [[MBEssenceTagsController alloc]init];
    [self.navigationController pushViewController:tags animated:YES];
}



@end
