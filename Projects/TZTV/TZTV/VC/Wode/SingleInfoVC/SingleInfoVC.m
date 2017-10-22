//
//  SingleInfoVC.m
//  TZTV
//
//  Created by Luosa on 2016/11/16.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "SingleInfoVC.h"
#import "YJTOOL.h"
#import "ActionSheetManager.h"
#import "SingleInfoVC+YJ.h"
#import "AccountTool.h"
#import "Account.h"
#import "UIImageView+YJ.h"
#import "FindPwdVC.h"
#import "UIImageView+YJ.h"
#import "SingleInfoChangeNameVC.h"

@interface SingleInfoVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel     *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel     *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel     *telLabel;
@end

@implementation SingleInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人信息";
    self.tableView.separatorStyle=1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
}

-(void)initData{
    Account *account=[AccountTool account];
    [_headIcon setCircleImage:account.user_image andPlaceHolderImg:@"225_243"];
    _nickNameLabel.text=account.user_nicname;
    _sexLabel.text=[account.user_sex isEqual:@1]?@"男":@"女";
    _birthdayLabel.text=account.user_birthday;
    _telLabel.text=account.telephone;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.section*10+indexPath.row) {
        case 0://上传头像
            [self updateIcon:self.headIcon];
            break;
        case 2://修改昵称
            [self.navigationController pushViewController:[sb instantiateViewControllerWithIdentifier:@"SingleInfoChangeNameVC"]
                                                 animated:YES];
            break;
        case 3:
        {//修改性别
            [ActionSheetManager actionSheetWithTitle:nil
                                             message:nil
                                             buttons:@[@"男",@"女"]
                                   cancelButtonTitle:@"取消"
                                    andCompleteBlock:^(NSString *title, NSInteger index) {
                [self updateSex:index andAexLabel:_sexLabel];//修改性别
            }];
        }
            break;
        case 4:
            [self updateBrithday:_birthdayLabel];//设置生日
            break;
        case 10:
        {
            FindPwdVC *find=[sb instantiateViewControllerWithIdentifier:@"FindPwdVC"];
            find.title=@"修改密码";
            [self.navigationController pushViewController:find animated:YES];
        }
            break;
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

#pragma mark - 上传修改头像
-(void)updateIcon:(UIImageView *)imageView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([YJTOOL checkCameraAuthorizationStatusInView:self.view]) {
            [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([YJTOOL checkPhotoLibraryAuthorizationStatusInView:self.view]) {
            [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)openImagePickerController:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    //ipc.allowsEditing=YES;
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIImage *newimage = [image yp_imageCompressForSize:CGSizeMake(200,200)];
    NSData *data = UIImageJPEGRepresentation(newimage, 0.5);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    Account *account=[AccountTool account];
    params[@"userId"] = account.user_id;
    params[@"type"] = @1;
    [MBProgressHUD showMessage:@"头像上传中..."];
    [[YJHttpRequest sharedManager] createAnUploadTask:UploadFileUrl imageData:data andParameters:params success:^(id json) {
        YJLog(@"%@",json);
        [MBProgressHUD hideHUD];
        if ([json[@"code"] isEqualToNumber:@0]) {
            [MBProgressHUD showSuccess:@"上传头像成功"];
            account.user_image=json[@"data"];
            [AccountTool saveAccount:account];
            [self modeifyIcon:account];
        }else{
            [MBProgressHUD showError:json[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"上传头像失败！"];
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 通知后台跟新头像
-(void)modeifyIcon:(Account *)account{
    NSString *url=[NSString stringWithFormat:ModifyHeadIconUrl,account.user_id,account.user_image];
    [[YJHttpRequest sharedManager] get:url params:nil success:^(id json) {
        if ([json[@"code"] isEqualToNumber:@0]) {
            [[SDImageCache sharedImageCache] removeImageForKey:account.user_image];
            [self.headIcon setCircleImage:account.user_image andPlaceHolderImg:@"60_60"];
        }else{
            [MBProgressHUD showToast:json[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end



