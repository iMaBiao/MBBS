//
//  MBShowPictureController.m
//  MBBS
//
//  Created by 浩渺 on 16/6/15.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBShowPictureController.h"
#import "SVProgressHUD.h"
#import "MBProgressView.h"
#import "UIImageView+WebCache.h"
#import "MBTopic.h"

@interface MBShowPictureController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet MBProgressView *progressView;

@property(nonatomic,weak)UIImageView *imageView;

@end

@implementation MBShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [imageView addGestureRecognizer:tap];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    CGFloat pictureW = theWidth;
//nowW     nowH
//lastW   lastH
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH >= theHeight) {
        // 图片显示高度超过一个屏幕, 需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize= CGSizeMake(0, pictureH);
    }else{
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = theHeight * 0.5;
    }
    
    //马上显示当前图片的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    //下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
    }];
    
}
/**
 *  返回
 */
- (IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  保存
 */
- (IBAction)save{
    
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片没有下载完毕"];
        return;
    }
    
    //将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

/**
 *  转发
 */
- (IBAction)share{
    MBLog(@"%s---share ",__func__);
}

@end
