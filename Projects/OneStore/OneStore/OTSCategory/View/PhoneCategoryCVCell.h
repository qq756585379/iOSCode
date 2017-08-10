//
//  PhoneCategoryCVCell.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/8.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSCollectionViewCell.h"
@class PhoneCategoryCVCell,OTSHotRecommendCategoryVO,CategoryVO;

@protocol PhoneCategoryCVCellDelegate <NSObject>
- (void)phoneCategoryEntrySearch:(PhoneCategoryCVCell*)categoryCVC;
@end

@interface PhoneCategoryCVCell : OTSCollectionViewCell

-(void)updateWithCellData:(CategoryVO *)aData;

-(void)updateWithCellADSData:(OTSHotRecommendCategoryVO *)aADS;

@property(nonatomic, weak)id<PhoneCategoryCVCellDelegate> delegate;

@property (nonatomic,strong) CategoryVO *categoryVO;

@property (nonatomic,strong) OTSHotRecommendCategoryVO * aADS;

@property (nonatomic,assign) NSInteger  parentIndexPathSecion;//对应2级类目的indexPath

@property(nonatomic,  assign)BOOL hasADS;

@property(nonatomic, strong)UILabel *lable; //标题 文字

@end
