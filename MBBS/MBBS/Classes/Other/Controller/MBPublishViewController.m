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
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = theHeight * 0.2;
    sloganView.centerX = theWidth * 0.5;
    [self.view addSubview:sloganView];
    
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
        
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        //设置frame
        button.width = buttonW;
        button.height = buttonH;
        int row  = i / maxCols;
        int col = i % maxCols;
        button.x = buttonStartX + col * (xMargin + buttonW);
        button.y = buttonStartY + row * buttonH ;
        
        [self.view addSubview:button];
    }
}


- (IBAction)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
