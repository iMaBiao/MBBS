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

@property (weak, nonatomic) IBOutlet UILabel *text_Label;

@end

@implementation MBTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
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
 
    self.text_Label.text = topic.text;
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

    frame.origin.x = MBTopicCellMargin;
    frame.size.width -=  2 * MBTopicCellMargin;
    frame.size.height -= MBTopicCellMargin;
    frame.origin.y += MBTopicCellMargin;
    
    [super setFrame:frame];
}

@end
