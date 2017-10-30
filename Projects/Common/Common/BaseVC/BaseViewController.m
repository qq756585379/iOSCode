//
//  BaseViewController.m
//  TZTV
//
//  Created by Luosa on 2016/11/8.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD+MJ.h"

@implementation BaseViewController

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kF5F5F5;
    
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
    [MBProgressHUD hideHUD];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelFirstResponse];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self cancelFirstResponse];
}
-(void)cancelFirstResponse{
    [self.view endEditing:YES];
    [self.view resignFirstResponder];
    [self resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)dealloc{
    [self cancelFirstResponse];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
