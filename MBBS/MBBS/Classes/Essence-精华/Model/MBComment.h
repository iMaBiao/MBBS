//
//  MBComment.h
//  MBBS
//
//  Created by 浩渺 on 16/6/18.
//  Copyright © 2016年 biao. All rights reserved.
//  评论模型

#import <Foundation/Foundation.h>
@class MBUser;

@interface MBComment : NSObject
/** 音频文件的时长 */
@property(nonatomic,assign)NSInteger voicetime;
/** 评论的文字内容 */
@property(nonatomic,copy)NSString *content;
/** 被点赞的数量 */
@property(nonatomic,assign)NSInteger like_count;
/** 用户 */
@property(nonatomic,strong)MBUser  *user;
@end
