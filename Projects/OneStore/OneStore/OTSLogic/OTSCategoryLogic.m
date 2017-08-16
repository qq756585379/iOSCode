//
//  OTSCategoryLogic.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSCategoryLogic.h"
#import "OTSOperationParam.h"

@implementation OTSCategoryLogic

+ (CGFloat)getCategorySecondCellHeightWithSecondCategories:(NSArray<CategoryVO *> *)secondCategories{
    int rowNum = 4;
    CGSize size = [[UIScreen mainScreen] applicationFrame].size;
    if(size.height < size.width){
        rowNum = 5; // 横屏控制
    }
    CGFloat height = 0;
    for(CategoryVO *secondCategory in secondCategories){
        NSInteger thirdCategoryCount = [secondCategory.childrens count];
        NSInteger itemRow = thirdCategoryCount / rowNum; // 行数
        NSInteger itemRemainder = thirdCategoryCount % rowNum; // 个数
        CGFloat thirdCategoryCellHeight;
        if ([OTSGlobalValue sharedInstance].showCategoryPic) {
            thirdCategoryCellHeight = 180;
        }else {
            thirdCategoryCellHeight = 44;
        }
        
        if (itemRow==0&&itemRemainder==0) {// 无内容
            
        }else{// 有内容
            height += 43.5 + 60;// 标题加上间距
            height += (thirdCategoryCellHeight + 20)*itemRow;// 行数
            if (itemRemainder>0) {// 有余数加一行
                height += thirdCategoryCellHeight + 20;
            }
        }
    }
    return height;
}

+ (NSInteger)getCategoryIndexWithCategory:(CategoryVO *)firstCategory withAllCategories:(NSArray *)allCategories{
    NSInteger index = 0;
    for(CategoryVO *category in allCategories){
        index++;
        if([category.categoryId safeIsEqualToNumber:firstCategory.categoryId]){
            break;
        }
    }
    return index;
}

+ (void)populateCategoryFromCategoryADSContainersVO:(CategoryADSContainersVO *)containers
                               withSecondCategories:(NSMutableArray *)secondCategories{
    NSArray * cdsKeys = [containers.cds allKeys];
    for (NSString *keyId in cdsKeys) {
        NSArray *cdsArray = [containers.cds objectForKey:keyId];
        for (CategoryVO *categoryVO in secondCategories) {
            if ([keyId isEqualToString:categoryVO.nid.stringValue]) {//找到对应有3级广告的2级类目
                NSMutableArray *newCategoryArray = [NSMutableArray array];
                for (NSDictionary *promoteCategory in cdsArray) {
                    CategoryVO *newCategory = [CategoryVO new];
                    [newCategory setName:[promoteCategory objectForKey:@"title"]];
                    [newCategory setKeywords:[promoteCategory objectForKey:@"keyword"]];
                    [newCategory setAppLinkUrl:[promoteCategory objectForKey:@"appLinkUrl"]];
                    NSMutableString * string_test = [promoteCategory objectForKey:@"hot"];
                    NSString * string = [string_test stringByReplacingOccurrencesOfString:@"_" withString:@""];
                    
                    [newCategory setIsHighLight:[NSNumber numberWithInt:[[string substringWithRange:NSMakeRange (0,1)] intValue]]];
                    [newCategory setIsHot:[NSNumber numberWithInt:[[string substringWithRange:NSMakeRange (1,1)] intValue]]];
                    [newCategory setIsNew:[NSNumber numberWithInt:[[string substringWithRange:NSMakeRange (2,1)] intValue]]];
                    
                    BOOL isExist = NO;
                    for(CategoryVO *originCategory in categoryVO.childrens){
                        if([[originCategory keywords] isEqualToString:[newCategory keywords]]){
                            isExist = YES;
                            break;
                        }
                    }
                    
                    if(!isExist){
                        if (categoryVO.childrens == nil) {
                            categoryVO.childrens = (NSMutableArray <CategoryVO *> *)[NSMutableArray new];
                        }
                        [newCategoryArray safeInsertObject:newCategory atIndex:0];
                    }
                }
                for(CategoryVO *vo in newCategoryArray) {
                    [categoryVO.childrens safeInsertObject:vo atIndex:0];
                }
            }
        }
    }
}

+ (void)removeSecondCategoryIfNullThirdCategory:(NSMutableArray<CategoryVO *> *)secondCategories
{
    NSMutableArray *remove = @[].mutableCopy;
    for(CategoryVO *category in secondCategories){
        if(category.childrens == nil || [category.childrens count] == 0){
            [remove addObject:category];
        }
    }
    
    for(CategoryVO *category in remove){
        [secondCategories removeObject:category];
    }
}

-(BOOL)readCategoriesFromCache
{
    _cachedFirstCategories = (id)[OTSArchiveData unarchiveDataInCacheWithFileName:@"CategoryVO.plist"];
    
    if(_cachedFirstCategories && [_cachedFirstCategories count] > 0){//读取成功
        //加载缓存数据
        _firstCategories = _cachedFirstCategories;
        _selectedFirstCategory = _firstCategories[0];
        _secondCategories = _selectedFirstCategory.childrens;
        _categoryADS = _selectedFirstCategory.adsVO;
        return YES;
    }else{//读取失败
        return NO;
    }
}

- (void)saveCategoriesToCache
{
    WEAK_SELF;
    [self performInThreadBlock:^{
        STRONG_SELF;
        [OTSArchiveData archiveDataInCache:self.firstCategories withFileName:@"CategoryVO.plist"];
    }];
}

-(BOOL)cacheCategoryVOs:(NSArray<CategoryVO *> *)cacheCategories isEqualToCategoryVOs:(NSArray<CategoryVO *> *)categories
{
    if(cacheCategories == nil || [cacheCategories count] == 0){
        return NO;
    }
    
    if([cacheCategories count] != [categories count]){//数量是否改变
        return NO;
    }
    NSInteger matchCategoryCount = 0;
    for (CategoryVO *cache in cacheCategories) {
        for (CategoryVO *category in categories){
            
            if([[cache nid] safeIsEqualToNumber: [category nid]]){//字段是否改变
                matchCategoryCount ++;
                if([category name] != nil && ![[cache name] isEqualToString: [category name]]){
                    return NO;
                }
                if(![[cache categoryId] safeIsEqualToNumber: [category categoryId]]){
                    return NO;
                }
                if(![[cache parentId] safeIsEqualToNumber: [category parentId]]){
                    return NO;
                }
                if(![[cache vistualCategoryType] safeIsEqualToNumber: [category vistualCategoryType]]){
                    return NO;
                }
                if(![[cache isGoodness] safeIsEqualToNumber: [category isGoodness]]){
                    return NO;
                }
                if([category goodnessDesc] != nil && ![[cache goodnessDesc] isEqualToString: [category goodnessDesc]]){
                    return NO;
                }
                if(![[cache isHighLight] safeIsEqualToNumber: [category isHighLight]]){
                    return NO;
                }
                if(![[cache isNew] safeIsEqualToNumber: [category isNew]]){
                    return NO;
                }
                if(![[cache isHot] safeIsEqualToNumber: [category isHot]]){
                    return NO;
                }
                if([category url] != nil && ![[cache url] isEqualToString: [category url]]){
                    return NO;
                }
                if([category iconPicUrl] != nil && ![[cache iconPicUrl] isEqualToString: [category iconPicUrl]]){
                    return NO;
                }
            }
        }
    }
    
    if(matchCategoryCount != [cacheCategories count]){//是否存在分类数量相同，但具体内容不相同
        return NO;
    }
    
    return YES;
}

/**
 * 功能点：获取1级分类数据
 */
-(void)getRootCategoryWithNavid:(NSNumber*)navid completionBlock:(OTSCompletionBlock)aCompletionBlock{
    OTSOperationParam *operationParam =  [OTSNICategory getRootCategoryWithNavid:navid completionBlock:^(id aResponseObject, NSError *anError) {
        if (anError == nil && aResponseObject != nil && [aResponseObject isKindOfClass:[NSArray class]]) {
            NSError * errorInfo = nil;
            self.firstCategories = (NSMutableArray<CategoryVO> *)[CategoryVO arrayOfModelsFromDictionaries:aResponseObject error:&errorInfo];
            if([self.firstCategories count] > 0){
                self.selectedFirstCategory = self.firstCategories[0];
            }
            if (errorInfo) {
                anError = errorInfo;
            }else {
                
            }
        }
        if(aCompletionBlock){
            aCompletionBlock(aResponseObject, anError);
        }
    }];
    
    [self.operationManger requestWithParam:operationParam];
}

/**
 * 功能点：获取2/3级分类数据
 */
-(void)getSubCategoryWithRootCateId:(NSNumber*)rootCateId
                    completionBlock:(OTSCompletionBlock)aCompletionBlock {
    OTSOperationParam *operationParam =  [OTSNICategory getSubCategoryWithRootCateId:rootCateId completionBlock:^(id aResponseObject, NSError *anError) {
        if (anError == nil && aResponseObject != nil && [aResponseObject isKindOfClass:[NSArray class]]) {
            NSError *errorInfo = nil;
            self.secondCategories = (NSMutableArray<CategoryVO> *)[CategoryVO arrayOfModelsFromDictionaries:aResponseObject error:&errorInfo];
            
            for(CategoryVO *category in self.firstCategories){
                if([category.nid isEqualToNumber:rootCateId]){
                    [category setChildrens:self.secondCategories];
                    break;
                }
            }
            
            if (errorInfo) {
                anError = errorInfo;
            }else {
                aResponseObject = self.secondCategories;
            }
        }
        if (aCompletionBlock) {
            aCompletionBlock(aResponseObject, anError);
        }
    }];
    [self.operationManger requestWithParam:operationParam];
}

/**
 * 功能点：广告  getCategoryAdvertisementList
 */
-(void)getCategoryAdvertisementListWithRootCateId:(NSNumber*)rootCateId
                                  completionBlock:(OTSCompletionBlock)aCompletionBlock {
    OTSOperationParam *operationParam =  [OTSNICategory getCategoryAdvertisementListWithRootCategoryId:rootCateId  completionBlock:^(id aResponseObject, NSError *anError) {
        if (anError == nil && aResponseObject != nil && [aResponseObject isKindOfClass:[NSDictionary class]]) {
            NSError * errorInfo = nil;
            self.categoryADS = [[CategoryADSDataVO alloc] initWithDictionary:aResponseObject error:&errorInfo];
            
            for(CategoryADSContainersVO *containerVO in self.categoryADS.containers){
                [OTSCategoryLogic populateCategoryFromCategoryADSContainersVO:containerVO withSecondCategories:self.secondCategories];
            }
            // 放入缓存
            [self.selectedFirstCategory setChildrens:self.secondCategories];
            for(CategoryVO *category in self.firstCategories){
                if ([category.categoryId safeIsEqualToNumber:self.selectedFirstCategory.categoryId]) {
                    [category setChildrens:self.secondCategories];
                }
            }
            
            for(CategoryVO *category in self.firstCategories){//保存category ads
                if([[category nid] safeIsEqualToNumber:rootCateId]){
                    [category setAdsVO:self.categoryADS];
                    break;
                }
            }
            
            if (errorInfo) {
                anError = errorInfo;
            }else {
                aResponseObject = self.categoryADS.containers;
            }
        }
        aCompletionBlock(aResponseObject, anError);
    }];
    
    [self.operationManger requestWithParam:operationParam];
}

/**
 * 功能点：广告  getCategoryAdvertisementList
 */
-(void) getCategoryAdvertisementListWithFirstCateId:(NSNumber *)rootCateId
                                    completionBlock:(OTSCompletionBlock)aCompletionBlock {
    OTSOperationParam *operationParam =  [OTSNICategory getCategoryAdvertisementListWithRootCategoryId:rootCateId  completionBlock:^(id aResponseObject, NSError *anError) {
        if (anError == nil) {
            NSError * errorInfo = nil;
            self.categoryADS = [[CategoryADSDataVO alloc] initWithDictionary:aResponseObject error:&errorInfo];
            if (errorInfo) {
                anError = errorInfo;
            }else {
                aResponseObject = self.categoryADS.containers;
            }
        }
        aCompletionBlock(aResponseObject, anError);
    }];
    
    [self.operationManger requestWithParam:operationParam];
}

- (void)getDefaultHitWithCompletionBlock:(OTSCompletionBlock)aCompletionBlock
{
    OTSOperationParam *param = [OTSNIHomepage getDefaultHitCompletionBlock:^(id aResponseObject, NSError *anError) {
        if (aCompletionBlock) {
            aCompletionBlock(aResponseObject, anError);
        }
    }];
    
    [self.operationManger requestWithParam:param];
}

/**
 * 功能点：通过2级前台类目获取其下的子类目
 */
- (void)getMobSubCategorysById:(NSNumber*)rootId completionBlock:(OTSCompletionBlock)aCompletionBlock {
    OTSOperationParam *param = [OTSNICategory getMobSubCategorysById:(NSNumber*)rootId
                                                     completionBlock:^(id aResponseObject, NSError *anError) {
                                                         if (aCompletionBlock) {
                                                             aCompletionBlock(aResponseObject, anError);
                                                         }
                                                     }];
    
    [self.operationManger requestWithParam:param];
}

/**
 *  获取热门推荐下特殊的3级类目
 */
- (void)getMobReCateListWithSecondCategoryId:(NSNumber *)categoryId completionBlock:(OTSCompletionBlock)aCompletionBlock{
    OTSOperationParam *param  = [OTSNICategory getMobReCateList:categoryId completionBlock:^(id aResponseObject, NSError *anError) {
        if (!anError) {
            NSError *errorInfo = nil;
            NSMutableArray<CategoryVO> *array = (NSMutableArray<CategoryVO> *)[CategoryVO arrayOfModelsFromDictionaries:aResponseObject error:&errorInfo];
            if (!errorInfo) {
                aResponseObject = array;
            }
            aCompletionBlock(aResponseObject, anError);
        } else {
            aCompletionBlock(nil, anError);
        }
    }];
    [self.operationManger requestWithParam:param];
}

@end
