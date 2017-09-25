//
//  sideslipFiltrateCollectionViewCell.m
//  sideslipFiltrate
//
//  Created by 大碗豆 on 17/8/11.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import "sideslipFiltrateCollectionViewCell.h"

@interface sideslipFiltrateCollectionViewCell ()


@end

@implementation sideslipFiltrateCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.lab_title];
    }
    return self;
}

#pragma mark - layout subviews

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _lab_title.frame = self.bounds;
}

#pragma mark - config cell

- (void)configCellWithData:(NSDictionary *)dic {
    
    _lab_title.text = dic[@"title"];
    _lab_title.layer.borderColor = [UIColor grayColor].CGColor;
    _lab_title.layer.borderWidth = 0.5;
    if ([dic[@"isSelected"] boolValue]) {
        
        _lab_title.backgroundColor = [UIColor redColor];
        _lab_title.textColor = [UIColor whiteColor];
    } else {
        _lab_title.backgroundColor = [UIColor orangeColor];
        _lab_title.textColor = [UIColor blackColor];
    }
}

#pragma mark - setter and getter

- (UILabel *)lab_title {
    
    if (!_lab_title) {
        
        _lab_title = [[UILabel alloc] init];
        _lab_title.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _lab_title.layer.cornerRadius = 4.0;
        _lab_title.layer.masksToBounds = YES;
        _lab_title.textAlignment = NSTextAlignmentCenter;
        _lab_title.font = [UIFont systemFontOfSize:14];
    }
    return _lab_title;
}

@end
