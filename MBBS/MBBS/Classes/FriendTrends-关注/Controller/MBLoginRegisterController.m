//
//  MBLoginRegisterController.m
//  MBBS
//
//  Created by biao on 16/6/4.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBLoginRegisterController.h"

@interface MBLoginRegisterController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
- (IBAction)exitButton;

@end

@implementation MBLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view insertSubview:self.bgView atIndex:0];
}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)exitButton {
    MBLogFunc;
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
