//
//  MBFriendTrendsController.m
//  MBBS
//
//  Created by 浩渺 on 16/5/31.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBFriendTrendsController.h"
#import "MBRecommendController.h"

@interface MBFriendTrendsController ()

@end

@implementation MBFriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    self.view.backgroundColor = MBGlobaBg;
}

- (void)friendsClick {
    MBLogFunc;
    MBRecommendController *recommend = [[MBRecommendController alloc]init];
    [self.navigationController pushViewController:recommend animated:YES];
}


@end
