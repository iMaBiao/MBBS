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
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *password;


- (IBAction)exitButton;


@end

@implementation MBLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view insertSubview:self.bgView atIndex:0];
    
//    //设置文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    
//    // NSAttributedString : 带有属性的文字
//    NSAttributedString *placeholder = [[NSAttributedString alloc]initWithString:@"手机号" attributes:attrs];
//    self.phoneField.attributedPlaceholder = placeholder;
//    
//    NSAttributedString *passwordholder = [[NSAttributedString alloc]initWithString:@"密码" attributes:attrs];
//    self.password.attributedPlaceholder = passwordholder;
    
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
