//
//  UIVIew+create.m
//  OneStoreFramework
//
//  Created by Aimy on 14-7-14.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "UIView+create.h"

#import "UINib+create.h"
#import "OTSFont.h"
#import "OTSSize.h"
#import "OTSFuncDefine.h"

@implementation UIView (create)

+ (instancetype)viewWithFrame:(CGRect)frame
{
    UIView *view = [[self alloc] initWithFrame:frame];
    return view;
}

+ (instancetype)createWithNib
{
    return [self createWithNibName:NSStringFromClass(self)];
}

+ (instancetype)createWithNibName:(NSString *)aNibName
{
    return [self createWithNibName:NSStringFromClass(self) bundleName:nil];
}

+ (instancetype)createFromNibWithBundleName:(NSString *)aBundleName
{
    return [self createWithNibName:NSStringFromClass(self) bundleName:aBundleName];
}

+ (instancetype)createWithNibName:(NSString *)aXibName bundleName:(NSString *)aBundleName
{
    UINib *nib = [UINib createWithNibName:aXibName bundleName:aBundleName];
    NSArray *views = [nib instantiateWithOwner:nil options:nil];
    __block UIView *returnView = nil;
    [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id view = obj;
        if ([view isKindOfClass:self]) {
            *stop = YES;
            returnView = view;
            return ;
        }
    }];
    
    return returnView;
}

+ (instancetype)autolayoutView
{
    UIView *view = [[self alloc] initWithFrame:CGRectZero];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor clearColor];
    return view;
}

+ (UIView *)duplicate:(UIView *)view
{
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

+ (UIView *)createViewWithAttriutes:(NSArray *)attributs {
    UIView *view = [UIView autolayoutView];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]init];
    [attributs enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        NSMutableAttributedString *str = nil;
        if(obj[@"isTitle"]&&[obj[@"isTitle"]boolValue]==1){
            if(obj[@"textColor"]){
                str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n",obj[@"text"]] attributes:@{NSForegroundColorAttributeName:obj[@"textColor"],NSFontAttributeName:[OTSFont large]}];
                
            }else{
                str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n",obj[@"text"]]attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[OTSFont large]}];
            }
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            [paragraphStyle setAlignment:NSTextAlignmentCenter];
            [paragraphStyle setLineSpacing:2.0];
            [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
        }else{
            if(idx == attributs.count){//为了去掉省略号
                if(obj[@"textColor"]){
                    str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",obj[@"text"]] attributes:@{NSForegroundColorAttributeName:obj[@"textColor"],NSFontAttributeName:[OTSFont medium]}];
                }else{
                    str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",obj[@"text"]]attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[OTSFont medium]}];
                }
            }else{
                if(obj[@"textColor"]){
                    str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n",obj[@"text"]] attributes:@{NSForegroundColorAttributeName:obj[@"textColor"],NSFontAttributeName:[OTSFont medium]}];
                }else{
                    str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n\n",obj[@"text"]]attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[OTSFont medium]}];
                }
            }
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            [paragraphStyle setAlignment:NSTextAlignmentLeft];
            [paragraphStyle setLineSpacing:2.5];
            [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
        }
        [attributedString appendAttributedString:str];
        
    }];
    UILabel *label = [UILabel autolayoutView];
    label.numberOfLines = 0;
    label.attributedText = attributedString;
    [view addSubview:label];
    [label autoPinEdgesToSuperviewEdges];
    return view;
}
@end
