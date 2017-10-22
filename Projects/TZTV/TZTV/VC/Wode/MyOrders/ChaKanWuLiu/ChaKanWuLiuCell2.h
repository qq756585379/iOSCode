//
//  ChaKanWuLiuCell2.h
//  TZTV
//
//  Created by Luosa on 2016/12/5.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "OTSTableViewCell.h"

@interface ChaKanWuLiuCell2 : OTSTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)setDataSourceIsFirst:(BOOL)isFirst isLast:(BOOL)isLast;

@end
