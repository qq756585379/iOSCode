//
//  OTSCoreDataManager.m
//  OneStoreFramework
//
//  Created by yuan jun on 14-7-28.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSCoreDataManager.h"
#import "NSObject+JsonToVO.h"
#import "OTSLog.h"
#import "MagicalRecord.h"

@interface OTSCoreDataManager()
/**
 *  托管对象上下文
 */
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

/**
 *  托管对象
 */
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

/**
 *  持久化存储协调器
 */
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSString *coreDataPath;
@end

@implementation OTSCoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+(id)managerWithCoreDataPath:(NSString*)path{
    OTSCoreDataManager *ma=[[OTSCoreDataManager alloc] init];
    NSManagedObjectModel * model = [NSManagedObjectModel MR_defaultManagedObjectModel];
    NSPersistentStoreCoordinator *defaultPSC = [NSPersistentStoreCoordinator MR_defaultStoreCoordinator];
    if (!defaultPSC) {
        defaultPSC = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    }
    
    [defaultPSC MR_addSqliteStoreNamed:path withOptions:nil];
    
    [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:defaultPSC];
    
    [NSManagedObjectContext MR_initializeDefaultContextWithCoordinator:defaultPSC];
    
    return ma;
}

-(NSUInteger)countWithEntityName:(Class )aClass
                       Predicate:(NSPredicate *)aPredicate{
    NSAssert(NSStringFromClass(aClass).length > 0 && [aClass isSubclassOfClass:[NSManagedObject class]], @"invalid Class name, __fetchWithEntityName");
    
   return  [aClass MR_countOfEntitiesWithPredicate:aPredicate];
}

-(void)insertWithClass:(Class)aClass insertBlock:(OTSCoreDataInsertBlock)block{
    [self insertWithClass:aClass insertBlock:block complite:nil];
}

-(void)insertWithClass:(Class)aClass insertBlock:(OTSCoreDataInsertBlock)block complite:(void (^__nullable)(BOOL contextDidSave, NSError * _Nullable error))complite;{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        NSManagedObject *obj = [aClass MR_createInContext:localContext];
        if (block!=nil && obj!=nil) {
            block(obj);
        }
    } completion:^(BOOL contextDidSave, NSError * _Nullable error) {
        if (complite) {
            complite(contextDidSave, error);
        }
    }];
    return;
}

-(void)insertAndWaitWithClass:(_Nullable Class)aClass insertBlock:(_Nullable OTSCoreDataInsertBlock)block{
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        NSManagedObject *obj = [aClass MR_createInContext:localContext];
        if (block!=nil && obj!=nil) {
            block(obj);
        }
    }];
}

- (void)deleteAndWaitWithEntityName:(_Nullable Class)aClass
                          predicate:(NSPredicate * _Nullable)aPredicate
                        deleteCount:(NSUInteger)aCount{
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        NSFetchRequest *request = [aClass MR_requestAllWithPredicate:aPredicate inContext:localContext];
        
        [request setReturnsObjectsAsFaults:YES];
        [request setIncludesPropertyValues:NO];
        if (aCount > 0) {
            request.fetchLimit = aCount;
        }
        NSArray *objectsToTruncate = [aClass MR_executeFetchRequest:request inContext:localContext];
        
        for (id objectToTruncate in objectsToTruncate)
        {
            [objectToTruncate MR_deleteEntityInContext:localContext];
        }
    }];
}

- (void)deleteWithEntityName:(Class)aClass
                   predicate:(NSPredicate *)aPredicate
                 deleteCount:(NSUInteger)aCount
                    complite:(void (^__nullable)(BOOL contextDidSave, NSError * _Nullable error))complite;{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        NSFetchRequest *request = [aClass MR_requestAllWithPredicate:aPredicate inContext:localContext];
        
        [request setReturnsObjectsAsFaults:YES];
        [request setIncludesPropertyValues:NO];
        if (aCount > 0) {
            request.fetchLimit = aCount;
        }
        NSArray *objectsToTruncate = [aClass MR_executeFetchRequest:request inContext:localContext];
        
        for (id objectToTruncate in objectsToTruncate)
        {
            [objectToTruncate MR_deleteEntityInContext:localContext];
        }
    } completion:^(BOOL contextDidSave, NSError * _Nullable error) {
        if (complite) {
            complite(contextDidSave, error);
        }
    }];
}

- (void)deleteWithEntityName:(_Nullable Class)aClass
                   predicate:(NSPredicate * _Nullable)aPredicate
                 deleteCount:(NSUInteger )aCount{
    [self deleteWithEntityName:aClass predicate:aPredicate deleteCount:aCount complite:nil];
}

-(void)deleteWithEntityName:(Class)aClass withPredicate:(NSPredicate *)aPredicate complite:(void (^__nullable)(BOOL contextDidSave, NSError * _Nullable error))complite{
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        [aClass MR_deleteAllMatchingPredicate:aPredicate inContext:localContext];
    }completion:^(BOOL contextDidSave, NSError * _Nullable error) {
        if (complite) {
            complite(contextDidSave, error);
        }
    }];
}

-(void)deleteWithEntityName:(Class)aClass withPredicate:(NSPredicate *)aPredicate{
    [self deleteWithEntityName:aClass withPredicate:aPredicate complite:nil];
}

- (void)deleteWithManageObject:(NSManagedObject *)object{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        [object MR_deleteEntityInContext:localContext];
    } completion:^(BOOL contextDidSave, NSError * _Nullable error) {
        
    }];
}

-(void)updateWithEntityName:(Class)aEntityName withPredicate:(NSPredicate *)aPredicate withDataBlock:(OTSCoreDataInsertBlock)block{
     NSArray *fetchedObjects = [self fetchWithEntityName:aEntityName predicate:aPredicate];
    if (fetchedObjects.count <= 0) {
        [self insertWithClass:aEntityName insertBlock:block complite:nil];
    }else{
        NSManagedObject *obj = fetchedObjects.lastObject;
        if ([obj isKindOfClass:[aEntityName class]]){
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
                block(obj);
            } completion:^(BOOL contextDidSave, NSError * _Nullable error) {
                
            }];
        }
    }
}

-(NSArray*)fetchWithEntityName:(Class)aClass
                     predicate:(NSPredicate *)aPredicate{
    return [self fetchWithEntityName:aClass predicate:aPredicate pageSize:nil sortDescriptors:nil];
}

-(NSArray*)fetchWithEntityName:(Class )aClass
                     predicate:(NSPredicate *)aPredicate
                      pageSize:(NSNumber*)size
               sortDescriptors:(NSArray*)sortDes{
    return [self fetchWithEntityName:aClass predicate:aPredicate fetchLimit:0 offset:nil currentPage:nil pageSize:size sortDescriptors:sortDes];
}

- (NSArray *)fetchWithEntityName:(Class)aClass
                       predicate:(NSPredicate *)aPredicate
                      fetchLimit:(NSUInteger)aFetchLimit
                 sortDescriptors:(NSArray *)aSortDescriptors{
   return  [self fetchWithEntityName:aClass predicate:aPredicate fetchLimit:aFetchLimit offset:nil currentPage:nil pageSize:nil sortDescriptors:aSortDescriptors];
}

-(NSArray*)fetchWithEntityName:(Class)aClass
                     predicate:(NSPredicate *)aPredicate
                    fetchLimit:(NSUInteger)aFetchLimit
                        offset:(NSNumber*)offset
                   currentPage:(NSNumber*)currentPage
                      pageSize:(NSNumber*)size
               sortDescriptors:(NSArray*)sortDes{
    NSAssert(NSStringFromClass(aClass).length > 0 && [aClass isSubclassOfClass:[NSManagedObject class]], @"invalid Class name, __fetchWithEntityName");
    NSFetchRequest *fetchRequest = nil;
    if (aPredicate != nil) {
        fetchRequest = [aClass MR_requestAllWithPredicate:aPredicate];
    }else{
        fetchRequest = [aClass MR_requestAll];
    }
    
    if (aFetchLimit > 0) {
        fetchRequest.fetchLimit = aFetchLimit;
    }
   
    if (size.integerValue > 0) {
        [fetchRequest setFetchBatchSize:size.integerValue];
    }
    
    if (currentPage.integerValue > 0 ) {
        [fetchRequest setFetchOffset:(currentPage.integerValue-1)* size.integerValue + offset.integerValue];
    }
    
    if (sortDes != nil) {
        fetchRequest.sortDescriptors = sortDes;
    }
    return [aClass MR_executeFetchRequest:fetchRequest];
}

@end
