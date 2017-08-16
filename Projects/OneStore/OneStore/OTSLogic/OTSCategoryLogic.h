//
//  OTSCategoryLogic.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSLogic.h"
#import "CategoryVO.h"
@class CategoryADSDataVO;

@interface OTSCategoryLogic : OTSLogic

@property (nonatomic,strong) NSMutableArray<CategoryVO *>  *firstCategories;

@property (nonatomic,strong) NSMutableArray<CategoryVO *>  *secondCategories;

@property (nonatomic,strong) NSMutableArray * displaySecondCategories;

@property (nonatomic,strong) CategoryADSDataVO           *categoryADS;

//pad
@property (nonatomic,strong) CategoryVO                  *selectedFirstCategory;
// pad
@property (nonatomic,strong) NSIndexPath *selectedFirstCategoryIndexPath;

@property (nonatomic,strong) NSMutableArray<CategoryVO *>  *cachedFirstCategories;

@property (nonatomic,strong) NSNumber                    *provinceId;

//phone
@property (nonatomic,strong) CategoryADSContainersVO                  *containersVO;

@property (nonatomic,strong) NSMutableArray<CategoryVO *>            *categoryADSArr;

@property (nonatomic,strong) NSMutableArray<CategoryADSContainersVO *>  *categoryContainers;

+ (CGFloat)getCategorySecondCellHeightWithSecondCategories:(NSArray<CategoryVO *> *)secondCategories;

+ (NSInteger)getCategoryIndexWithCategory:(CategoryVO *)firstCategory
                        withAllCategories:(NSArray *)allCategories;

+ (void)populateCategoryFromCategoryADSContainersVO:(CategoryADSContainersVO *)containers
                               withSecondCategories:(NSMutableArray *)secondCategories;

+ (void)removeSecondCategoryIfNullThirdCategory:(NSMutableArray<CategoryVO *> *)secondCategories;

/**
 * 功能点：从cache里读取文件
 * 读取成功返回YES,失败NO
 */
-(BOOL)readCategoriesFromCache;

/**
 * 功能点：保存category到cache
 */
-(void)saveCategoriesToCache;

/**
 * 功能点：对比缓存和接口数据是否一致
 */
-(BOOL)cacheCategoryVOs:(NSArray<CategoryVO *> *)cacheCategories isEqualToCategoryVOs:(NSArray<CategoryVO *> *)categories;

/**
 * 功能点：获取1级分类数据
 */
-(void)getRootCategoryWithNavid:(NSNumber*)navid
                completionBlock:(OTSCompletionBlock)aCompletionBlock;

/**
 * 功能点：获取2/3级分类数据
 */
-(void)getSubCategoryWithRootCateId:(NSNumber*)rootCateId
                    completionBlock:(OTSCompletionBlock)aCompletionBlock;

/**
 * 功能点：广告  getCategoryAdvertisementList
 */
-(void) getCategoryAdvertisementListWithRootCateId:(NSNumber*)rootCateId
                                   completionBlock:(OTSCompletionBlock)aCompletionBlock;

/**
 * 功能点：广告  getCategoryAdvertisementList
 */
-(void) getCategoryAdvertisementListWithFirstCateId:(NSNumber*)rootCateId
                                    completionBlock:(OTSCompletionBlock)aCompletionBlock;

-(void)getDefaultHitWithCompletionBlock:(OTSCompletionBlock)aCompletionBlock;

/**
 * 功能点：通过2级前台类目获取其下的子类目
 */
- (void)getMobSubCategorysById:(NSNumber*)rootId
               completionBlock:(OTSCompletionBlock)aCompletionBlock;

/**
 *  获取热门推荐下特殊的3级类目
 */
- (void)getMobReCateListWithSecondCategoryId:(NSNumber *)categoryId completionBlock:(OTSCompletionBlock)aCompletionBlock;

@end
