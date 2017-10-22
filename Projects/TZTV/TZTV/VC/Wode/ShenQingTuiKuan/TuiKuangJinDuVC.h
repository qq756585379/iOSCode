//
//  TuiKuangJinDuVC.h
//  TZTV
//
//  Created by Luosa on 2016/12/9.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSUInteger, TuiKuangJinDuType) {
    TypeFromShenQingTuiKuanVC = 1,
};

@interface TuiKuangJinDuVC : BaseTableViewController

@property (nonatomic, assign) TuiKuangJinDuType type;

@end
