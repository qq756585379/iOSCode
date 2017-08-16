//
//  PhoneCategoryTVCell.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "PhoneCategoryTVCell.h"
#import "OTSColor.h"
#import "PureLayout.h"

@interface PhoneCategoryTVCell()
@property(nonatomic, strong)UIButton * picturebtn;
@property(nonatomic, strong)UIButton * lablebtn;
@property(nonatomic, strong)UIButton * lineBtn;
@property(nonatomic, strong)UIButton * lineHeightBtn;
@property(nonatomic, strong)UIImageView * imageV;
@end

@implementation PhoneCategoryTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.userInteractionEnabled = NO;
        [self setUI];
        [self setUIConstraints];
    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.lablebtn];
    [self.contentView addSubview:self.picturebtn];
    [self.contentView addSubview:self.lineBtn];
    [self.contentView addSubview:self.lineHeightBtn];
    [self.contentView setBackgroundColor:[OTSColor colorWithRGB:0xeeeeee]];
}

-(void)setUIConstraints{
    NSDictionary *views = NSDictionaryOfVariableBindings(_lablebtn, _picturebtn, _lineBtn, _lineHeightBtn);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-17-[_picturebtn(24)]-5-[_lablebtn(20)]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lineBtn(1)]-0-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lineHeightBtn(3)]-0-|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_lablebtn]-5-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-28-[_picturebtn(24)]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_lineBtn]-10-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_lineHeightBtn]-10-|" options:0 metrics:nil views:views]];
}

#pragma mark --更新数据
-(void)updateWithCellData:(id)aData{
    CategoryVO *categoryVO = (CategoryVO *)aData;
    self.categoryVO = categoryVO;//纪录tvc的categoryVO对象
    
    [self updateTitleWithCategoryVO:categoryVO];
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:categoryVO.iconPicUrl] placeholderImage:[UIImage imageNamed:@"newdefault_category"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        if (image == nil) {
            [self.picturebtn setBackgroundImage:[UIImage imageNamed:@"newdefault_category"] forState:UIControlStateNormal];
            [self.picturebtn setBackgroundImage:[[UIImage imageNamed:@"newdefault_category"] imageTintedWithColor:[UIColor colorWithHue:1 saturation:1 brightness:1 alpha:1.0]] forState:UIControlStateSelected];//ff3c25
        }else{
            [self.picturebtn setBackgroundImage:image forState:UIControlStateNormal];
            [self.picturebtn setBackgroundImage:[image imageTintedWithColor:[UIColor colorWithHue:1 saturation:1 brightness:1 alpha:1.0]] forState:UIControlStateSelected];
        }
    }];
}

/**
 *  标题
 */
- (void)updateTitleWithCategoryVO:(CategoryVO *)categoryVO {
    NSString *name;
    if ([NSString countTheStrLength:categoryVO.name] >4) {//截取4位
        NSRange rang = {0,4};
        name= [categoryVO.name substringWithRange:rang];
    }else{
        name = categoryVO.name;
    }
    
    [self.lablebtn setTitle:name forState:UIControlStateNormal];
    [self.lablebtn setTitle:name forState:UIControlStateSelected];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    self.picturebtn.selected = selected;
    self.lablebtn.selected =selected;
    self.lineBtn.selected = selected;
    self.lineHeightBtn.selected = selected;
}

#pragma mark --属性
-(UIButton *)picturebtn{
    if (!_picturebtn) {
        _picturebtn = [UIButton newAutoLayoutView];
        _picturebtn.userInteractionEnabled = NO;
    }
    return _picturebtn;
}

-(UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [UIImageView newAutoLayoutView];
        _imageV.userInteractionEnabled = NO;
    }
    return _imageV;
}

-(UIButton *)lablebtn{
    if (!_lablebtn) {
        _lablebtn = [UIButton newAutoLayoutView];
        _lablebtn.userInteractionEnabled = NO;
        _lablebtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [_lablebtn setTitleColor:[OTSColor colorWithRGB:0x757575] forState:UIControlStateNormal];
        [_lablebtn setTitleColor:[OTSColor colorWithRGB:0xff3c25] forState:UIControlStateSelected];
    }
    return _lablebtn;
}

-(UIButton *)lineBtn{
    if (!_lineBtn) {
        _lineBtn = [UIButton newAutoLayoutView];
        _lineBtn.userInteractionEnabled = NO;
        [_lineBtn.layer setMasksToBounds:YES];
        [_lineBtn.layer setCornerRadius:2]; //设置矩形四个圆角半径
        [_lineBtn setBackgroundColor:[OTSColor colorWithRGB:0xe0e0e0]];
    }
    return _lineBtn;
}

-(UIButton *)lineHeightBtn{
    if (!_lineHeightBtn) {
        _lineHeightBtn = [UIButton newAutoLayoutView];
        _lineHeightBtn.userInteractionEnabled = NO;
        [_lineHeightBtn.layer setMasksToBounds:YES];
        [_lineHeightBtn.layer setCornerRadius:2]; //设置矩形四个圆角半径
        [_lineHeightBtn setBackgroundImage:[UIImage imageNamed:@"line-Highlight"] forState:UIControlStateSelected];
    }
    return _lineHeightBtn;
}

@end
