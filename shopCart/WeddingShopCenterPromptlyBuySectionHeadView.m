//
//  WeddingShopCenterPromptlyBuySectionHeadView.m
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/9/10.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "WeddingShopCenterPromptlyBuySectionHeadView.h"

@implementation WeddingShopCenterPromptlyBuySectionHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithBaseView];
    }
    return self;
    
}


- (void)initWithBaseView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, 0, kScreenWidth, 50);
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:deleteBtn];
    //    [deleteBtn setImage:IMG(@"into") forState:UIControlStateNormal];
    deleteBtn.backgroundColor = [UIColor whiteColor];
    CGFloat margin = kScreenWidth - 40 * 2 - 10;
    
    deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(10, margin, 10, 10);
    [deleteBtn addTarget:self action:@selector(deleteSectionAction) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(40);
        //        make.width.mas_equalTo(40);
    }];
    
    
    UIImageView *shopImage = [UIImageView new];
    [self.contentView addSubview:shopImage];
    [shopImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(25);
        
    }];
    shopImage.image = IMG(@"rp");
    //    hjscsj
    //    shopCart
    self.shopName = [[UILabel alloc] init];
    [self.contentView addSubview:self.shopName];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(shopImage.mas_right).offset(10);
        make.height.mas_equalTo(30);
        ;
    }];
    
    UIImageView *intoImage = [UIImageView new];
    [self.contentView addSubview:intoImage];
    [intoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@18);
        make.width.equalTo(@18);
        
    }];
    intoImage.image = IMG(@"into");
    
    
    UIView *lineView = [UIView new];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-0.5);
        make.height.equalTo(@0.5);
    }];
    lineView.backgroundColor = ANYColorRandom;
 
}


- (void)deleteSectionAction{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(WeddingShopCenterPromptlyBuySectionHeadViewClickSetion:)]) {
        [self.delegate WeddingShopCenterPromptlyBuySectionHeadViewClickSetion:self.section];
    }
}




@end
