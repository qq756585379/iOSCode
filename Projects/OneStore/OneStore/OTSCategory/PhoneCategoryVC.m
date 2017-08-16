//
//  PhoneCategoryVC.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/8.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "PhoneCategoryVC.h"
#import "PhoneCategoryCVCell.h"
#import "PhoneCategoryTVCell.h"

@interface PhoneCategoryVC ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) OTSTableView *tableView;
@property (nonatomic, strong) OTSCollectionView *collectionView;
@property (nonatomic, strong) UIView   *advertisementView;
@property (nonatomic, strong) UIButton *adsBtnOne;//广告button
@property (nonatomic, strong) UIButton *adsBtnTwo;
@property (nonatomic, strong) OTSCategoryLogic * categoryLogic;
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


#pragma mark - 属性 propertys
- (OTSCategoryLogic *)categoryLogic{
    if(_categoryLogic == nil){
        _categoryLogic = [OTSCategoryLogic logicWithOperationManager:self.operationManager];
    }
    return _categoryLogic;
}

-(UIView *)advertisementView{
    if (!_advertisementView) {
        //        _advertisementView = [UIView autolayoutView];
        _advertisementView = [[UIView alloc] init];
        _advertisementView.backgroundColor = [UIColor clearColor];
    }
    return _advertisementView;
}

-(UIButton *)adsBtnOne{
    if (!_adsBtnOne) {
        _adsBtnOne = [[UIButton alloc] init];
        _adsBtnOne.adjustsImageWhenHighlighted = NO;
        _adsBtnOne.titleLabel.textColor = [UIColor clearColor];
        _adsBtnOne.tag = 1;
        [_adsBtnOne addTarget:self action:@selector(asdTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _adsBtnOne;
}

-(UIButton *)adsBtnTwo{
    if (!_adsBtnTwo) {
        _adsBtnTwo = [[UIButton alloc] init];
        _adsBtnTwo.adjustsImageWhenHighlighted = NO;
        _adsBtnTwo.titleLabel.textColor = [UIColor clearColor];
        _adsBtnTwo.tag = 2;
        [_adsBtnTwo addTarget:self action:@selector(asdTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _adsBtnTwo;
}


- (OTSCyclePageImageView *)pageView{
    if (!_pageView) {
        _pageView = [[OTSCyclePageImageView alloc] init];;
        _pageView.dataSource = self;
        _pageView.delegate = self;
    }
    return _pageView;
}


- (OTSPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[OTSPageControl alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    }
    return _pageControl;
}

//空态view
- (PhoneDetailNilView *)nilView{
    if (_nilView == nil) {
        _nilView = [[PhoneDetailNilView alloc] initWithFrame:self.view.bounds];
        self.nilView.type = PhoneNilViewType_Detail;
        self.nilView.delegate  = self;
    }
    return _nilView;
}

@end
