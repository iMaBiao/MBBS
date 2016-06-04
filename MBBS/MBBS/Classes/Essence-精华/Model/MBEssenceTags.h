//
//  MBEssenceTags.h
//  MBBS
//
//  Created by 浩渺 on 16/6/3.
//  Copyright © 2016年 biao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBEssenceTags : NSObject
/** 图片 */
@property(nonatomic,copy)NSString *image_list;
/** 名字 */
@property(nonatomic,copy)NSString *theme_name;
/** 订阅数 */
@property(nonatomic,assign)NSInteger sub_number;

@end
