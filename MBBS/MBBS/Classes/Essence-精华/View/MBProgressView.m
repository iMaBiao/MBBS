//
//  MBProgressView.m
//  MBBS
//
//  Created by 浩渺 on 16/6/15.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBProgressView.h"

@implementation MBProgressView

-(void)awakeFromNib{
    self.roundedCorners = 3;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    [super setProgress:progress animated:animated];
    
    //设置进度的百分比，保留0位小数
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    
    //去掉字符串中的 -
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
