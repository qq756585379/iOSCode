//
//  JavaScriptCoreVC.m
//  Demos
//
//  Created by 杨俊 on 2017/10/30.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "JavaScriptCoreVC.h"
#import "SaveImage_Util.h"
#import "ActionSheetManager.h"
#import <JavaScriptCore/JavaScriptCore.h>

/**
 *  实现js代理，js调用ios的入口就在这里
 */
@protocol JSDelegate <JSExport>
- (void)getImage:(id)parameter;// 这个方法就是window.document.iosDelegate.getImage(JSON.stringify(parameter)); 中的 getImage()方法
@end

@interface JavaScriptCoreVC ()<JSDelegate,UIWebViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) JSContext *jsContext;
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic, strong) UIImage *getImage;//获取的图片
@property (nonatomic, assign) int indextNumb;// 交替图片名字
@end

@implementation JavaScriptCoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIWebView-JavaScriptCore";
    self.view.backgroundColor = [UIColor whiteColor];
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:path]];
}

#pragma mark UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"iosDelegate"] = self;//挂上代理  iosDelegate是window.document.iosDelegate.getImage(JSON.stringify(parameter)); 中的 iosDelegate
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception){
        context.exception = exception;
        NSLog(@"获取 self.jsContext 异常信息：%@",exception);
    };
}

- (void)getImage:(id)parameter{
    // 把 parameter json字符串解析成字典
    NSString *jsonStr = [NSString stringWithFormat:@"%@", parameter];
    NSDictionary *jsParameDic = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"js传来的json字典: %@", jsParameDic);
    for (NSString *key in jsParameDic.allKeys){
        NSLog(@"jsParameDic[%@]:%@", key, jsParameDic[key]);
    }
    
    [ActionSheetManager actionSheetWithTitle:nil message:nil buttons:@[@"从相册选择",@"拍照"] selectIndex:99 cancelButtonTitle:@"取消" andCompleteBlock:^(NSString *title, NSInteger index) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (index == 0) {
                [self localPhoto];
            }else{
                [self takePhoto];
            }
        });
    }];
}

#pragma mark  打开本地照片
- (void) localPhoto{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark  打开相机拍照
- (void) takePhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中不能打开相机");
        [self localPhoto];
    }
}

//  选择一张照片后进入这里
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"type=====%@",type);
    
    //  当前选择的类型是照片
    if ([type isEqualToString:@"public.image"]){
        // 获取照片
        self.getImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        self.getImage = [self fixOrientation:self.getImage];
        NSLog(@"===Decoded image size: %@", NSStringFromCGSize(self.getImage.size));
        // obtainImage 压缩图片 返回原尺寸
        self.indextNumb = self.indextNumb == 1?2:1;
        NSString *nameStr = [NSString stringWithFormat:@"Varify%d.jpg",self.indextNumb];
        
        [SaveImage_Util saveImage:self.getImage ImageName:nameStr back:^(NSString *imagePath) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"图片路径：%@",imagePath);
                /**
                 *  这里是IOS 调 js 其中 setImageWithPath 就是js中的方法 setImageWithPath(),参数是字典
                 */
                JSValue *jsValue = self.jsContext[@"setImageWithPath"];
                [jsValue callWithArguments:@[@{@"imagePath":imagePath,@"iosContent":@"获取图片成功，把系统获取的图片路径传给js 让html显示"}]];
            });
        }];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark 取消选择照片代理方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.frame = [UIScreen mainScreen].bounds;
        // UIWebView 滚动的比较慢，这里设置为正常速度
        _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

- (UIImage *)fixOrientation:(UIImage *)srcImg {
    if (srcImg.imageOrientation == UIImageOrientationUp)
        return srcImg;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (srcImg.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (srcImg.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, srcImg.size.width, srcImg.size.height,
                                             CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                             CGImageGetColorSpace(srcImg.CGImage),
                                             CGImageGetBitmapInfo(srcImg.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (srcImg.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.height,srcImg.size.width), srcImg.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.width,srcImg.size.height), srcImg.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
