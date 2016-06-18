//
//  MBPublishView.m
//  MBBS
//
//  Created by 浩渺 on 16/6/18.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBPublishView.h"
#import "POP.h"
#import "MBVerticalButtton.h"

@interface MBPublishView()

@end

static CGFloat const MBAnimationDelay = 0.1;
static CGFloat const MBSpringFactor = 10;


@implementation MBPublishView

+ (instancetype)publishView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

static UIWindow *window_;
+ (void)show{
    //创建窗口
    window_ = [[UIWindow alloc]init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    window_.hidden = NO;
    
    //添加发布界面
    MBPublishView *publishView  = [MBPublishView publishView];
    publishView.frame = window_.bounds;
    [window_ addSubview:publishView];
}

- (void)awakeFromNib{
    //不能被点击
    self.userInteractionEnabled = NO;
    
    //数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY  = (theHeight - 2 * buttonH) * 0.5;
    CGFloat buttonStartX  = 20;
    CGFloat xMargin = (theWidth - 2 * buttonStartX - maxCols * buttonW) / (maxCols -1);
    for (int i = 0; i < images.count; i++) {
        MBVerticalButtton *button = [[MBVerticalButtton alloc]init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        //计算X Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY =  buttonStartY  + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - theHeight;
        
        //按钮动画
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        animation.springBounciness = MBSpringFactor;
        animation.springSpeed  = MBSpringFactor;
        animation.beginTime = CACurrentMediaTime() + MBAnimationDelay * i;
        [button pop_addAnimation:animation forKey:nil];
    }
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];
    
    //标语动画
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    CGFloat centerX = theWidth * 0.5;
    CGFloat centerEndY = theHeight * 0.2;
    CGFloat centerBeginY = centerEndY - theHeight;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    animation.beginTime = CACurrentMediaTime() + images.count * 0.1;
    animation.springBounciness  = 10;
    animation.springSpeed = 10;
    [animation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        // 标语动画执行完毕, 恢复点击事件
        self.userInteractionEnabled = YES;
    }];
    
    [sloganView pop_addAnimation:animation forKey:nil];
}
- (void)buttonClick:(UIButton *)button{
    [self cancleWithCompletionBlock:^{
        if (button.tag == 0) {
            MBLog(@"发视频");
        }else if (button.tag == 1){
            MBLog(@"发图片");
        }
    }];
}
- (IBAction)cancel:(id)sender {
    [self cancleWithCompletionBlock:nil];
}

- (void)cancleWithCompletionBlock:(void(^)())completionBlock{
    // 不能被点击
    self.userInteractionEnabled = NO;
    int beginIndex = 1;
    
    for (int i = beginIndex; i< self.subviews.count; i++) {
        UIView  *subView = self.subviews[i];
        //基本动画
        POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat  centerY = subView.centerY  + theHeight;
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        animation.beginTime = CACurrentMediaTime() + (i - beginIndex) * 0.1;
        [subView pop_addAnimation:animation forKey:nil];
        
        
        //监听最后一个动画
        if (i == self.subviews.count-1 ) {
            [animation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
                // 销毁窗口
                window_ = nil;
                // 执行传进来的completionBlock参数
                !completionBlock ? :completionBlock();
                
            }];
        }
    }
}

@end
