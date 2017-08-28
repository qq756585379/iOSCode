//
//  OTSCoreDataManager.h
//  OneStoreFramework
//
//  Created by yuan jun on 14-7-28.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface OTSCoreDataManager : NSObject

/**
 *  指定coredata名称
 *
 *  @param path coreDataModel路径，此path为所创建的xcdatamodeld的bundle位置
 *  ex: path=@"OneStoreFrameworkRes.bundle/Model.momd" 注意model类型后缀一定是momd，建议各modules自己建bundle来存coredata
 *  @return instance of self
 */
+(nonnull id)managerWithCoreDataPath:(NSString* __nullable)path;

/**
 *  获取查询出来的结果数量
 *
 *  @param aClass entity所属类
 *  @param aPredicate  查询条件 不使用传nil
 *  @return 结果
 */
-(NSUInteger)countWithEntityName:(__nullable Class )aClass
                       Predicate:(NSPredicate * __nullable)aPredicate;


#pragma mark - Fetch
/**
 *  取数据
 *
 *  @param aClass entity所属类
 *  @param aPredicate  查询条件 不使用传nil
 *  @param size        分页 不使用传nil
 */
-(NSArray* __nullable)fetchWithEntityName:(__nullable Class)aClass
                     predicate:(NSPredicate * __nullable)aPredicate
                      pageSize:(NSNumber* __nullable)size
                sortDescriptors:(NSArray*__nullable )sortDes;

- (NSArray * __nullable)fetchWithEntityName:(__nullable Class)aClass
                       predicate:(NSPredicate * __nullable)aPredicate
                      fetchLimit:(NSUInteger)aFetchLimit
                 sortDescriptors:(NSArray * __nullable)aSortDescriptors;
/**
 *  取数据
 *
 *  @param aClass entity所属类
 *  @param aPredicate   查询条件 不使用传nil
 *  @param currentPage  当前页 不使用传nil
 *  @param size         分页 不使用传nil
 */
- (NSArray* __nullable)fetchWithEntityName:(__nullable Class )aClass
                     predicate:(NSPredicate * __nullable)aPredicate
                    fetchLimit:(NSUInteger)aFetchLimit
                        offset:(NSNumber* __nullable)offset
                   currentPage:(NSNumber* __nullable)currentPage
                    pageSize:(NSNumber* __nullable)size
               sortDescriptors:(NSArray* __nullable)sortDes;

#pragma mark - Del
- (void)deleteWithEntityName:(_Nullable Class)aClass
                   predicate:(NSPredicate * _Nullable)aPredicate
                 deleteCount:(NSUInteger )aCount
                    complite:(void (^__nullable)(BOOL contextDidSave, NSError * _Nullable error))complite;

- (void)deleteWithEntityName:(_Nullable Class)aClass
                   predicate:(NSPredicate * _Nullable)aPredicate
                 deleteCount:(NSUInteger )aCount;


/**
 *
 *
 *  @param aClass     需要清除的表
 *  @param aPredicate 条件
 *  @param complite   删除成功后的回调
 */

-(void)deleteWithEntityName:(_Nullable Class)aClass withPredicate:(NSPredicate * _Nullable)aPredicate complite:(void (^__nullable)(BOOL contextDidSave, NSError * _Nullable error))complite;

-(void)deleteWithEntityName:(_Nullable Class)aClass withPredicate:(NSPredicate * _Nullable)aPredicate;

/**
 *  删除单个数据对象
 */
- (void)deleteWithManageObject:(NSManagedObject * _Nullable)object;

#pragma mark -- 同步删除操作

/**
 *  删除数据表,删除操作保存成功后才返回
 */
- (void)deleteAndWaitWithEntityName:(_Nullable Class)aClass
                   predicate:(NSPredicate * _Nullable)aPredicate
                        deleteCount:(NSUInteger)aCount;
#pragma mark - insert & update
typedef void(^OTSCoreDataInsertBlock)(_Nullable id entity);

-(void)insertWithClass:(_Nullable Class)aClass insertBlock:(_Nullable OTSCoreDataInsertBlock)block;

-(void)insertWithClass:(_Nullable Class)aClass insertBlock:(_Nullable OTSCoreDataInsertBlock)aInMainBlock complite:(void (^__nullable)(BOOL contextDidSave, NSError * _Nullable error))complite;

-(void)updateWithEntityName:(_Nullable Class)aEntityName withPredicate:( NSPredicate * _Nullable )aPredicate withDataBlock:(_Nullable OTSCoreDataInsertBlock)block;

#pragma mark -- 同步插入操作
-(void)insertAndWaitWithClass:(_Nullable Class)aClass insertBlock:(_Nullable OTSCoreDataInsertBlock)block;
@end
