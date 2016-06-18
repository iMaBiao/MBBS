//
//  MBUser.h
//  MBBS
//
//  Created by 浩渺 on 16/6/18.
//  Copyright © 2016年 biao. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

@interface MBUser : NSObject
/** 用户名 */
@property(nonatomic,copy)NSString *username;
/** 性别 */
@property(nonatomic,copy)NSString *sex;
/** 头像 */
@property(nonatomic,copy)NSString *profile_image;

@end
