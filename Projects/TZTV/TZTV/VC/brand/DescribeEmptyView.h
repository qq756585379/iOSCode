//
//  DescribeEmptyView.h
//  TZTV
//
//  Created by Luosa on 2016/11/16.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "OTSTableViewCell.h"

@interface DescribeEmptyView : OTSTableViewCell

@property(nonatomic, strong)UILabel *emptyLabel;

@property(nonatomic, strong)UIImageView *alertIconView;

@property(nonatomic, strong)UIImageView *separatorLineView;

- (void)showSeparatorLineView;
- (void)hideSeparatorLineView;

@end
