//
//  OTSNC.h
//  OneStore
//
//  Created by yangjun on 2017/5/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTSNCDelegate.h"

@interface OTSNC : UINavigationController

@property (nonatomic, strong) OTSNCDelegate *customAnimationDelegate;

@end
