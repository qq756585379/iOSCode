//
//  ChooseGoodsPropertyCell.h
//  TZTV
//
//  Created by Luosa on 2016/11/19.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "OTSTableViewCell.h"
#import <SKTagView.h>

@interface ChooseGoodsPropertyCell : OTSTableViewCell

@property (weak, nonatomic) IBOutlet UILabel    *topLabel;
@property (weak, nonatomic) IBOutlet SKTagView  *containerView;

-(void)configColorWith:(NSArray *)arr withIdx:(NSInteger)idx0;
-(void)configSizeWith:(NSArray *)arr withIdx:(NSInteger)idx1;

@end
