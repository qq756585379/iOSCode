//
//  MessageCell.h
//  WeiChat
//
//  Created by 杨俊 on 2017/10/11.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "Group.h"

@interface MessageCell : BaseTableViewCell

@property (nonatomic, strong) Group * group;

@property (nonatomic, weak) UIButton *unreadLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
