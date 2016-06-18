//
//  MBTopicVideoView.m
//  MBBS
//
//  Created by 浩渺 on 16/6/16.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBTopicVideoView.h"
#import "MBTopic.h"
#import "UIImageView+WebCache.h"
#import "MBShowPictureController.h"

@interface MBTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@end

@implementation MBTopicVideoView

+ (instancetype)videoView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([MBTopicVideoView class]) owner:nil options:nil]lastObject];
}
- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture{
    MBShowPictureController *showPicture = [[MBShowPictureController alloc]init];
    showPicture.topic = self.topic;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopic:(MBTopic *)topic{
    
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playcountLabel.text  = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd%02zd",minute,second];

}
@end
