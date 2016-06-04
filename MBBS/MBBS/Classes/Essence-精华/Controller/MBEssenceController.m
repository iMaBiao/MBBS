//
//  MBEssenceController.m
//  MBBS
//
//  Created by 浩渺 on 16/5/31.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBEssenceController.h"
#import "MBEssenceTagsController.h"

@interface MBEssenceController ()

@end

@implementation MBEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
