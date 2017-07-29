//
//  OTSUnionLoginWebVC.m
//  OneStorePad
//
//  Created by zhangbin on 15/5/5.
//  Copyright (c) 2015年 OneStore. All rights reserved.
//

#import "OTSUnionLoginWebVC.h"
#import "OTSEnum.h"
#import "OTSWebView.h"
#import "UIViewController+custom.h"

@interface OTSUnionLoginWebVC () <UIWebViewDelegate>
@property (nonatomic, strong) OTSWebView *webView;
@property (nonatomic, assign) LoginType loginType;
@property (nonatomic, assign) BOOL authenticated;
@end

@implementation OTSUnionLoginWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupNavigationBar];
    [self setupData];
}

- (void)setupView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = RGB(238, 238, 238);
    [self.view addSubview:self.webView];
    [self.webView autoPinEdgesToSuperviewEdges];
}

- (void)setupNavigationBar {
    [self setNaviButtonType:NaviButton_Return isLeft:YES];
    switch (self.loginType) {
        case LoginTypeAlipay:
             self.navigationItem.title =  @"支付宝登录";
            break;
        case LoginTypeSina:
             self.navigationItem.title = @"新浪微博登录";
            break;
        case LoginTypeQQ:
             self.navigationItem.title = @"QQ登陆";
            break;
        default:
            break;
    }
}

- (void)setupData {
//    NSString *urlString = self.extraData[@"url"];
//    if (urlString.length > 0) {
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [self.webView loadRequest:request];
//    }
//    [OTSWebView setupDefaultCookies];
}

#pragma mark - Action
- (void)leftBtnClicked:(id)sender {
    [super leftBtnClicked:sender];
    
//    OTSNativeFuncVOBlock callbackBlcok = self.extraData[OTSRouterCallbackKey];
//    if (callbackBlcok) {
//        NSError *error = [NSError errorWithDomain:OTSPassportInterfaceErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:@""}];
//        callbackBlcok(@{@"error": error});
//    }
}

#pragma mark rewrite
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    [self leftBtnClicked:nil];
    return YES;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //版本忽略证书，测试环境服务器给的证书没经过CA认证
//    BOOL testEnvironment = ([OTSConnectUrl sharedInstance].networkEnvironmentType == OTSNetworkEnvironmentTypeTest);
//    if (testEnvironment) {
//        NSString *scheme = [[request URL] scheme];
//        //判断是不是https
//        if ([scheme isEqualToString:@"https"]) {
//            if (!self.authenticated) {
//                NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//                [connection start];
//                [self.webView stopLoading];
//                return NO;
//            }
//        }
//    }
//    
//    NSURL *url = request.URL;
//    NSString *yhdScheme = [OTSRouter singletonInstance].appScheme;
//    NSString *yhdFuncScheme = [OTSRouter singletonInstance].appFuncScheme;
//    if ([yhdScheme isEqualToString:url.scheme]) {//界面跳转url
//        //在当前界面才处理url
//        if (self.navigationController.topViewController == self) {
//            [[OTSRouter singletonInstance] routerWithUrl:url];
//        }
//        return NO;
//    } else if ([yhdFuncScheme isEqualToString:url.scheme]) {//iOS native func url
//        //在当前界面才处理url
//        if (self.navigationController.topViewController == self) {
//            [[OTSRouter singletonInstance] routerWithUrl:url];
//        }
//        return NO;
//    }
//    
//    // 保存账号
//    if (self.loginType == LoginTypeAlipay
//        && [url.absoluteString safeRangeOfString:@"common_login_ssl.htm"].location != NSNotFound) {
//        [[OTSUnionLoginCacher sharedInstance] saveAlipayUserNameFromWebView:webView];
//    } else if (self.loginType == LoginTypeSina && [url.absoluteString safeRangeOfString:@"code="].location != NSNotFound) {
//        [[OTSUnionLoginCacher sharedInstance] saveSinaUserNameFromWebView:webView];
//    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //缩放
    NSString *meta =[NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%d, initial-scale=0.9, minimum-scale=0.9, maximum-scale=0.9, user-scalable=no\"",(int)webView.width];
    [webView stringByEvaluatingJavaScriptFromString:meta];
    
//    if (self.loginType == LoginTypeAlipay) {
//        [[OTSUnionLoginCacher sharedInstance] handleAlipayLoginWithWebView:webView];
//    } else if (self.loginType == LoginTypeSina) {
//        [[OTSUnionLoginCacher sharedInstance] handleSinaLoginWithWebView:webView];
//    }
//    
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    if (error.code == 102 && [error.domain isEqual:@"WebKitErrorDomain"]) {
        return;
    }
    
    NSError *loginError = nil;
    if ([error.domain isEqualToString:NSURLErrorDomain] && error.code==NSURLErrorCancelled) {
        loginError = error;
    } else {
//        loginError = [NSError errorWithDomain:OTSPassportInterfaceErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey: @"系统繁忙，请稍后再试"}];
    }
    // 2s后再pop是为了防止因为进入的动画还没执行完，导致pop失败
//    [self performInMainThreadBlock:^{
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        
//        [self.navigationController popViewControllerAnimated:YES];
//        
//        OTSNativeFuncVOBlock callbackBlcok = self.extraData[OTSRouterCallbackKey];
//        if (callbackBlcok) {
//            if (loginError) {
//                callbackBlcok(@{@"error": error});
//            } else {
//                callbackBlcok(@{});
//            }
//        }
//    } afterSecond:2.0];
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connect to host error: %@", error);
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"WebController Got auth challange via NSURLConnection");
    
    if ([challenge previousFailureCount] == 0) {
        self.authenticated = YES;
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"WebController received response via NSURLConnection");
    
    self.authenticated = YES;
    [self.webView loadRequest:connection.currentRequest];
    
    [connection cancel];
}

#pragma mark - Property
- (LoginType)loginType {
//    NSString *urlString = self.extraData[@"url"];
//    if ([urlString safeRangeOfString:@"qq"].location != NSNotFound) {
//        return LoginTypeQQ;
//    } else if ([urlString safeRangeOfString:@"sina"].location != NSNotFound) {
//        return LoginTypeSina;
//    }  else if ([urlString safeRangeOfString:@"alipay"].location != NSNotFound) {
//        return LoginTypeAlipay;
//    } else {
//        return LoginTypeNormal;
//    }
    return LoginTypeNormal;
}

- (OTSWebView *)webView {
    if (!_webView) {
        _webView = [OTSWebView newAutoLayoutView];
        _webView.delegate = self;
    }
    return _webView;
}

@end
