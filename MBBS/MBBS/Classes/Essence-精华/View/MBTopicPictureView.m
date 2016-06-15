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
#import "MBShowPictureController.h"
#import "MBProgressView.h"

@interface MBTopicPictureView()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/** 进度条控件 */
@property (weak, nonatomic) IBOutlet MBProgressView *progressView;

@end

@implementation MBTopicPictureView

+ (instancetype)pictureView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([MBTopicPictureView class]) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib{
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //给图片添加手势
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)];
    [self.imageView addGestureRecognizer:tap];
}
- (void)showPicture{
    MBShowPictureController *showPicture = [[MBShowPictureController alloc]init];
    //传递数据过去
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}
- (void)setTopic:(MBTopic *)topic{
    _topic = topic;
    
    //立即显示最新的进度值
    [self.progressView setProgress:topic.pictureProgress animated:YES];
    
    /**
     在不知道图片扩展名的情况下, 如何知道图片的真实类型?
     * 取出图片数据的第一个字节, 就可以判断出图片的真实类型
     */
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        
        //计算进度值
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        //显示进度值
        [self.progressView setProgress:topic.pictureProgress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
       
        //如果是大图，就就行绘图处理（显示图片的top部分）
        if (topic.isBigPicture == NO) {
            return ;
        }
        
        //开启图层上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0);
        //将下载完的图片绘制到图形上下文
        CGFloat  width = topic.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        //获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        //结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
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
