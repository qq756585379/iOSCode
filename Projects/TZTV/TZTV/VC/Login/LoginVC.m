//
//  LoginVC.m
//  TZTV
//
//  Created by Luosa on 2016/11/8.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "LoginVC.h"
#import "RegistVC0.h"
#import "FindPwdVC.h"
#import "Account.h"
#import "AccountTool.h"
#import "UIBarButtonItem+Create.h"
#import "UIViewController+YJ.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *TF1;//帐号
@property (weak, nonatomic) IBOutlet UITextField *TF2;//密码
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"登录";
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self setNaviButtonType:NaviButton_Return isLeft:YES];
    [self setNavgationBarBackGroundImage:[UIImage imageWithColor:[UIColor whiteColor]]
                          andShadowImage:[UIImage imageWithColor:kEDEDED]];
    
    [[_TF1.rac_textSignal filter:^BOOL(id value) {
        // value:源信号的内容
        // 返回值,就是过滤条件,只有满足这个条件,才能能获取到内容
        return  [value length] == 11;
    }] subscribeNext:^(id x) {
        YJLog(@"%@",x);
    }];
}

- (IBAction)login:(UIButton *)sender {
    [self cancelFirstResponse];
    
    if (![_TF1.text isPhoneNo]) {
        [MBProgressHUD showError:@"请输入正确的手机号！"];
        return;
    }
    if (_TF2.text.length<6) {
        [MBProgressHUD showError:@"密码个数至少6位！"];
        return;
    }
    [MBProgressHUD showMessage:@""];
    NSString *url = [NSString stringWithFormat:LOGINURL,_TF1.text,_TF2.text];
    [[YJHttpRequest sharedManager] get:url params:nil success:^(id json) {
        [MBProgressHUD hideHUD];
        YJLog(@"%@",json);
        if ([json[@"code"] isEqualToNumber:@0]) {//登录成功
            Account *account=[Account mj_objectWithKeyValues:json[@"data"]];
            [AccountTool saveAccount:account];
            [MBProgressHUD showSuccess:@"登录成功"];
            [self postNotification:LoginSuccess];//发通知
            [self dismissViewControllerAnimated:YES completion:nil];
//            [YJAppDelegate setUpJPush];
//            [self loadStuClassInfo:account.user_id];
        }else{
            [MBProgressHUD showToast:json[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"登录失败"];
    }];
}
- (IBAction)eyeClicked:(UIButton *)sender {
    sender.selected=!sender.selected;
    self.TF2.secureTextEntry=!sender.selected;
}

- (IBAction)findPwd:(UIButton *)sender {
    FindPwdVC *find=[sb instantiateViewControllerWithIdentifier:@"FindPwdVC"];
    find.title=@"找回密码";
    [self.navigationController pushViewController:find animated:YES];
}
- (IBAction)goToRegist0:(UIButton *)sender {
    [self.navigationController pushViewController:[sb instantiateViewControllerWithIdentifier:@"RegistVC0"] animated:YES];
}
- (void)leftBtnClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
