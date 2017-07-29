//
//  OTSCollectionReusableView.h
//  Common
//
//  Created by Luosa on 2017/5/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTSCollectionReusableView : UICollectionReusableView
/**
 *  index
 */
@property (nonatomic, strong) NSIndexPath *indexPath;

/**
 *  功能:获取cell的唯一标识符
 */
+ (NSString *)cellReuseIdentifier;

/**
 *  功能:返回该类的Nib文件
 */
+ (UINib *)nib;

/**
 *	功能:cell根据数据显示ui
 */
- (void)updateWithCellData:(id)aData;

/**
 *	功能:获取cell的大小
 */
+ (CGSize)sizeForCellData:(id)aData;

@end




