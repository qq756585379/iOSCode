//
//  OTSCollectionReusableView.m
//  Common
//
//  Created by Luosa on 2017/5/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "OTSCollectionReusableView.h"

@implementation OTSCollectionReusableView

+ (NSString *)cellReuseIdentifier{
    return NSStringFromClass([self class]);
}

+ (UINib *)nib{
    NSString *className = NSStringFromClass([self class]);
    return [UINib nibWithNibName:className bundle:nil];
}

- (void)updateWithCellData:(id)aData{
    
}

+ (CGSize)sizeForCellData:(id)aData{
    return CGSizeZero;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
