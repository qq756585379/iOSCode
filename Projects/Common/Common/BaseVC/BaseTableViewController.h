//
//  BaseTableViewController.h
//  TZTV
//
//  Created by Luosa on 2016/11/8.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *dataArray;

-(void)cancelFirstResponse;

@end
