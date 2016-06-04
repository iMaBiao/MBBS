//
//  MBRecommendUser.h
//  MBBS
//
//  Created by 浩渺 on 16/6/1.
//  Copyright © 2016年 biao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBRecommendUser : NSObject
/** 头像 */
@property(nonatomic,copy)NSString *header;
/** 粉丝数(有多少人关注这个用户) */
@property(nonatomic,assign)NSInteger fans_count;
/** 昵称 */
@property(nonatomic,copy)NSString *screen_name;

@end
