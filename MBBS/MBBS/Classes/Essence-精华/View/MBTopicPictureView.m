//
//  MBTopicPictureView.m
//  MBBS
//
//  Created by 浩渺 on 16/6/14.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBTopicPictureView.h"
#import "MBTopic.h"
#import "UIImageView+WebCache.h"

@interface MBTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@end

@implementation MBTopicPictureView

+ (instancetype)pictureView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([MBTopicPictureView class]) owner:nil options:nil]lastObject];
}

- (void)setTopic:(MBTopic *)topic{
    _topic = topic;
    
    /**
     在不知道图片扩展名的情况下, 如何知道图片的真实类型?
     * 取出图片数据的第一个字节, 就可以判断出图片的真实类型
     */
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //判断是否是gif图
     NSString *extension = topic.large_image.pathExtension;
    //不是gif拓展名的就隐藏gifView
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    if (topic.isBigPicture) {//大图
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{//非大图
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}

@end
