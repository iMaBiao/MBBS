//
//  MBTopic.h
//  MBBS
//
//  Created by 浩渺 on 16/6/12.
//  Copyright © 2016年 biao. All rights reserved.
//  帖子

#import <Foundation/Foundation.h>

@interface MBTopic : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *name;

/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;

/** 文字内容 */
@property (nonatomic, copy) NSString *text;

/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;

/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;

/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;

/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 是否为新浪加V用户 */
@property(nonatomic,assign,getter=isSina_V)BOOL sina_v;
/** 小图片的URL */
@property(nonatomic,copy)NSString *small_image;
/** 大图片的URL */
@property(nonatomic,copy)NSString *large_image;
/** 中图片的URL */
@property(nonatomic,copy)NSString *middle_image;
/** 帖子的类型 */
@property(nonatomic,assign)MBTopicType type;

/****** 额外的辅助属性 ******/

/** cell的高度 */
@property(nonatomic,assign,readonly)CGFloat  cellHeight;

/** 图片是否太大 */
@property(nonatomic,assign,getter=isBigPicture)BOOL bigPicture;

/** 图片控件的frame */
@property(nonatomic,assign,readonly)CGRect pictureF;
@end
