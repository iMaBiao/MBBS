//
//  MBWordViewController.m
//  MBBS
//
//  Created by 浩渺 on 16/6/8.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBWordViewController.h"
#import "MBTopic.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface MBWordViewController ()
/** 帖子数据 */
@property(nonatomic,strong)NSMutableArray *topics;

/** 当前页码 */
@property(nonatomic,assign)NSInteger page;

/** 当加载下一页数据时需要这个参数 */
@property(nonatomic,copy)NSString *maxtime;

/** 上一次的请求参数 */
@property(nonatomic,strong)NSDictionary *params;
@end

@implementation MBWordViewController

- (NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     // 初始化表格
    [self setTableView];
    // 添加刷新控件
    [self setRefresh];
}
- (void)setTableView{
    
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = 64 + 35;
    self.tableView.contentInset  = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
}
- (void)setRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

/**
 * 加载新的数据
 */
- (void)loadNewTopics{
    [self.tableView.mj_footer endRefreshing];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    
    self.params = params;
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.params != params) {
            return ;
        }
        
        MBLog(@"%s--responseObject = %@",__func__,responseObject);
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //将字典数组转成模型数组
        self.topics = [MBTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        //清空页码
        self.params = 0;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) {
            return ;
        }
        [self.tableView.mj_header endRefreshing];
    }];
}
/**
 * 加载更多数据
 */
- (void)loadMoreTopics{
    
    [self.tableView.mj_header endRefreshing];
    
    self.page++;
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) {
            return ;
        }
        
        self.maxtime = responseObject[@"info"][@"list"];
        
        NSArray *newTopics = [MBTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) {
            return ;
        }
        
        [self.tableView.mj_footer endRefreshing];
        
        self.page--;
    }];
    
    
}
#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"topic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    MBTopic *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] ];
    return cell;
}

@end
