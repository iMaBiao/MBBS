//
//  MBMeController.m
//  MBBS
//
//  Created by 浩渺 on 16/5/31.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBMeController.h"

@interface MBMeController ()

@end

@implementation MBMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moomClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
    self.view.backgroundColor = MBGlobaBg;
}

- (void)settingClick {
    MBLogFunc;
}

- (void)moomClick {
    MBLogFunc;
}

@end
