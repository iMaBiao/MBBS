//
//  MBTabBarController.m
//  MBBS
//
//  Created by 浩渺 on 16/5/31.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBTabBarController.h"
#import "MBMeController.h"
#import "MBEssenceController.h"
#import "MBFriendTrendsController.h"
#import "MBNewController.h"
#import "MBNavigationController.h"
#import "MBTabBar.h"
@interface MBTabBarController ()

@end

@implementation MBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *tabBarItem =[UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
    

    [self addChildsViewController:[[MBEssenceController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];

   [self addChildsViewController:[[MBNewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self addChildsViewController:[[MBFriendTrendsController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self addChildsViewController:[[MBMeController alloc]init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    // 更换系统自带的tabBar
    [self setValue:[[MBTabBar alloc]init] forKeyPath:@"tabBar"];
}

/**
 *  添加子控制器
 *
 *  @param childVC       子控制器
 *  @param title         子控制器标题
 *  @param image         图片
 *  @param selectedImage 选中图片
 */
- (void)addChildsViewController:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    MBNavigationController *nav = [[MBNavigationController alloc]initWithRootViewController:childVC];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    [self addChildViewController:nav];
    
}


@end
