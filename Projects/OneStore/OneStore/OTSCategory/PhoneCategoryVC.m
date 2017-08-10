//
//  PhoneCategoryVC.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/8.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "PhoneCategoryVC.h"
#import "PhoneCategoryCVCell.h"

@interface PhoneCategoryVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) OTSTableView *tableView;
@property (nonatomic, strong) OTSCollectionView *collectionView;
@property (nonatomic, strong) UIView   *advertisementView;
@property (nonatomic, strong) UIButton *adsBtnOne;//广告button
@property (nonatomic, strong) UIButton *adsBtnTwo;
@end

@implementation PhoneCategoryVC

+ (void)load{
    OTSMappingVO *vo = [OTSMappingVO new];
    vo.className = NSStringFromClass(self);
    vo.loadFilterType = OTSMappingClassPlatformTypePhone;
    [[OTSRouter singletonInstance] registerRouterVO:vo withKey:@"category"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self observeNotification:OTS_ADDRESS_CHANGED];
    [self initParms];
    [self initTitleBar];
    [self initUI];
    [self initConstrains];
}

- (void)initUI {
    self.tableView = [[OTSTableView alloc] initWithFrame:CGRectZero];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[PhoneCategoryTVCell class] forCellReuseIdentifier:[PhoneCategoryTVCell cellReuseIdentifier]];
    
    UICollectionViewFlowLayout*flowLayout=[[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[PhoneCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints=NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = YES;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[PhoneCategoryCVCell class] forCellWithReuseIdentifier:[PhoneCategoryCVCell cellReuseIdentifier]];
    [self.collectionView registerClass:[PhoneCategoryCVHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[PhoneCategoryCVHeaderView cellReuseIdentifier]];
    
    [self.view addSubview:_collectionView];
    [self.view addSubview:_tableView];
}

- (void)initConstrains {
    NSDictionary *views = NSDictionaryOfVariableBindings(_collectionView, _tableView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableView(80)]-0-[_collectionView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_tableView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_collectionView]-0-|" options:0 metrics:nil views:views]];
}



@end
