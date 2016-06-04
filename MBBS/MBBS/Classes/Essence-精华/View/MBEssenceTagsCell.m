//
//  MBEssenceTagsCell.m
//  MBBS
//
//  Created by 浩渺 on 16/6/3.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBEssenceTagsCell.h"
#import "MBEssenceTags.h"
#import "UIImageView+WebCache.h"

@interface MBEssenceTagsCell()
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;



@end

@implementation MBEssenceTagsCell

- (void)setEssenceTags:(MBEssenceTags *)essenceTags{
    _essenceTags = essenceTags;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:essenceTags.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.themeNameLabel.text = essenceTags.theme_name;
    
    NSString *subNumber = nil;
    if (essenceTags.sub_number < 1000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",essenceTags.sub_number];
    }else{
        subNumber = [NSString stringWithFormat:@"%0.1f万人订阅",essenceTags.sub_number/10000.0];
    }
    self.subNumberLabel.text = subNumber;
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x = 5;
    frame.size.width -= 2 *frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
