//
//  YouHuiJuanSubVC.h
//  TZTV
//
//  Created by Luosa on 2016/11/28.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSUInteger, YouHuiJuanType) {
    YouHuiJuanTypeXianShang   = 1,
    YouHuiJuanTypeXianXia     = 2
};

@interface YouHuiJuanSubVC : BaseTableViewController

@property (nonatomic, assign) YouHuiJuanType type;

@end
