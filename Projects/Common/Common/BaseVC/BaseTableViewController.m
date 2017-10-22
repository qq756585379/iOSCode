//
//  BaseTableViewController.m
//  TZTV
//
//  Created by Luosa on 2016/11/8.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kF5F5F5;
    self.tableView.tableFooterView=[UIView new];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self cancelFirstResponse];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self cancelFirstResponse];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self cancelFirstResponse];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self cancelFirstResponse];
}

#pragma mark - Table view data source
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(void)cancelFirstResponse{
    [self.view endEditing:YES];
    [self resignFirstResponder];
    [self.view resignFirstResponder];
}

-(void)dealloc{
    [self cancelFirstResponse];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end





