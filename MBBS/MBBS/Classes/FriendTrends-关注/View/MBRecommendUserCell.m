//
//  MBRecommendUserCell.m
//  MBBS
//
//  Created by 浩渺 on 16/6/1.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBRecommendUserCell.h"
#import "MBRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface MBRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation MBRecommendUserCell

- (void)setUser:(MBRecommendUser *)user{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text  = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
//    MBLog(@"user.screen_name = %@",user.screen_name);
//    MBLog(@"user.fans_count = %ld",user.fans_count);
//    MBLog(@"user.head = %@",user.header);
    
}


@end
