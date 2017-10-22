//
//  CityListCell.h
//  TZTV
//
//  Created by Luosa on 2016/11/11.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "OTSTableViewCell.h"

@interface CityListCell : OTSTableViewCell

@property (nonatomic, strong) NSArray *cityArray;

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end
