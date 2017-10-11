//
//  MessageViewController.m
//  WeiChat
//
//  Created by 杨俊 on 2017/10/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "MessageViewController.h"
#import "SearchTableViewController.h"
#import "ChatViewController.h"
#import "MessageCell.h"
#import "Group.h"
#import "User.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadDataSource];
}

- (void)setupUI{
    self.view.backgroundColor = HEXRGBCOLOR(0xf4f1f1);
    
    SearchTableViewController *searchVC  = [[SearchTableViewController alloc] init];
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:searchVC];
    [searchController.searchBar sizeToFit];
    [searchController.searchBar setBarTintColor:BACKGROUNDCOLOR];
    [searchController.searchBar.layer setBorderWidth:0.5f];
    [searchController.searchBar.layer setBorderColor:BACKGROUNDCOLOR.CGColor];
    searchController.dimsBackgroundDuringPresentation = YES;
    searchController.view.backgroundColor = [UIColor whiteColor];
    searchController.hidesNavigationBarDuringPresentation = YES;

    self.tableView.tableHeaderView = searchController.searchBar;
//    self.tableView.frame  = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - searchController.searchBar.bottom-8-49);
    self.tableView.frame  = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.definesPresentationContext = YES;
}

- (void)loadDataSource{
    NSArray *dataArr = @[@{@"name":@"吴正祥",@"content":@"*本应用集成了图灵机器人的自动聊天功能"},
                         @{@"name":@"陈维",@"content":@"*麻麻再也不怕进来之后没有事干了..."},
                         @{@"name":@"吴正祥",@"content":@"您已添加了Darui Li，现在可以开始聊天了。"},
                         @{@"name":@"吴正祥",@"content":@"您已添加了Darui Li，现在可以开始聊天了。"},
                         @{@"name":@"吴正祥",@"content":@"您已添加了Darui Li，现在可以开始聊天了。"},
                         @{@"name":@"吴正祥",@"content":@"您已添加了Darui Li，现在可以开始聊天了。"},
                         @{@"name":@"吴正祥",@"content":@"您已添加了Darui Li，现在可以开始聊天了。"},
                         @{@"name":@"吴正祥",@"content":@"您已添加了Darui Li，现在可以开始聊天了。"}];
    for (NSDictionary *dict in dataArr) {
        Group *group = [[Group alloc] init];
        group.unReadCount = 2;
        group.gName = dict[@"name"];
        group.lastMsgString = dict[@"content"];
        [self.dataArray addObject:group];
    }
    [self.tableView reloadData];
}

#pragma mark - tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell *cell = [MessageCell cellWithTableView:tableView];
    if (indexPath.row == self.dataArray.count - 1) {
        [cell setBottomLineStyle:CellLineStyleNone];
    } else {
        [cell setBottomLineStyle:CellLineStyleDefault];
    }
    cell.group = self.dataArray[indexPath.row];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67.0;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *topTitle ,*readTitle;
    Group *group  = self.dataArray[indexPath.row];
    topTitle  = group.isTop ? @"取消置顶" : @"置顶";
    readTitle = group.unReadCount ? @"标为已读" : @"标为未读";
    //设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //        [self deleteLocalGroup:indexPath];
    }];
    //置顶
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:topTitle handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //        [self setTopCellWithIndexPath:indexPath currentTop:group.isTop];
    }];
    //标记已读
    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:readTitle handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //        [self markerReadWithIndexPath:indexPath currentUnReadCount:group.unReadCount];
    }];
    collectRowAction.backgroundColor = [UIColor grayColor];
    topRowAction.backgroundColor     = [UIColor orangeColor];
    return  @[deleteRowAction,topRowAction,collectRowAction];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Group *group               = self.dataArray[indexPath.row];
    ChatViewController *chatVc = [[ChatViewController alloc] init];
    chatVc.group                 = group;
    [self.navigationController pushViewController:chatVc animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (UITableView *)tableView{
    if (nil == _tableView) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        tableView.backgroundColor = HEXRGBCOLOR(0xf4f1f1);
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSMutableArray *)dataArray{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return  _dataArray;
}

@end
