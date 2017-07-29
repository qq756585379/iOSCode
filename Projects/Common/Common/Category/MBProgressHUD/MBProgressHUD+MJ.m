//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

#define kWindow [[UIApplication sharedApplication] keyWindow]

@implementation MBProgressHUD (MJ)

+ (void)showSuccess:(NSString *)success{
    [self show:success icon:@"success.png" view:kWindow];
}
+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [self show:success icon:@"success.png" view:view];
}

+ (void)showError:(NSString *)error{
    [self show:error icon:@"error.png" view:kWindow];
}
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (MBProgressHUD *)showMessage:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (void)hideHUD{
    [self hideHUDForView:kWindow animated:YES];
}

+ (void)hideHUDForView:(UIView *)view{
    [self hideHUDForView:view animated:YES];
}

+ (void)showToastToCenter:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15.0];
    hud.detailsLabel.text = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5];
}

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.label.text = text;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5];
}

//+ (MBProgressHUD *)showCustomHUD{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
//    hud.color=[UIColor clearColor];
//    hud.mode=MBProgressHUDModeCustomView;
//    UIImageView *imgLoading = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
//    NSMutableArray *arr=[NSMutableArray array];
//    for (int i=0; i<12; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"l%d",i+1]];
//        [arr addObject:image];
//    }
//    imgLoading.animationImages = arr;
//    imgLoading.animationDuration = 1;
//    imgLoading.animationRepeatCount = 3000;
//    hud.customView = imgLoading;
//    [imgLoading stopAnimating];
//    [imgLoading startAnimating];
//    hud.dimBackground=NO;// YES代表需要蒙版效果
//    hud.removeFromSuperViewOnHide=YES;
//    return hud;
//}

@end




