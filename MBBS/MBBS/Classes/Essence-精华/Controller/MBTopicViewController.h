//
//  MBTopicViewController.h
//  MBBS
//
//  Created by 浩渺 on 16/6/13.
//  Copyright © 2016年 biao. All rights reserved.
//  最基本的帖子控制器

#import <UIKit/UIKit.h>

typedef enum{
    MBTopicTypeAll = 1,
    MBTopicTypePicture = 10,
    MBTopicTypeVideo = 41,
    MBTopicTypeVoice = 31,
    MBTopicTypeWord = 29,
}MBTopicType;

@interface MBTopicViewController : UITableViewController
/** 帖子类型(交给子类去实现) */
@property(nonatomic,assign)MBTopicType type;

@end
