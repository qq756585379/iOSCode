//
//  MessageViewController.m
//  WeiChat
//
//  Created by 杨俊 on 2017/10/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "MessageViewController.h"
#import "SearchTableViewController.h"
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
    self.tableView.frame  = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - searchController.searchBar.bottom-8-49);
    self.definesPresentationContext = YES;
}

- (void)loadDataSource{
    Group *group = [[Group alloc] init];
    group.unReadCount = 2;
    group.gName = @"马云";
    group.lastMsgString = @"马化腾你等着!";
    
    
    [self.dataArray addObject:group];
}

#pragma mark - tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XZMessageCell *cell = [XZMessageCell cellWithTableView:tableView];
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
