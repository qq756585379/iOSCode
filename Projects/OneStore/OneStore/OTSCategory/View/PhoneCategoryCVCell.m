//
//  PhoneCategoryCVCell.m
//  OneStore
//
//  Created by 杨俊 on 2017/8/8.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "PhoneCategoryCVCell.h"

@interface PhoneCategoryCVCell()
@property(nonatomic, strong)UIButton * picbutton;
@property(nonatomic, strong)UIButton * button;
@property(nonatomic, strong)UIView * picView;//图片视图
@property(nonatomic, strong)UIImageView * tagIV;//图片试图标签
@property(nonatomic, strong)UIImageView *productIV;//三级类目图片
@property(nonatomic, strong)NSLayoutConstraint *tagIVHeightConstraint;//标签高度约束
@end

@implementation PhoneCategoryCVCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initConstraint];
    }
    return self;
}

- (void)initUI {
    [self.contentView addSubview:self.picView];
    [self.contentView addSubview:self.lable];
    [self.contentView addSubview:self.picbutton];
    [self.contentView addSubview:self.button];
    [self.picView addSubview:self.productIV];
    [self.picView addSubview:self.tagIV];
}

- (void)initConstraint {
    [self initPicViewConstraint];
    NSDictionary *views = NSDictionaryOfVariableBindings(_picView,_lable, _picbutton,_button);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_picView]-0-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_lable]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_picbutton(26)]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_picView]-0-[_picbutton(16)]-5-[_lable]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_button]-0-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_button]-0-|" options:0 metrics:nil views:views]];
}

- (void)initPicViewConstraint {
    [self.picView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_tagIV(26)]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tagIV)]];
    [self.picView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_tagIV(16)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tagIV)]];
    [self.picView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_productIV]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productIV)]];
    [self.picView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_productIV]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productIV)]];
    self.tagIVHeightConstraint = [NSLayoutConstraint constraintWithItem:self.productIV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.picView attribute:NSLayoutAttributeHeight multiplier:0 constant:80];
    [self.picView addConstraint:self.tagIVHeightConstraint];
}

-(void)updateWithCellADSData:(OTSHotRecommendCategoryVO *)aADS{
    if (!aADS) {
        return;
    }
    self.hasADS = YES;
    self.aADS = aADS;
    
    NSString * name;
    if ([NSString countTheStrLength:aADS.words] >5) {//截取5位
        NSRange rang = {0,5};
        name= [aADS.words safeSubstringWithRange:rang];
    }else{
        name = aADS.words;
    }
    self.lable.text = name;
    
    [self updateTagWithCellADSData:self.aADS];
    
}

- (void)updateTagWithCellADSData:(OTSHotRecommendCategoryVO *)aADS {
    //hot 0_0_0  第一个0 高亮 第二个0 hot  第三个0 new   1代表有高亮 0表示没有
    NSMutableString * string_test = aADS.hot.mutableCopy;
    NSString * string = [string_test stringByReplacingOccurrencesOfString:@"_" withString:@""];//去_
    NSRange range1 =NSMakeRange (0,1);
    NSRange range2 =NSMakeRange (1,1);
    NSRange range3 =NSMakeRange (2,1);
    
    NSString * highLight = [string safeSubstringWithRange:range1];
    NSString * hot = [string safeSubstringWithRange:range2];
    NSString * new = [string safeSubstringWithRange:range3];
    
    [self updateTapWithHighLight:highLight hot:hot andNew:new];
}

- (void)updateTapWithHighLight:(NSString *)highLight hot:(NSString *)hot andNew:(NSString *)new {
    
    if ([new isEqualToString:@"1"] && [hot isEqualToString:@"1"]) {
        [self.picbutton setBackgroundImage:[UIImage imageNamed:@"tag-04"] forState:UIControlStateNormal];
        [self.picbutton setTitle:@"new" forState:UIControlStateNormal];
        [self.picbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else if([hot isEqualToString:@"1"]){
        [self.picbutton setBackgroundImage:[UIImage imageNamed:@"tag-03"] forState:UIControlStateNormal];
        [self.picbutton setTitle:@"hot" forState:UIControlStateNormal];
        [self.picbutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else if([new isEqualToString:@"1"]){
        [self.picbutton setBackgroundImage:[UIImage imageNamed:@"tag-04"] forState:UIControlStateNormal];
        [self.picbutton setTitle:@"new" forState:UIControlStateNormal];
        [self.picbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else{
        [self.picbutton setBackgroundImage:nil forState:UIControlStateNormal];
        [self.picbutton setTitle:nil forState:UIControlStateNormal];
        [self.picbutton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    }
    
    if ([highLight isEqualToString:@"1"]) {
        [self.lable setTextColor:[UIColor redColor]];
    }else{
        [self.lable setTextColor:[OTSColor colorWithRGB:0x111111]];
    }
}

-(void)updateWithCellData:(CategoryVO *)aData{
    self.hasADS = NO;
    
    CategoryVO * categotyThird = (CategoryVO *)aData;
    self.categoryVO = categotyThird;
    
    NSString * name;
    if ([NSString countTheStrLength:categotyThird.name] >5) {//截取5位
        NSRange rang = {0,5};
        name= [categotyThird.name safeSubstringWithRange:rang];
    }else{
        name = categotyThird.name;
    }
    self.lable.text = name;
    
    if ([OTSGlobalValue sharedInstance].showCategoryPic) {
        [self updatePicViewWithCellData:categotyThird];
    }else {
        [self updateNoPicViewWithCellData:categotyThird];
    }
    
    if (categotyThird.isHighLight.integerValue == 1) {
        [self.lable setTextColor:[OTSColor colorWithRGB:0xFF3C25]];
    }else{
        [self.lable setTextColor:[OTSColor colorWithRGB:0x111111]];
    }
}

-(void)updateNoPicViewWithCellData:(CategoryVO *)categotyThird {
    self.tagIVHeightConstraint.constant = 0;
    self.picbutton.hidden = NO;
    self.picView.hidden = YES;
    self.tagIV.hidden = YES;
    if (categotyThird.isNew.integerValue == 1 && categotyThird.isHot.integerValue == 1) {
        [self.picbutton setBackgroundImage:[UIImage imageNamed:@"tag-04"] forState:UIControlStateNormal];
        [self.picbutton setTitle:@"new" forState:UIControlStateNormal];
        [self.picbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else if(categotyThird.isHot.integerValue == 1){
        [self.picbutton setBackgroundImage:[UIImage imageNamed:@"tag-03"] forState:UIControlStateNormal];
        [self.picbutton setTitle:@"hot" forState:UIControlStateNormal];
        [self.picbutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else if(categotyThird.isNew.integerValue == 1){
        [self.picbutton setBackgroundImage:[UIImage imageNamed:@"tag-04"] forState:UIControlStateNormal];
        [self.picbutton setTitle:@"new" forState:UIControlStateNormal];
        [self.picbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else{
        [self.picbutton setBackgroundImage:nil forState:UIControlStateNormal];
        [self.picbutton setTitle:nil forState:UIControlStateNormal];
        [self.picbutton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    }
}

-(void)updatePicViewWithCellData:(CategoryVO *)categotyThird {
    if (UI_CURRENT_SCREEN_WIDTH <= 320) {
        self.tagIVHeightConstraint.constant = 65;
    }else {
        self.tagIVHeightConstraint.constant = 80;
    }
    self.picbutton.hidden = YES;
    self.picView.hidden = NO;
    self.tagIV.hidden = NO;
    [self.productIV sd_setImageWithURL:[NSURL URLWithString:categotyThird.iconPicUrl]placeholderImage:[UIImage imageNamed:@"defaultimg80x80"]];
    if (categotyThird.isNew.integerValue == 1 && categotyThird.isHot.integerValue == 1) {
        self.tagIV.image = [UIImage imageNamed:@"phone_category_label_new_26"];
    }else if(categotyThird.isHot.integerValue == 1){
        self.tagIV.image = [UIImage imageNamed:@"phone_category_label_hot_26"];
    }else if(categotyThird.isNew.integerValue == 1){
        self.tagIV.image = [UIImage imageNamed:@"phone_category_label_new_26"];
    }else{
        self.tagIV.image = nil;
    }
}

-(UIView *)picView {
    if (!_picView) {
        _picView = [UIView newAutoLayoutView];
    }
    return _picView;
}

-(UIImageView *)productIV {
    if (!_productIV) {
        _productIV = [UIImageView newAutoLayoutView];
    }
    return _productIV;
}

-(UIImageView *)tagIV{
    if (!_tagIV) {
        _tagIV = [UIImageView newAutoLayoutView];
    }
    return _tagIV;
}

-(UILabel *)lable{
    if (!_lable) {
        _lable = [UILabel newAutoLayoutView];
        if (SCREEN_WIDTH >320) {
            _lable.font = [UIFont systemFontOfSize:14.0];
        }else{
            _lable.font = [UIFont systemFontOfSize:12.0];
        }
        _lable.textAlignment = NSTextAlignmentCenter;;
        _lable.textColor = [OTSColor colorWithRGB:0x111111];
    }
    return _lable;
}

-(UIButton *)picbutton{
    if (!_picbutton) {
        _picbutton = [UIButton newAutoLayoutView];
        _picbutton.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return _picbutton;
}

-(UIButton *)button{
    if (!_button) {
        _button = [UIButton newAutoLayoutView];
        _button.backgroundColor = [UIColor clearColor];
        [_button addTarget:self action:@selector(thirdCategoryCellClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(void)thirdCategoryCellClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(phoneCategoryEntrySearch:)]) {
        [self.delegate phoneCategoryEntrySearch:self ];
    }
}

@end
