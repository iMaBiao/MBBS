
//
//  MBTopicVoiceView.m
//  MBBS
//
//  Created by 浩渺 on 16/6/16.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBTopicVoiceView.h"
#import "MBTopic.h"
#import "UIImageView+WebCache.h"

@interface MBTopicVoiceView()
/***  图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/***  时长*/
@property (weak, nonatomic) IBOutlet UILabel *voicelengthLabel;
/***  次数*/
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;


@end

@implementation MBTopicVoiceView

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)voiceView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([MBTopicVoiceView class]) owner:nil options:nil]lastObject];
}

- (void)setTopic:(MBTopic *)topic{
    _topic = topic;
    
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    //时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    
    self.voicelengthLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end
