//
//  MBTextField.m
//  MBBS
//
//  Created by 浩渺 on 16/6/6.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBTextField.h"

static NSString *const  MBPlacehoderColorKeyPath = @"_placeholderLabel.textColor";

@implementation MBTextField

- (void)awakeFromNib{
    
    self.tintColor = self.textColor;
    
    [self resignFirstResponder];
}

/**
 *  当前文本框成为焦点时调用
 */
- (BOOL)becomeFirstResponder{
    //修改占位文字的颜色
    [self setValue:self.textColor forKeyPath:MBPlacehoderColorKeyPath];
    return [super becomeFirstResponder];
}
/**
 *  当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:MBPlacehoderColorKeyPath];
    
    return [super resignFirstResponder];
}


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
