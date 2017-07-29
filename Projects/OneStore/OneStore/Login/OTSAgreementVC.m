//
//  OTSAgreementVC.m
//  OneStore
//
//  Created by 杨俊 on 2017/6/21.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "OTSAgreementVC.h"
#import "UIViewController+custom.h"
#import "OTSWebView.h"

@interface OTSAgreementVC () <UIWebViewDelegate>
@property (nonatomic, strong) OTSWebView *webView;
@end

@implementation OTSAgreementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupNavigationBar];
    [self setupWebView];
}

- (void)setupView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = RGB(238, 238, 238);
    self.navigationItem.title =  @"服务协议";
}

- (void)setupNavigationBar {
    [self setNaviButtonType:NaviButton_Return isLeft:YES];
    if (self.showAgreementButton) {
        [self setNaviButtonType:NaviButton_None
                          frame:CGRectMake(0, 0, 44, 44)
                           text:@"同意"
                          color:[OTSColor redColor]
                           font:[UIFont systemFontOfSize:18]
                   shadowOffset:CGSizeZero
                      alignment:UIControlContentHorizontalAlignmentRight
                     edgeInsets:UIEdgeInsetsZero
                         isLeft:NO];
    }
}

- (void)setupWebView {
    [self.view addSubview:self.webView];
    [self.webView autoPinEdgesToSuperviewEdges];
    NSURL *url = [NSURL URLWithString:@"http://m.yhd.com/mw/yihaodianprivacy?osType=30"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - Actions
- (void)leftBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if (self.showAgreementButton && [self.delegate respondsToSelector:@selector(agree:)]) {
        [self.delegate agree:NO];
    }
}

- (void)rightBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(agree:)]) {
        [self.delegate agree:YES];
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //缩放
    NSString *meta =[NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%d, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"",(int)webView.width];
    [webView stringByEvaluatingJavaScriptFromString:meta];
}

#pragma mark - Property
- (OTSWebView *)webView {
    if (!_webView) {
        _webView = [OTSWebView newAutoLayoutView];
        _webView.delegate = self;
    }
    return _webView;
}

@end
