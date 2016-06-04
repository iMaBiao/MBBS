//
//  MBNewController.m
//  MBBS
//
//  Created by 浩渺 on 16/5/31.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBNewController.h"

@interface MBNewController ()

@end

@implementation MBNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.view.backgroundColor = MBGlobaBg;
}

- (void)tagClick {
    MBLogFunc;
}



@end
