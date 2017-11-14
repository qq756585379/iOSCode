//
//  RACSecondViewController.h
//  Demos
//
//  Created by 杨俊 on 2017/8/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACSecondViewController : UIViewController

@property (nonatomic, strong) RACSubject *delegateSignal;

-(void)callBack;

@end
