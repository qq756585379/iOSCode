//
//  HomePageHeader.h
//  TZTV
//
//  Created by Luosa on 2016/12/27.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "TableSectionHeader.h"

@interface HomePageHeader : TableSectionHeader

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel     *titleLabel;

-(void)setIcon:(NSString *)icon andTitle:(NSString *)title;

@end