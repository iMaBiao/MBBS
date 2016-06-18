//
//  MBTopicCell.m
//  MBBS
//
//  Created by 浩渺 on 16/6/12.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBTopicCell.h"
#import "MBTopic.h"
#import "UIImageView+WebCache.h"
#import "MBTopicPictureView.h"
#import "MBTopicVoiceView.h"
#import "MBTopicVideoView.h"
#import "MBComment.h"
#import "MBUser.h"
#import "MBComment.h"


@interface MBTopicCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 关注 */
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_Label;

/** 图片帖子中间的图片 */
@property(nonatomic,weak)MBTopicPictureView *pictureView;
/***  图片帖子中间的声音*/
@property(nonatomic,weak)MBTopicVoiceView *voiceView;
/** 视频帖子中间的内容 */
@property(nonatomic,weak)MBTopicVideoView *videoView;
/** 最热评论的内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/** 最热评论的整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end

@implementation MBTopicCell

- (MBTopicPictureView *)pictureView{
    if (!_pictureView) {
        MBTopicPictureView *pictureView = [MBTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
- (MBTopicVoiceView *)voiceView{
    if (!_voiceView) {
        MBTopicVoiceView *voiceView = [MBTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (MBTopicVideoView *)videoView{
    if (!_videoView) {
        MBTopicVideoView *videoView = [MBTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}


- (void)awakeFromNib {
//    [super awakeFromNib];
//    UIImageView *bgView = [[UIImageView alloc]init];
//    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}


- (void)setTopic:(MBTopic *)topic{
    _topic = topic;
    
    self.sinaVView.hidden = !topic.isSina_V;
    
    // 设置其他控件
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    
    // 设置按钮文字
    [self setButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setButtonTitle:self.commentButton count:topic.comment placeholder:@"转发"];
    
    //文字内容
    self.text_Label.text = topic.text;
    
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == MBTopicTypePicture) {//图片
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
    }else if(topic.type == MBTopicTypeVoice){//声音
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (topic.type == MBTopicTypeVideo){//视频
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }else{
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    //处理最热评论
    MBComment *cmt = [topic.top_cmt firstObject];
    if (cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",cmt.user.username,cmt.content];
    }else{
        self.topCmtView.hidden = YES;
    }
}

/**
 *  设置底部按钮文字
 */
- (void)setButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count/10000.0];
    }else if (count >0){
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame{

//    frame.origin.x = MBTopicCellMargin;
//    frame.size.width -=  2 * MBTopicCellMargin;
//    frame.size.height -= MBTopicCellMargin;
//    frame.origin.y += MBTopicCellMargin;
    
    frame.origin.x = MBTopicCellMargin;
    frame.size.width -= 2 *MBTopicCellMargin;
    frame.size.height -= MBTopicCellMargin;
    frame.origin.y += MBTopicCellMargin;
    
    [super setFrame:frame];
}

@end
