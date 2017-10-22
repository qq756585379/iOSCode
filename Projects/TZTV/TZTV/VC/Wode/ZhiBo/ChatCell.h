//
//  ChatCell.h
//  TZTV
//
//  Created by Luosa on 2016/12/27.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "OTSTableViewCell.h"
#import "ChatModel.h"

@interface ChatCell : OTSTableViewCell

@property (nonatomic, strong) UILabel   *chatLabel;
@property (nonatomic, strong) ChatModel *chatM;

@end
