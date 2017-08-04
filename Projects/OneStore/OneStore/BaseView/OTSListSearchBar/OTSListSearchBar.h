//
//  OTSListSearchBarDelegate.h
//  OneStore
//
//  Created by 韩佚 on 16/5/18.
//  Copyright © 2016年 Songyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OTSSearchBarWordView;

@protocol OTSListSearchBarDelegate <NSObject>

- (void)wordView:(OTSSearchBarWordView *)wordView clearButtonClick:(UIButton *)clearButton index:(NSInteger)index;

@end

@interface OTSListSearchBar : UISearchBar

@property (nonatomic, weak) id<UISearchBarDelegate, OTSListSearchBarDelegate> delegate;

@property (nonatomic, assign) CGFloat wordViewLeftgap;

// 分词功能开关
@property (nonatomic, assign, getter = isWordSwitch) BOOL wordSwitch;

// 根据提供的 keyWord 更新搜索框 （开关打开时有效）
- (void)checkWord:(NSString *)keyWord;

// 取消分词模式
- (void)restoreSearchWord;

@end
