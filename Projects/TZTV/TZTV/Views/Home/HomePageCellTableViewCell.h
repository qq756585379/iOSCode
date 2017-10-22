//
//  HomePageCellTableViewCell.h
//  TZTV
//
//  Created by Luosa on 2016/11/10.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import "OTSTableViewCell.h"
#import "HomeModel2.h"
#import "LiveListModel.h"
#import "OTSCollectionVIew.h"

@interface HomePageCellTableViewCell : OTSTableViewCell

@property (nonatomic, strong) HomeModel2 *homeModel2;

@property (nonatomic,   copy) void(^block)(HomeModel2 *homeModel2);

@property (weak, nonatomic) IBOutlet OTSCollectionView *scrollCollectionView;

@end
