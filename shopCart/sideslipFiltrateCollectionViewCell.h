//
//  sideslipFiltrateCollectionViewCell.h
//  sideslipFiltrate
//
//  Created by 大碗豆 on 17/8/11.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sideslipFiltrateCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel * lab_title;

- (void)configCellWithData:(NSDictionary *)dic;
@end
