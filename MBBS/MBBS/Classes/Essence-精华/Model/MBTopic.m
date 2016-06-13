
//
//  MBTopic.m
//  MBBS
//
//  Created by 浩渺 on 16/6/12.
//  Copyright © 2016年 biao. All rights reserved.
//帖子

#import "MBTopic.h"

@implementation MBTopic
{
    CGFloat _cellHeight;
}

- (CGFloat)cellHeight{
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4* 10, MAXFLOAT);
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
//        NSLog(@"%s--textH = %f",__func__,textH);
        // cell的高度
        _cellHeight = 55  + 44 + 2 * 10 + textH;
        
//        NSLog(@"%s--cellHeight = %f",__func__,_cellHeight);
    }
    return _cellHeight;
}

- (NSString *)create_time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *create = [formatter dateFromString:_create_time];
    
    if (create.isThisYear) {    //今年
        if (create.isToday) {   //今天
            NSDateComponents *dateComponents = [[NSDate date]deltaFrom:create];
            if (dateComponents.hour >= 1 ) {  //时间差距大于1小时
                return [NSString stringWithFormat:@"%zd小时前",dateComponents.hour];
            }else if (dateComponents.minute >=1 ){  //时间差距大于1分钟
                return [NSString stringWithFormat:@"%zd分钟前",dateComponents.minute];
            }else{  //时间差距小于1分钟
                return @"刚刚";
            }
        }else if (create.isYesterday){  //昨天
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:create];
        }else{  //其他（非近几天）
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:create];
        }
    }else{  //非今年
        return _create_time;
    }
}

@end
