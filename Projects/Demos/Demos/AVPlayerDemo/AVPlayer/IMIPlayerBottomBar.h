//
//  IMIPlayerBottomBar.h
//  MiHome
//
//  Created by yangjun on 2017/6/5.
//  Copyright © 2017年 小米移动软件. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMIPlayerBottomBar : UIView
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *fullScreenBtn;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;

@property (weak, nonatomic) IBOutlet UILabel  *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel  *rightLabel;
@property (weak, nonatomic) IBOutlet UISlider *silder;
@end
