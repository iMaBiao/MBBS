//
//  MBPushGuideView.m
//  MBBS
//
//  Created by 浩渺 on 16/6/6.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBPushGuideView.h"

@implementation MBPushGuideView

+ (instancetype)guideView{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([MBPushGuideView class]) owner:nil options:nil]lastObject];
    
}
+ (void)show{
    NSString *key  = @"CFBundleShortVersionString";
    //当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //沙盒版本号
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults]stringForKey:key];
    
    if (![currentVersion isEqualToString:sandboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        MBPushGuideView *guideView = [MBPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        //存储版本号
//        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
//        [[NSUserDefaults standardUserDefaults]synchronize];
    }

}

- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}

@end
