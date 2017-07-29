//
//  MHVAlignLabel.m
//  MiHome
//
//  Created by Woody on 16/8/24.
//  Copyright © 2016年 小米移动软件. All rights reserved.
//

#import "MHVAlignLabel.h"

@implementation MHVAlignLabel

- (void)awakeFromNib{
    [super awakeFromNib];
    self.vAlignment = VAlignmentMiddle;
}
    
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.vAlignment = VAlignmentMiddle;
    }
    return self;
}

- (void)setVerticalAlignment:(VAlignment)verticalAlignment {
    _vAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.vAlignment) {
        case VAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end





