//
//  MBPublishViewController.m
//  MBBS
//
//  Created by 浩渺 on 16/6/15.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBPublishViewController.h"
#import "MBVerticalButtton.h"
#import "POP.h"

@interface MBPublishViewController ()

@end

@implementation MBPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    

    
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
        [self.view addSubview:button];
        
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
//        //设置frame
//        button.width = buttonW;
//        button.height = buttonH;
//        int row  = i / maxCols;
//        int col = i % maxCols;
//        button.x = buttonStartX + col * (xMargin + buttonW);
//        button.y = buttonStartY + row * buttonH ;
        
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
        
        animation.springBounciness = 10;
        animation.springSpeed  = 10;
        animation.beginTime = CACurrentMediaTime() + 0.1 * i;
        [button pop_addAnimation:animation forKey:nil];
    }
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    //    sloganView.y = theHeight * 0.2;
    //    sloganView.centerX = theWidth * 0.5;
    [self.view addSubview:sloganView];
    
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
        self.view.userInteractionEnabled = YES;
    }];
    
    [sloganView pop_addAnimation:animation forKey:nil];
    
}
-(void)buttonClick:(UIButton *)button{
    [self cancleWithCompletionBlock:^{
        
    }];
}


- (void)cancleWithCompletionBlock:(void(^)())completionBlock{
    //让控制器不能被点击
    self.view.userInteractionEnabled = NO;
    int beginIndex = 2;
    
    for (int i = beginIndex; i< self.view.subviews.count; i++) {
        UIView  *subView = self.view.subviews[i];
        //基本动画
//        POPBaseAnimation *animation = [POPBaseAnimation ]
    }
}

/**
 *  关闭页面
 */
- (IBAction)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
