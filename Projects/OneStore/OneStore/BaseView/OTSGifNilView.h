//
//  OTSGifNilView.h
//  OTSCommon
//
//  Created by HUI on 16/6/29.
//  Copyright © 2016年 OTSCommon. All rights reserved.
//

#import "FLAnimatedImageView.h"

@interface OTSGifNilView : UIView
@property (nonatomic, strong) FLAnimatedImageView *nilGifImgView;
@property (nonatomic, strong) UIButton *nilHomeBtn;
- (void)setNilInfo:(NSString *)nilInfo gifImgName:(NSString *)gifImgName;
@end
