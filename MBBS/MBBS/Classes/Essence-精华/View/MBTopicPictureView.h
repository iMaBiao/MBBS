//
//  MBTopicPictureView.h
//  MBBS
//
//  Created by 浩渺 on 16/6/14.
//  Copyright © 2016年 biao. All rights reserved.
//  图片帖子中间的内容

#import <UIKit/UIKit.h>
@class MBTopic;
@interface MBTopicPictureView : UIView

+ (instancetype)pictureView;

@property(nonatomic,strong)MBTopic *topic;

@end
