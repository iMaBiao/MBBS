//
//  MBTabBar.m
//  MBBS
//
//  Created by 浩渺 on 16/5/31.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBTabBar.h"

@interface MBTabBar()
/**
 *  发布按钮
 */
@property(nonatomic,weak)UIButton *publishButton;

@end

@implementation MBTabBar
/**
 *  在初始化时候添加自己内部的控件
 */
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}
/**
 *  布局子控件
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.publishButton.width =  self.publishButton.currentBackgroundImage.size.width,
    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);

    //设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        //如果tabBar的子控件不是继承UIControl 或子控件是发布按钮，继续遍历，直到找到继承UIControl的子控件（UITabBarButton）
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        CGFloat buttonX = buttonW * ((index > 1)?(index +1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
    }
}



@end
