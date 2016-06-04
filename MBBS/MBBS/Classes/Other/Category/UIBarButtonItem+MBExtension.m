//
//  UIBarButtonItem+MBExtension.m
//  MBBS
//
//  Created by 浩渺 on 16/5/31.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "UIBarButtonItem+MBExtension.h"

@implementation UIBarButtonItem (MBExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)aciton{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    
    [button addTarget:target action:aciton forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc]initWithCustomView:button];
}

@end
