//
//  MBTopicVideoView.h
//  MBBS
//
//  Created by 浩渺 on 16/6/16.
//  Copyright © 2016年 biao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBTopic;

@interface MBTopicVideoView : UIView

+ (instancetype)videoView;

@property(nonatomic,strong)MBTopic *topic;

@end
