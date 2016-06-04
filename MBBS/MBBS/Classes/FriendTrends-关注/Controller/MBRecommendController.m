//
//  MBRecommendController.m
//  MBBS
//
//  Created by 浩渺 on 16/6/1.
//  Copyright © 2016年 biao. All rights reserved.
//

#import "MBRecommendController.h"
#import "SVProgressHUD.h"
#import "MBRecommendCategoryCell.h"
#import "MBRecommendCategory.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MBRecommendUser.h"
#import "MBRecommendUserCell.h"
#import "MJRefresh.h"

#define MBSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface MBRecommendController ()<UITableViewDataSource,UITableViewDelegate>
/** 左边的类别数据 */
@property(nonatomic,strong)NSArray *categories;
/** 右边的用户数据 */
@property(nonatomic,strong)NSArray *users;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/** 请求参数 */
@property(nonatomic,strong)NSMutableDictionary *params;
/** AFN请求管理者 */
@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end

static NSString *const MBCategoryID = @"category";
static NSString *const MBUserID = @"user";

@implementation MBRecommendController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setTableView];
    
    // 添加刷新控件
    [self setRefresh];
    
    // 加载左侧的类别数据
    [self loadCategories];
}

/**
 *  加载左侧的类别数据
 */
- (void)loadCategories{
    // 显示指示器
    [SVProgressHUD show];
    //'showWithMaskType:' is deprecated: Use show and setDefaultMaskType: instead.
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        MBLog(@"category --responseObject = %@",responseObject);
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据
        self.categories = [MBRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        MBLog(@"self.categories = %@",self.categories);
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO  scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];

    
}
- (void)setRefresh{
 
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.mj_footer.hidden = YES;
}

/**
 *  加载用户数据
 */
- (void)loadNewUsers{
    MBRecommendCategory *category = MBSelectedCategory;
    category.currentPage = 1; // 设置当前页码为1
   
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 字典数组 -> 模型数组
        NSArray *users = [MBRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        // 清除所有旧数据
        [category.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
         // 保存总数
        category.total = [responseObject[@"total"]integerValue];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreUsers{
     MBRecommendCategory *category = MBSelectedCategory;
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MBLog(@"loadMoreUsers-responseObject = %@",responseObject[@"list"]);
        
        NSArray *users = [MBRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        // 不是最后一次请求
        if (self.params != params) return ;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params)  return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        //结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}

/**
 *  时刻监测footer的状态
 */
- (void)checkFooterState{
    MBRecommendCategory *category = MBSelectedCategory;
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (category.users.count == 0);
    
    // 让底部控件结束刷新
    if (category.users.count == category.total) {// 全部数据已经加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{// 还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];
    }
    
}
- (void)setTableView{
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MBRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:MBCategoryID];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MBRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:MBUserID];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    self.view.backgroundColor = MBGlobaBg;
    self.title = @"推荐关注";
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    // 左边的类别表格
    if (tableView == self.categoryTableView) return  self.categories.count;
        
    // 监测footer的状态
    [self checkFooterState];
    
    //右边表格
//    MBRecommendCategory *category = MBSelectedCategory;
//    return category.users.count;

    return [MBSelectedCategory users].count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTableView) {
        MBRecommendCategoryCell *cell  = [tableView dequeueReusableCellWithIdentifier:MBCategoryID];
        cell.category = self.categories[indexPath.row];
        return cell;
    }else{
        MBRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:MBUserID];
        cell.user = [MBSelectedCategory users][indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    MBRecommendCategory *category = self.categories[indexPath.row];
    if (category.users.count) {
        // 显示曾经的数据
        [self.userTableView reloadData];
    }else{
        // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
         [self.userTableView reloadData];
        // 进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark - 控制器的销毁
- (void)dealloc{
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}


@end


//loadNewUsers-responseObject = [
//                               {
//    introduction : 粉丝首选老公，编剧里最会做饭的，做饭里最帅的，帅哥里最会写剧本的,
//    uid : 12773257,
//    header : http://wimg.spriteapp.cn/profile/large/2014/12/18/549289b1cff17_mini.jpg,
//    gender : 0,
//    is_vip : 0,
//    fans_count : 40497,
//    tiezi_count : 29,
//    is_follow : 0,
//    screen_name : 香喷喷的小烤鸡
//    },
//     {
//   introduction : 胸大颜值高，唱歌有特色,
//   uid : 17718943,
//   header : http://wimg.spriteapp.cn/profile/large/2016/03/08/56de699620921_mini.jpg,
//   gender : 1,
//   is_vip : 0,
//   fans_count : 4875,
//   tiezi_count : 6,
//   is_follow : 0,
//   screen_name : 祖瑜兄
//  }]

