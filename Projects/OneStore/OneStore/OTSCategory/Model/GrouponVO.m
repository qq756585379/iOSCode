//
//  GrouponVO.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "GrouponVO.h"

@implementation GrouponVO

- (BOOL)isShowSamsEntry{
    //山姆商详在 用户未登录 和 已登录但不是山姆会员 情况下显示
    
    if (self.memberType.boolValue) {//是sam团购商品
        
        if([OTSGlobalValue sharedInstance].token == nil) { //未登录状态显示山姆入口
            return YES;
        } else {
            return !(self.currentPriceType.integerValue == 3);//等于3表示是sam会员
        }
        
    }else{//不是sam团购商品
        return NO;
    }
    
}

- (BOOL)isSellout
{
    if (self.status.integerValue == 102 ||
        (self.stockAvailable && self.stockAvailable.integerValue == 0)) {
        return YES;
    }
    
    return NO;
}

- (GrouponType)theGrouponType
{
    int grouponType = self.status.intValue;
    return (GrouponType)grouponType;
}


- (BOOL)isSerialProduct
{
    if (self.isGrouponSerial.boolValue
        || self.grouponSerials.count > 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isWirelessExclusivePirce
{
    if (self.channelId.integerValue == 102) {
        return YES;
    }
    return NO;
}

- (GrouponSeriesProductVO *)currentSeriesProductVO
{
    for (GrouponSeriesProductVO *seriesProductVO in self.seriesProductOutList) {
        if ([seriesProductVO isKindOfClass:[GrouponSeriesProductVO class] ]) {
            if ([seriesProductVO.pmId isEqual:self.pmInfoId]) {
                _currentSeriesProductVO = seriesProductVO;
            }
        }
    }
    return _currentSeriesProductVO;
}

-(BOOL)isGrouponBrand{
    if (self.grouponBrandId.intValue) {
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)isIntoCartOrOneKeyBuy{
    BOOL res = self.isIntoCart.intValue==1 || self.isIntoCart.intValue==2;
    return res;
}

- (NSString *)findCurrentAttributePicUrl{
    GrouponSeriesProductVO *serproductvo = self.currentSeriesProductVO;
    for (SeriesAttributeVO *serAttr in serproductvo.seriesAttributeOutList) {
        for (GrouponAttributeVO *attrVO in self.attributeOutList) {
            if (serAttr.attributeId.longLongValue == attrVO.attributeId.longLongValue) {
                for (GrouponAttributeValueVO *attrValueVO in attrVO.attributeValueOutList) {
                    if (attrValueVO.attributeValueId.longLongValue == serAttr.attributeValueId.longLongValue) {
                        //商品详情系列
                        if (attrValueVO.picUrl!=nil && attrValueVO.picUrl.length>0) {
                            return attrValueVO.picUrl;
                        }
                        //团购图片
                        if (attrValueVO.smallPicUrl!=nil && attrValueVO.smallPicUrl.length>0) {
                            return attrValueVO.smallPicUrl;
                        }
                        //闪购图片
                        if (attrValueVO.picUrl!=nil && attrValueVO.picUrl.length>0) {
                            return attrValueVO.picUrl;
                        }
                    }
                }
            }
        }
    }
    return nil;
}

- (BOOL)isHaveTags
{
    // 支持X天无理由退换
    if (self.returnDaysReasonless.integerValue > 0) {
        return YES;
    }
    
    // 海购商品是否有标签
    if (self.abroadBuyOut.abroadBuyCountryName.length || self.abroadBuyOut.departurePlace.length || ([self.abroadBuyOut.deliveryType integerValue] == 2 && [self.abroadBuyOut.abroadChinaZone integerValue] == 2)) {
        return YES;
    }
    
    return NO;
}

- (NSMutableDictionary *)seriesGrouponVODict
{
    if (_seriesGrouponVODict == nil) {
        _seriesGrouponVODict = [NSMutableDictionary dictionary];
        for (GrouponSeriesProductVO *seriesProductVo in self.seriesProductOutList) {
            NSString *keyValueString = seriesProductVo.attributeKeyString;
            [_seriesGrouponVODict safeSetObject:seriesProductVo forKey:keyValueString];
        }
    }
    return _seriesGrouponVODict;
}

@end
