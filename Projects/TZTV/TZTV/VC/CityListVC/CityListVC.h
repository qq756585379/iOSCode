//
//  CityListVC.h
//  TZTV
//
//  Created by Luosa on 2016/11/11.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "BaseTableViewController.h"

@interface CityListVC : BaseTableViewController

@property (nonatomic,  copy) void(^selectCityBlock)(NSString *cityName);

@end