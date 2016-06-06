//
//  MBTextField.m
//  MBBS
//
//  Created by 浩渺 on 16/6/6.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBTextField.h"

@implementation MBTextField


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

- (void)drawPlaceholderInRect:(CGRect)rect{
    [self.placeholder drawInRect:CGRectMake(0, 10, rect.size.width, 25) withAttributes:@{
        NSForegroundColorAttributeName:[UIColor grayColor],
        NSFontAttributeName:self.font
        }];
}

@end
