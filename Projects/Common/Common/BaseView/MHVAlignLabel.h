//
//  MHVAlignLabel.h
//  MiHome
//
//  Created by Woody on 16/8/24.
//  Copyright © 2016年 小米移动软件. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    VAlignmentTop,
    VAlignmentMiddle,
    VAlignmentBottom,
} VAlignment;

@interface MHVAlignLabel : UILabel
@property (nonatomic, assign) VAlignment vAlignment;
@end
