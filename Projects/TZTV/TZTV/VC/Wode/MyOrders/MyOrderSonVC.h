//
//  MyOrderSonVC.h
//  TZTV
//
//  Created by Luosa on 2016/11/22.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "BaseTableViewController.h"

@interface MyOrderSonVC : BaseTableViewController

//0全部 1待支付 2待发货 3待收货 4交易完成
@property (nonatomic, assign) NSInteger type;

@end
