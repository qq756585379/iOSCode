//
//  ZoomViewController.m
//  Demos
//
//  Created by 杨俊 on 2017/10/12.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "ZoomViewController.h"
#import "CommonDefine.h"
#import "UIView+frame.h"
#import "LogDefine.h"

@interface ZoomViewController ()<UIScrollViewDelegate>
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.minimumZoomScale = self.scrollView.frame.size.width / self.imageView.frame.size.width;
    self.scrollView.maximumZoomScale = 1.0;
    [self.scrollView setZoomScale:self.scrollView.minimumZoomScale];
    [self adjustCenteredFrameInScrollView];
}

- (void)doubleClickImage:(UITapGestureRecognizer *)tapGestureRecognizer{
    CGPoint location = [tapGestureRecognizer locationInView:self.imageView];
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale) {
        CGFloat width = self.scrollView.width / self.scrollView.maximumZoomScale;
        CGFloat height = self.scrollView.height / self.scrollView.maximumZoomScale;
        CGFloat x = location.x - (width / 2.0f);
        CGFloat y = location.y - (height / 2.0f);
        CGRect rectToZoomTo = CGRectMake(x, y, width, height);
        [self.scrollView zoomToRect:rectToZoomTo animated:YES];
    }else if ((self.scrollView.zoomScale > self.scrollView.minimumZoomScale) && (self.scrollView.zoomScale <= self.scrollView.maximumZoomScale)){
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    }
}

-(void)adjustCenteredFrameInScrollView{
    // center horizontally
    if (self.imageView.width < self.scrollView.width) {
        self.imageView.x = (self.scrollView.width - self.imageView.width) / 2;
    }else {
        self.imageView.x = 0;
    }

    // center vertically
    if (self.imageView.height < self.scrollView.height) {
        self.imageView.y = (self.scrollView.height - self.imageView.height) / 2;
    }else {
        self.imageView.y = 0;
    }
    
    PrintRect(self.imageView.frame);
}

- (void)scrollViewDidZoom:(UIScrollView *)ascrollView {
    [self adjustCenteredFrameInScrollView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator =NO;
        _scrollView.showsHorizontalScrollIndicator =NO;
    }
    return _scrollView;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image"]];
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *doubleClickGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClickImage:)];
        doubleClickGestureRecognizer.numberOfTapsRequired = 2;
        [_imageView addGestureRecognizer:doubleClickGestureRecognizer];
    }
    return _imageView;
}

@end
