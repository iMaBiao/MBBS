//
//  MBRecommendCategory.m
//  MBBS
//
//  Created by 浩渺 on 16/6/1.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBRecommendCategory.h"

@implementation MBRecommendCategory
- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//    
//}


@end
