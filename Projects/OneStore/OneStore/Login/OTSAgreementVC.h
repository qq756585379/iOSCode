//
//  OTSAgreementVC.h
//  OneStore
//
//  Created by 杨俊 on 2017/6/21.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OTSAgreementDelegate <NSObject>
- (void)agree:(BOOL)agreement;
@end

@interface OTSAgreementVC : UIViewController

@property (nonatomic, assign) BOOL showAgreementButton;

@property (nonatomic,   weak) id <OTSAgreementDelegate> delegate;

@end
