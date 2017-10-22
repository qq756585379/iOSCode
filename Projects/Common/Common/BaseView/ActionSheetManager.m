//
//  ActionSheetManager.m
//  TZTV
//
//  Created by Luosa on 2016/11/18.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "ActionSheetManager.h"

@implementation ActionSheetManager

+ (void)actionSheetWithTitle:(NSString *)aTitle
                    message:(NSString *)aMessage
                     buttons:(NSArray *)buttons
           cancelButtonTitle:(NSString *)aCancelButtonTitle
            andCompleteBlock:(ActionSheetBlock)aBlock{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:aTitle
                                                                   message:aMessage
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i=0; i<buttons.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:buttons[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            aBlock(buttons[i],i);
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:aCancelButtonTitle style:UIAlertActionStyleCancel handler:nil]];
    [[[self window] rootViewController] presentViewController:alert animated:YES completion:nil];
}

+ (UIWindow *) window {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window  == nil) {
        if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
            window = [[UIApplication sharedApplication].delegate window];
        }
    }
    return window;
}

@end
