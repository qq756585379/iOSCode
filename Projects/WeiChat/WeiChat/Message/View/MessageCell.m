//
//  MessageCell.m
//  WeiChat
//
//  Created by 杨俊 on 2017/10/11.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "MessageCell.h"
#import "ColorDefine.h"
#import <Masonry/Masonry.h>

static const CGFloat topPadding  = 8;
static const CGFloat leftPadding = 9;

@interface MessageCell()
@property (nonatomic, weak) UIImageView *avatarImageView;
@property (nonatomic, weak) UILabel *usernameLabel;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UILabel *messageLabel;
@end

@implementation MessageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self avatarImageView];
        [self usernameLabel];
        [self dateLabel];
        [self messageLabel];
        [self unreadLabel];
    }
    return self;
}
-(void)setGroup:(Group *)group{
    _group = group;
    
    if (group.isTop == 1) {
        self.backgroundColor = HEXRGBCOLOR(0xf6f9fa);
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
    if (group.unReadCount > 0) {
        [self.unreadLabel setTitle:[NSString stringWithFormat:@"%d",group.unReadCount] forState:UIControlStateNormal];
        self.unreadLabel.backgroundColor     = [UIColor redColor];
    } else {
        [self.unreadLabel setTitle:@" " forState:UIControlStateNormal];
        self.unreadLabel.backgroundColor = self.backgroundColor;
    }
    NSString *imageName = [NSString stringWithFormat:@"%u.jpg",arc4random() % 29];
    _avatarImageView.image = [UIImage imageNamed:imageName];
    [_messageLabel setText:group.lastMsgString];
    [_usernameLabel setText:group.gName];
    
    _dateLabel.text = @"11:20";
}

- (void)layoutSubviews{
    CGFloat imageWidth = self.height - topPadding*2;
    self.leftFreeSpace = 0;
    [super layoutSubviews];
    
    [_avatarImageView setFrame:CGRectMake(leftPadding, topPadding, imageWidth, imageWidth)];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-9);
        make.top.equalTo(self.mas_top).offset(13);
        make.width.mas_equalTo(70);
    }];
    [_usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(13);
        make.left.equalTo(_avatarImageView.mas_right).offset(8);
        make.right.equalTo(_dateLabel.mas_left).offset(-5);
    }];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_usernameLabel.mas_bottom).offset(4);
        make.left.equalTo(_avatarImageView.mas_right).offset(8);
        make.right.equalTo(_dateLabel.mas_left).offset(-5);
    }];
    [_unreadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_messageLabel.mas_centerY);
        make.right.mas_equalTo(-9);
    }];
}

- (UIView *) avatarImageView{
    if (_avatarImageView == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:imageV];
        _avatarImageView = imageV;
    }
    return _avatarImageView;
}
- (UILabel *) usernameLabel{
    if (_usernameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _usernameLabel.font = [UIFont systemFontOfSize:17.0];
        _usernameLabel = label;
    }
    return _usernameLabel;
}
- (UILabel *) dateLabel{
    if (_dateLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [label setTextAlignment:NSTextAlignmentRight];
        [label setTextColor:HEXRGBCOLOR(0xadadad)];
        label.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:label];
        _dateLabel = label;
    }
    return _dateLabel;
}
- (UILabel *) messageLabel{
    if (_messageLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:HEXRGBCOLOR(0x9a9a9a)];
        label.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:label];
        _messageLabel = label;
    }
    return _messageLabel;
}
- (UIButton *)unreadLabel{
    if (_unreadLabel == nil) {
        UIButton *button = [[UIButton alloc] init];
        [self.contentView addSubview:button];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 8;
        button.contentEdgeInsets   = UIEdgeInsetsMake(1, 5, 1, 5);
        button.backgroundColor     = [UIColor redColor];
        button.titleLabel.font     = [UIFont systemFontOfSize:12.0];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _unreadLabel   = button;
    }
    return _unreadLabel;
}

@end
