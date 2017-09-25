//
//  shopCartHeadView.m
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/7/17.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "ShopCartHeadView.h"

//#define screen_width [UIScreen mainScreen].bounds.size.width
//#define screen_height [UIScreen mainScreen].bounds.size.height

//#define IMG(name)       [UIImage imageNamed:name]

@implementation ShopCartHeadView

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
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.selectBtn];
    
    [self.selectBtn setImage:IMG(@"shopcat_no_select") forState:UIControlStateNormal];
    [self.selectBtn setImage:IMG(@"shopcat_select") forState:UIControlStateSelected];
    self.selectBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(5);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
    UIImageView *shopImage = [UIImageView new];
    [self.contentView addSubview:shopImage];
    [shopImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.selectBtn.mas_right).offset(10);
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
    
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:deleteBtn];
    [deleteBtn setImage:IMG(@"into") forState:UIControlStateNormal];
    
    CGFloat margin = kScreenWidth - 40 * 2 - 10;
    
    deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(10, margin, 10, 10);
    [deleteBtn addTarget:self action:@selector(deleteSectionAction) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(5);
        make.left.equalTo(self.selectBtn.mas_right).offset(10);
        make.height.mas_equalTo(40);
//        make.width.mas_equalTo(40);
    }];
    
    
    
}

- (void)deleteSectionAction {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(ShopCartHeadViewDeleteCurrectSectionsInView:)]) {
        [self.delegate ShopCartHeadViewDeleteCurrectSectionsInView:self.section];
    }
}

- (void)selectAction:(UIButton *)button {
    if (button.selected) {
        button.selected = NO;
    }else{
        button.selected = YES;
    }
    if (self.delegate &&[self.delegate respondsToSelector:@selector(ShopCartHeadViewCurrectSectionsInView:selectStatus:)]) {
        [self.delegate ShopCartHeadViewCurrectSectionsInView:self.section selectStatus:button.selected];
    }
}

@end
