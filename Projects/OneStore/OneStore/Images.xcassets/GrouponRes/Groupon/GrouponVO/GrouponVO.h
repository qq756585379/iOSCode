//
//  GrouponVO.h
//  GrouponProject
//
//  Created by meichun on 14-9-22.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrouponProductVO.h"
#import "GrouponSerialVO.h"
#import "GrouponSerialColorAndImageVO.h"
#import "GrouponImageVO.h"
#import "GrouponExperienceVO.h"
#import "GrouponSeriesProductVO.h"
#import "GrouponAttributeVO.h"

typedef enum {
    GrouponTypeDefault = 0,
    GrouponTypeSelling = 100,
    GrouponTypeSellingSuccess = 101,
    GrouponTypeSellingOvercrowd = 102,
    GrouponTypeEndFailure = 200,
    GrouponTypeEndSuccess = 201,
    GrouponTypeConvertToDO = 202,
    GrouponTypeUnderStock = -1,
    GrouponTypeComingSoon = 50
}GrouponType;

@protocol GrouponVO <NSObject>

@end

@interface GrouponVO : OTSValueObject

@property(nonatomic, retain) NSNumber *nid;//团购id
@property(nonatomic, retain) NSString *name;//团购名称
@property(nonatomic, retain) NSNumber *categoryId;//团购分类id 101:掌上专享
@property(nonatomic, retain) NSDate *startTime;//开始时间
@property(nonatomic, retain) NSDate *endTime;//结束时间
@property(nonatomic, retain) NSNumber *productId;//商品id
@property(nonatomic, retain) NSNumber *siteType;//0为全部站点，1为1号店，2为1号商场
@property(nonatomic, retain) NSNumber *merchantId;//商家id
@property(nonatomic, retain) NSNumber *price;//团购价格
@property(nonatomic, retain) NSNumber *discount;//折扣
@property(nonatomic, retain) NSNumber *saveCost;//节省
@property(nonatomic, retain) NSNumber *areaId;//地区id
@property(nonatomic, retain) NSNumber *remainTime;//团购剩余时间
@property(nonatomic, retain) NSNumber *productNumber;//团购商品数量
@property(nonatomic, retain) NSNumber *peopleLower;//团购下限
@property(nonatomic, retain) NSNumber *peopleUpper;//团购上限
@property(nonatomic, retain) NSNumber *limitLower;//团购商品下限
@property(nonatomic, retain) NSNumber *limitUpper;//团购商品上限
@property(nonatomic, retain) NSString *miniImageUrl;//团购首页图片
@property(nonatomic, retain) NSString *middleImageUrl;//团购详情页图片
@property(nonatomic, retain) NSString *sellingPoint;//团购卖点
@property(nonatomic, retain) NSString *prompt;//团购提示
@property(nonatomic, retain) NSNumber *status;//团购状态 0初始化 100团购中 101团购中-成功 102团购中-人数满 200结束-失败 201结束-成功 202可转DO  -1 代表库存不足 50代表即将开团
@property(nonatomic, retain) NSNumber *peopleNumber;//实际参团人数
@property (nonatomic, strong) NSNumber *reserveNumber;//收藏人数
@property(nonatomic, retain) NSString *type;//团购类型 -1历史 0当期 1将来
@property(nonatomic, retain) NSString *remarkerPrompt;//团购购买备注的提示信息
@property(nonatomic, retain) NSNumber *isGrouponSerial;//是否为系列产品 1是 0否
@property(nonatomic, retain) GrouponSerialVO *grouponSerialVO;//系列产品信息
@property(nonatomic, retain) NSArray<GrouponSerialVO> *grouponSerials;//团购系列商品列表
@property(nonatomic, retain) NSArray *colorList;//系列产品所有颜色属性集合
@property(nonatomic, retain) NSArray *sizeList;//系列产品所有尺寸属性集合
@property(nonatomic, retain) GrouponProductVO *productVO;
@property(nonatomic, retain) NSNumber *isIntoCart;//是否进购物车，0或1，团购预热中2为一键购
@property(nonatomic, retain) NSNumber *isNew;//是否是今日上新，0或1
@property(nonatomic, retain) NSNumber *grouponBrandId;//是否是品牌团，0或1；
@property(nonatomic, retain) NSNumber *channelId;// channelId == 102时表示是无线专享价；


@property (nonatomic,strong) NSString *subCnName;//商品二级标题，interface version>1.3.1  app version> 3.1.1 存在,可能为空
@property (nonatomic,strong) NSString *tag;//图片左上标记，interface version>1.3.1  app version> 3.1.1 存在,可能为空

@property (nonatomic, strong) NSString *subName;//商品简介

@property(nonatomic, strong)GrouponImageVO *brandGrouponUrl; //团购图片
@property(nonatomic, strong)GrouponExperienceVO *grouponExperienceVO; //置顶评论信息
/**
 * 系列产品所有颜色属性集合
 */
@property(nonatomic, retain) NSArray *colorAndImageList; //list <SerialColorAndImageVO>

//团闪
@property(nonatomic, retain) NSNumber *freeShipType;   // 0,不显示 包邮信息；1包邮；2满百包邮; 3全国包邮

#pragma mark - 客户端字段
@property(nonatomic, assign) BOOL remind;//是否有本地提醒
@property(strong, nonatomic) NSArray<GrouponAttributeVO> *attributeVOList;//List<AttributeVO>封装每个属性项、对应属性值列表，是否颜色属性（新增）
@property(strong, nonatomic) NSArray<GrouponSeriesProductVO> *seriesProductVOList;//List<SerialProductVO>系列商品集合（系列子品pmId、颜色、尺码）（更新属性项ID，属性值Id，pmId）
/**
 *  涨价提示字段 1：需要提示 0：不需要提示
 */
@property(nonatomic,strong)NSNumber *priceChangeRemind;
/**
 *       h5 详情url
 */
@property(nonatomic,strong)NSString *h5DetailUrl;
/**
 *  功能:获取促销类型，转换成枚举
 */
- (GrouponType)theGrouponType;

/**
 *	功能:是否是序列商品
 *
 *	@return
 */
- (BOOL)isSerialProduct;

/**
 *	功能:团购商品是否是掌上专享价格商品
 *
 *	@return
 */
- (BOOL)isWirelessExclusivePirce;

@end

