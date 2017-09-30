//
//  UINib+create.h
//  OneStoreFramework
//
//  Created by Aimy on 8/26/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (create)

+ (instancetype)createWithNibName:(NSString *)aNibName;

+ (instancetype)createWithNibName:(NSString *)aNibName bundleName:(NSString *)aBundleName;

@end
