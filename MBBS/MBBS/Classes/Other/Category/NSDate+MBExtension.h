//
//  NSDate+MBExtension.h
//  MBBS
//
//  Created by 浩渺 on 16/6/13.
//  Copyright © 2016年 biao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MBExtension)
/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 *  是否是今年
 */
- (BOOL)isThisYear;
/**
 *  是否是今天
 */
- (BOOL)isToday;
/**
 *  是否是昨天
 */
- (BOOL)isYesterday;
@end
