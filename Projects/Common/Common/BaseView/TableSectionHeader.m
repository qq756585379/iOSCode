//
//  TableSectionHeader.m
//  TZTV
//
//  Created by Luosa on 2016/11/11.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "TableSectionHeader.h"
#import "NSObject+BeeNotification.h"

@implementation TableSectionHeader

+(instancetype)tableHeaderWithTableView:(UITableView *)tv{
    TableSectionHeader *header=[tv dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([self class])];
    if (!header) {
        header=[[self alloc] initWithReuseIdentifier:NSStringFromClass([self class])];
    }
    return header;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

+ (NSString *)cellReuseIdentifier{
    return NSStringFromClass([self class]);
}

- (void)updateWithCellData:(id)aData{
    
}

+ (CGFloat)heightForCellData:(id)aData{
    return 0;
}

- (void)dealloc{
    [self unobserveAllNotifications];
}

@end
