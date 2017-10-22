//
//  CityListHeader.h
//  TZTV
//
//  Created by Luosa on 2016/11/14.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "TableSectionHeader.h"

@interface CityListHeader : TableSectionHeader

@property (nonatomic, strong) UILabel *headerLabel;

@property (nonatomic, strong) UIButton *chooseBtn;

@property (nonatomic,   copy) void (^myBlock)();

@end
