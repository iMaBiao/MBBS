//
//  MBEssenceTagsController.m
//  MBBS
//
//  Created by 浩渺 on 16/6/3.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBEssenceTagsController.h"
#import "MBEssenceTags.h"
#import "MBEssenceTagsCell.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"

@interface MBEssenceTagsController ()
/** 标签数据 */
@property(nonatomic,strong)NSArray *tags;

@end

static NSString *const MBTagsID = @"tag";

@implementation MBEssenceTagsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableView];
    
    [self loadTags];
}

- (void)setTableView {

    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MBEssenceTagsCell class]) bundle:nil] forCellReuseIdentifier:MBTagsID];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = MBGlobaBg;
    
}
- (void)loadTags {
    
    [SVProgressHUD show];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.tags = [MBEssenceTags mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MBEssenceTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:MBTagsID];
    
    cell.essenceTags = self.tags[indexPath.row];
    
    return cell;
}


@end
