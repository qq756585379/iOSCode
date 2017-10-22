//
//  MyOrderNilHeader.h
//  TZTV
//
//  Created by Luosa on 2016/11/23.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "OTSCollectionReusableView.h"
#import "PlaceHoldView.h"
#import "PhoneDragTips.h"

@interface MyOrderNilHeader : OTSCollectionReusableView
@property (nonatomic, strong) PlaceHoldView *placeHoldView;
@property (nonatomic, strong) PhoneDragTips *dragTipView;
@end
