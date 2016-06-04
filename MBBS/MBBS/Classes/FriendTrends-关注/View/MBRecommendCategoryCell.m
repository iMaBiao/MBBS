//
//  MBRecommendCategoryCell.m
//  MBBS
//
//  Created by 浩渺 on 16/6/1.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBRecommendCategoryCell.h"
#import "MBRecommendCategory.h"

@interface MBRecommendCategoryCell()
/** 选中时显示的指示器控件 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end

@implementation MBRecommendCategoryCell

- (void)awakeFromNib {
//    [super awakeFromNib];
    
    self.backgroundColor = MBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = MBColor(219, 21, 26);
    
}

- (void)setCategory:(MBRecommendCategory *)category{
    
//    NSLog(@"category = %@",category);
    _category = category;
    
    self.textLabel.text = category.name;
  
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 *self.textLabel.y ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    self.selectedIndicator.hidden = !selected;
    //设置文字颜色   
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : MBColor(78, 78, 78);
    
    // Configure the view for the selected state
}

@end
