//
//  MBTopicViewController.m
//  MBBS
//
//  Created by 浩渺 on 16/6/13.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBTopicViewController.h"
#import "MBTopic.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MBTopicCell.h"

@interface MBTopicViewController()
/** 帖子数据 */
@property(nonatomic,strong)NSMutableArray *topics;

/** 当前页码 */
@property(nonatomic,assign)NSInteger page;

/** 当加载下一页数据时需要这个参数 */
@property(nonatomic,copy)NSString *maxtime;

/** 上一次的请求参数 */
@property(nonatomic,strong)NSDictionary *params;

@end

@implementation MBTopicViewController

static NSString * const MBTopicCellID = @"topic";

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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor  = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MBTopicCell class]) bundle:nil] forCellReuseIdentifier:MBTopicCellID];
    
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
        
        if (self.params != params) {//如果同时发送两个请求，参数就会不同，就会停止发送第一个请求
            return ;
        }
        
        //        MBLog(@"%s--responseObject = %@",__func__,responseObject);
        
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
    
    MBTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:MBTopicCellID];
    
    cell.topic = self.topics[indexPath.row];
    return cell;
}
#pragma mark - Table view Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MBTopic *topic = self.topics[indexPath.row];
    
//    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4*10, MAXFLOAT);
//    CGFloat textH =  [topic.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size.height;
//    
//    CGFloat cellH = 55 + textH + 44 + 4 *10 ;
//    NSLog(@"cellHeight = %f\n\n\n",topic.cellHeight); 
    
    return topic.cellHeight;
}


@end
