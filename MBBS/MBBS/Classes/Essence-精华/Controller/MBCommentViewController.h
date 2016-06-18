//
//  MBCommentViewController.h
//  MBBS
//
//  Created by 浩渺 on 16/6/18.
//  Copyright © 2016年 biao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBTopic;

@interface MBCommentViewController : UIViewController
/** 帖子模型 */
@property(nonatomic,strong)MBTopic *topic;

@end
