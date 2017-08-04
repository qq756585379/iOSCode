//
//  SearchBarWordView.h
//  OneStore
//
//  Created by 韩佚 on 16/5/18.
//  Copyright © 2016年 Songyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OTSSearchBarWordView;

@protocol OTSSearchBarWordViewDelegate <NSObject>
- (void)wordView:(OTSSearchBarWordView *)wordView clearButtonClick:(UIButton *)clearButton;
@end

@interface OTSSearchBarWordView : UIView

@property (nonatomic, weak) id<OTSSearchBarWordViewDelegate> delegate;

- (void)updateWordLabelWith:(NSString *)text;

- (NSString *)getWordViewText;

@end
