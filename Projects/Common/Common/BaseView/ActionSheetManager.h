//
//  ActionSheetManager.h
//  TZTV
//
//  Created by Luosa on 2016/11/18.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ActionSheetBlock)(NSString *title,NSInteger index);

@interface ActionSheetManager : NSObject

+ (void)actionSheetWithTitle:(NSString *)aTitle
                     message:(NSString *)aMessage
                     buttons:(NSArray *)buttons
           cancelButtonTitle:(NSString *)aCancelButtonTitle
            andCompleteBlock:(ActionSheetBlock)aBlock;


@end
