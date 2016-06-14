
//
//  MBTopic.m
//  MBBS
//
//  Created by 浩渺 on 16/6/12.
//  Copyright © 2016年 biao. All rights reserved.
//帖子

#import "MBTopic.h"
#import "MJExtension.h"

@implementation MBTopic

//因为cellHeigit是readonly，Xcode会默认生成生成getter方法和_cellHeight,但是重写了getter方法，就不会自动生成_cellHeight了，所有要自己补充上去
{
    CGFloat _cellHeight;
}

//因为模型属性名与服务器返回的属性名不一致，需要重写这个方法替换属性名
//将属性名换为其他key去字典中取值
//+ (NSDictionary *)mj_replacedKeyFromPropertyName{
//    return @{
//             @"ID":@"id",
//             };
//}
//一对一的将属性名换为其他key去字典中取值
//+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
//    return propertyName;
//}

- (CGFloat)cellHeight{
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4* MBTopicCellMargin, MAXFLOAT);
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;

        // cell的高度
        _cellHeight = MBTopicCellTextY  + MBTopicCellBottomBarH + 3 * MBTopicCellMargin + textH;
        
        NSLog(@"text = %@\n\n",self.text);
        NSLog(@"textH = %f\n\n",textH);
        NSLog(@"cellHeight = %f\n\n",_cellHeight);
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
