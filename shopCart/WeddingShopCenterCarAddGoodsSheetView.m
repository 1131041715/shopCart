//
//  WeddingShopCenterCarAddGoodsSheetView.m
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/8/19.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "WeddingShopCenterCarAddGoodsSheetView.h"
#import "RHCollectionViewFlowLayout.h"
#import "sideslipFiltrateCollectionViewCell.h"

#define MarginX      10    //item X间隔
#define MarginY      10    //item Y间隔
#define ItemHeight   30    //item 高度
#define ItemWidth    30    //item 追加宽度

#define BackViewWitdh self.frame.size.width
#define BackViewHeight (self.frame.size.height * 2)/3
#define itemWidtn (BackViewWitdh - 40)/3

#define ScreenWd ([[UIScreen mainScreen] bounds].size.width)
#define Ratio    (ScreenWd/375.0)
#define InfoViewHt  (100.5*Ratio)
#define NumViewHt        (120*Ratio)
#define ColorItemWd      (68*Ratio)
#define ColorItemHt      (28*Ratio)

@interface WeddingShopCenterCarAddGoodsSheetView ()<UICollectionViewDelegate,UICollectionViewDataSource,RHCollectionViewDelegateFlowLayout,UITextFieldDelegate,UIGestureRecognizerDelegate>


@property (nonatomic, strong) UIView *bgView;              /** 背景view */
@property (nonatomic, strong) UIView *toolsView;           /** 自定义标签栏 */
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *goodsNoLabel;


@property (nonatomic, strong) UIView *bottomBackView;       /** 确认按钮 */

@property (nonatomic, strong) UIView *numView;
@property (nonatomic, strong) UITextField *textFiledCount;

@property (nonatomic, strong) UICollectionView *collectionView;  /** 选项view */
@property (nonatomic, strong) NSArray * titleArr;
@property (nonatomic, strong) NSArray * itemArr;
@property (nonatomic, strong) NSMutableArray * dataArr;

@property (nonatomic,assign) WidthType widthValueType;
@property (nonatomic,assign) leftBtttonType leftBtnValueType;

@property (nonatomic,strong) NSDictionary *headModelDic;
@end

@implementation WeddingShopCenterCarAddGoodsSheetView

static NSString *str = @"CarAddGoodsSheetViewFiltrateCollectContent";
static NSString *str1 = @"CarAddGoodsSheetViewFiltrateCollectHead";
static NSString *str2 = @"CarAddGoodsSheetViewFiltrateCollectFoot";

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles items:(NSArray<NSArray *> *)items headViewData:(NSDictionary *)headViewModel widthType:(WidthType)type leftBtnType:(leftBtttonType)leftType{
    
    self = [super init];
    
    if (self) {
        if (titles == nil) {
            _titleArr = @[@""];
        }else{
            _titleArr = [NSArray arrayWithArray:titles];
        }
        
        _itemArr = [NSArray arrayWithArray:items];
        
        self.widthValueType = type;
        self.leftBtnValueType = leftType;
        self.headModelDic = headViewModel;
        [self loadData];
        [self initSubViews];
    }
    return self;
}

- (void)loadData {
    
    [self.dataArr removeAllObjects];
    
    
    for (int i = 0; i < _itemArr.count; i++) {
        
        NSMutableArray * array = [[NSMutableArray alloc] init];
        NSArray * arr = _itemArr[i];
        
        for (int j = 0; j < arr.count; j++) {
            
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setObject:arr[j] forKey:@"title"];
//            if (j == 0) {
//                
//                [dic setObject:@YES forKey:@"isSelected"];
//            } else {
            
                [dic setObject:@NO forKey:@"isSelected"];
//            }
            [array addObject:dic];
        }
        [self.dataArr addObject:array];
    }
}


- (void)initSubViews{
    
    self.frame = CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height);

    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.toolsView];
    [self.bgView addSubview:self.collectionView];
    [self.bgView addSubview:self.bottomBackView];
    
}

#pragma mark - lazy

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenHeight, BackViewWitdh, BackViewHeight)];
        _bgView.backgroundColor = [UIColor lightGrayColor];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickView)];
        //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
        //    tapGestureRecognizer.cancelsTouchesInView = NO;
        tapGestureRecognizer.delegate = self;
        
        tapGestureRecognizer.numberOfTouchesRequired=1;
        
        tapGestureRecognizer.numberOfTapsRequired=1;
        //将触摸事件添加到view上
        [_bgView addGestureRecognizer:tapGestureRecognizer];
    }
    return _bgView;
}

/**父视图添加的手势在子视图中不响应*/
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.bgView]) {
        
        if (self.textFiledCount.editing) {
            
            if (self.textFiledCount.text.length < 1 || [self.textFiledCount.text isEqualToString:@"0"]) {
                self.textFiledCount.text = @"1";
            }
            [self.textFiledCount resignFirstResponder];
        }
        return NO;
    }
    return YES;
    
}


- (UIView *)toolsView{
    
    if (!_toolsView) {
    
        UIView *infoView = [[UIView alloc] init];
        infoView.backgroundColor = [UIColor whiteColor];
        infoView.frame = CGRectMake(0, 0, kScreenWidth, InfoViewHt);
       

        UIImageView *headerImageView = [[UIImageView alloc] init];
        headerImageView.backgroundColor = [UIColor redColor];
        headerImageView.layer.cornerRadius = 5*Ratio;
//        headerImageView.image = [UIImage imageNamed:@"rp"];
        [headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.headModelDic[@"headImageUrl"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        [infoView addSubview:headerImageView];
        [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(infoView).offset(10);
            make.top.mas_equalTo(infoView).offset(10);
            make.bottom.mas_equalTo(infoView).offset(-10);
            make.size.mas_equalTo(CGSizeMake((InfoViewHt - 20) * 1.5, InfoViewHt - 20));
        }];
        
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.text = [NSString stringWithFormat:@"￥%@",self.headModelDic[@"headMoney"]];
        priceLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        //        priceLabel.textColor = UIColorFromRGBA(0xFF4400);
        priceLabel.textColor = [UIColor redColor];
        [infoView addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headerImageView.mas_right).offset(9.5*Ratio);
            //            make.top.mas_equalTo(infoView).offset(25.5*Ratio);
            make.centerY.mas_equalTo(infoView);
            make.right.lessThanOrEqualTo(infoView.mas_right).offset(-10);
            
        }];
        self.priceLabel = priceLabel;
        
        UILabel *goodsDescribeLable = [[UILabel alloc] init];
        goodsDescribeLable.text = self.headModelDic[@"headTitle"];
        goodsDescribeLable.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        
        goodsDescribeLable.textColor = [UIColor blackColor];
        [infoView addSubview:goodsDescribeLable];
        [goodsDescribeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(priceLabel);
            make.right.lessThanOrEqualTo(infoView.mas_right).offset(-(5 + 5.5*Ratio + 23.5*Ratio));
            make.bottom.equalTo(priceLabel.mas_top).offset(-10);
            
        }];
//        self.goodsDescribeLable = goodsDescribeLable;
        
        UILabel *goodsNoLabel = [[UILabel alloc] init];
        goodsNoLabel.text = @"已选：";
        goodsNoLabel.textColor = [UIColor darkGrayColor];
        goodsNoLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
        [infoView addSubview:goodsNoLabel];
        [goodsNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(priceLabel);
            make.top.mas_equalTo(priceLabel.mas_bottom).offset(10);
            
            make.right.lessThanOrEqualTo(infoView.mas_right).offset(-10);
        }];
        self.goodsNoLabel = goodsNoLabel;
        
        UIButton *closeButton = [[UIButton alloc] init];
        [closeButton setImage:[UIImage imageNamed:@"tuichu"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(hidePickView) forControlEvents:UIControlEventTouchUpInside];
        [infoView addSubview:closeButton];
        [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(infoView).offset(5.5*Ratio);
            make.right.mas_equalTo(infoView).offset(-5.5*Ratio);
            make.size.mas_equalTo(CGSizeMake(23.5*Ratio, 23.5*Ratio));
        }];
        
        UIView *infoBottomBorder = [[UIView alloc] init];
        infoBottomBorder.backgroundColor = [UIColor grayColor];
        [infoView addSubview:infoBottomBorder];
        [infoBottomBorder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(infoView);
            make.width.mas_equalTo(infoView);
            make.bottom.mas_equalTo(infoView);
            make.height.mas_equalTo(0.5);
        }];
        
        _toolsView = infoView;
    }
    return _toolsView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout1=[[UICollectionViewFlowLayout alloc] init];
        if (self.widthValueType == WidthFixed) {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.minimumLineSpacing = MarginY;
            layout.minimumInteritemSpacing = 0;
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            
            layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            flowLayout1 = layout;
            
        }else{
            RHCollectionViewFlowLayout * flowLayout = [[RHCollectionViewFlowLayout alloc] init];
            flowLayout.minimumLineSpacing = MarginY;
            flowLayout.minimumInteritemSpacing = MarginX;
            flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            flowLayout1 = flowLayout;
        }
        
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, InfoViewHt, kScreenWidth, BackViewHeight - InfoViewHt - 48*Ratio)  collectionViewLayout:flowLayout1];
        collection.backgroundColor = [UIColor lightGrayColor];
        collection.delegate = self;
        collection.dataSource = self;
        
        [collection registerClass:[sideslipFiltrateCollectionViewCell class] forCellWithReuseIdentifier:str];
        //header注册
        [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:str1];
        //foot注册
        [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:str2];
        
        _collectionView = collection;
    }
    
    return _collectionView;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _titleArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_itemArr[section] count];
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.widthValueType == WidthFixed) {
        return CGSizeMake(itemWidtn, ItemHeight);
    }else{
        
        float width = [UILabel getWidthByText:_itemArr[indexPath.section][indexPath.row] font:[UIFont systemFontOfSize:14]]+ ItemWidth;
        return CGSizeMake(width, ItemHeight);
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSString *textL = _titleArr[section];
        if (textL.length == 0) {
            return CGSizeMake(self.bounds.size.width, 25);
        }else{
            return CGSizeMake(self.bounds.size.width, 50);
        }
        
    }else{
        return CGSizeMake(self.bounds.size.width, 40);
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    CGSize size1;
    
    size1 = CGSizeMake(self.bounds.size.width, 0.5);
    
    if (section == self.dataArr.count - 1) {
        size1 = CGSizeMake(self.bounds.size.width, NumViewHt);
    }
    
    return size1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    sideslipFiltrateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 6;
    cell.layer.masksToBounds = YES;
    
    if (indexPath.row < [self.dataArr[indexPath.section] count]) {
        
        NSDictionary * dic = _dataArr[indexPath.section][indexPath.row];
        [cell configCellWithData:dic];
    }
    
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%zd",indexPath.row);
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:self.dataArr[indexPath.section]];
    
    for (int i = 0; i < array.count; i++) {
        
        NSMutableDictionary * dic = array[i];
        if (i == indexPath.row) {
            
            [dic setObject:@YES forKey:@"isSelected"];
        } else {
            
            [dic setObject:@NO forKey:@"isSelected"];
        }
        [array replaceObjectAtIndex:i withObject:dic];
    }
    [_dataArr replaceObjectAtIndex:indexPath.section withObject:array];
    [_collectionView reloadData];
    
    [self checkAllPropertyChosed];
    
}

- (void)checkAllPropertyChosed{
    
    NSMutableArray *arrSelect = [NSMutableArray new];
    for (NSInteger i = 0; i < self.dataArr.count; i ++) {
        NSMutableArray * array = [NSMutableArray arrayWithArray:self.dataArr[i]];
        for (int j = 0; j < array.count; j++) {
            NSMutableDictionary * dic = array[j];
            if ([dic[@"isSelected"] boolValue]) {
                [arrSelect addObject:dic[@"title"]];
                if (arrSelect.count == self.dataArr.count) {
                    NSString *str = @"已选：";
                    for (NSString *strValue in arrSelect) {
                        NSString *strV = [NSString stringWithFormat:@" %@",strValue];
                        str = [str stringByAppendingString:strV];
                    }
                    self.goodsNoLabel.text = str;
                }
            }
        }
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *re = nil;
    //    [re removeFromSuperview];
    //设置追加视图
    if (kind == UICollectionElementKindSectionHeader) {
        
        //头部
        re = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:str1 forIndexPath:indexPath];
        re.backgroundColor = [UIColor lightGrayColor];
        for (UIView *view in [re subviews]) {
            
            [view removeFromSuperview];
        }
        if (indexPath.section == 0) {
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BackViewWitdh, 10)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [re addSubview:lineView];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 40)];
            lab.text = _titleArr[indexPath.section];

            [re addSubview:lab];
        }else{
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 40)];
            lab.text = _titleArr[indexPath.section];
            [re addSubview:lab];
        }
      
        return  re;
    }
    else if (kind == UICollectionElementKindSectionFooter)
    {
        //尾部
        
        re = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:str2 forIndexPath:indexPath];
        re.backgroundColor = [UIColor whiteColor];
        for (UIView *view in [re subviews]) {
            
            [view removeFromSuperview];
        }
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, BackViewWitdh - 20, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        
        if (indexPath.section < self.dataArr.count - 1) {
            
            [re addSubview:lineView];
        }
        
        if (indexPath.section == self.dataArr.count - 1) {
            
            [re addSubview:self.numView];
        }
        return re;
    }
    return  nil;
    
}

- (UIView *)numView{
    if (!_numView) {
        
        UIView *numView = [[UIView alloc] init];
        numView.backgroundColor = [UIColor lightGrayColor];
        numView.frame = CGRectMake(0, 0, kScreenWidth, NumViewHt);
        
        UILabel *numTitleLabel = [[UILabel alloc] init];
        numTitleLabel.text = @"数量";
        numTitleLabel.font = [UIFont systemFontOfSize:14*Ratio];
        numTitleLabel.textColor = [UIColor blackColor];
        [numView addSubview:numTitleLabel];
        [numTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(numView).offset(16*Ratio);
            make.top.mas_equalTo(numView).offset(22*Ratio);
        }];
        
        /**数量增减*/
        
        UIView *countChangeBtnView = [[UIView alloc] init];
        countChangeBtnView.backgroundColor = [UIColor whiteColor];
        countChangeBtnView.layer.cornerRadius = ColorItemHt/2;
        countChangeBtnView.layer.masksToBounds = YES;
        countChangeBtnView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        countChangeBtnView.layer.borderWidth = 0.2;
        [numView addSubview:countChangeBtnView];
        [countChangeBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(numTitleLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(numTitleLabel);
            make.size.mas_equalTo(CGSizeMake(ColorItemWd + 50, ColorItemHt));
        }];
        
        UIButton *reduceBtn = [[UIButton alloc] init];
        [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
        [reduceBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        reduceBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [reduceBtn addTarget:self action:@selector(changeCountBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        reduceBtn.tag = 10;
        [countChangeBtnView addSubview:reduceBtn];
        [reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.mas_equalTo(countChangeBtnView);
            make.width.mas_equalTo(ColorItemHt);
        }];
        
        UIButton *addBtn = [[UIButton alloc] init];
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [addBtn addTarget:self action:@selector(changeCountBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        addBtn.tag = 11;
        [countChangeBtnView addSubview:addBtn];
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(countChangeBtnView);
            make.width.mas_equalTo(ColorItemHt);
        }];
        
        UITextField *textFiledCount = [[UITextField alloc] init];
        textFiledCount.font = [UIFont systemFontOfSize:12];
        textFiledCount.textColor = [UIColor blackColor];
        textFiledCount.borderStyle = UITextBorderStyleNone;
        textFiledCount.text = @"1";
        textFiledCount.textAlignment = NSTextAlignmentCenter;
//        [textFiledCount addTarget:self action:@selector(textFiledAction:) forControlEvents:(UIControlEventEditingChanged)];
        textFiledCount.keyboardType = UIKeyboardTypeNumberPad;
        [countChangeBtnView addSubview:textFiledCount];
        [textFiledCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(countChangeBtnView);
            make.centerX.mas_equalTo(countChangeBtnView);
            make.width.mas_equalTo(ColorItemWd + 50 - ColorItemHt*2);
        }];
        textFiledCount.enabled = NO;
        textFiledCount.delegate = self;
        self.textFiledCount = textFiledCount;
        
        _numView = numView;
        
    }
    
    return _numView;
}

- (void)changeCountBtnAction:(UIButton *)btn{
    
    NSInteger count = [self.textFiledCount.text integerValue];
    
//    NSLog(@"%@",btn.titleLabel.text);
    switch (btn.tag) {
        case 10:
        {
            if (count > 1 ) {
                self.textFiledCount.text = [NSString stringWithFormat:@"%zd",count - 1];
            }
        }
            break;
        case 11:
        {
            
            NSInteger shopNum = [self.headModelDic[@"shopNum"] integerValue];
            if (count < shopNum) {
                
                self.textFiledCount.text = [NSString stringWithFormat:@"%zd",count + 1];
            }else{
                alert(@"超出范围");
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
//    NSLog(@"%@~~~~~~~~~",textField.text);
    
    NSInteger shopNum = [self.headModelDic[@"shopNum"] integerValue];
    
    if ([textField.text integerValue] < shopNum) {
        self.textFiledCount.text = textField.text;
        
    }else{
        self.textFiledCount.text = @"1";
    }
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}



- (UIView *)bottomBackView{
    if (!_bottomBackView) {
        UIView *bottomBtnBackView = [[UIView alloc] init];
        bottomBtnBackView.backgroundColor = [UIColor whiteColor];
        bottomBtnBackView.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), kScreenWidth, 48*Ratio);
        
        UIButton *confirmButton = [[UIButton alloc] init];
        confirmButton.backgroundColor = [UIColor redColor];
        [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        confirmButton.titleLabel.font = [UIFont systemFontOfSize:16*Ratio];
        [confirmButton addTarget:self action:@selector(popConfirm) forControlEvents:UIControlEventTouchUpInside];
        confirmButton.layer.cornerRadius = 3;
        confirmButton.layer.masksToBounds = YES;
        [bottomBtnBackView addSubview:confirmButton];
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bottomBtnBackView);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(48*Ratio - 20);
            make.centerY.mas_equalTo(bottomBtnBackView);
            
        }];
        
        _bottomBackView = bottomBtnBackView;
    }
    
    return _bottomBackView;
}


- (void)popConfirm {
    [self checkChosedProperty];
    
//    NSLog(@"点击确定");
    
}

- (void)checkChosedProperty{
    
    NSMutableArray *arrSelect = [NSMutableArray new];
    
    NSMutableArray *sectionArr = [NSMutableArray new];
    NSMutableArray *itemArr = [NSMutableArray new];
    
    for (NSInteger i = 0; i < self.dataArr.count; i ++) {
        NSMutableArray * array = [NSMutableArray arrayWithArray:self.dataArr[i]];
        for (int j = 0; j < array.count; j++) {
            NSMutableDictionary * dic = array[j];
            if ([dic[@"isSelected"] boolValue]) {
                //                NSLog(@"%ld,%d",(long)i,j);
                //                NSLog(@"%@~~~~~~~~~",dic[@"title"]);
                [arrSelect addObject:dic[@"title"]];
                
                if (arrSelect.count == self.dataArr.count) {
                    NSString *str = @"已选：";
                    for (NSString *strValue in arrSelect) {
                        
                        NSString *strV = [NSString stringWithFormat:@" %@",strValue];
                        
                        str = [str stringByAppendingString:strV];
                    }
                    self.goodsNoLabel.text = str;
//                NSLog(@"%@~~~~~~~~~",str);
                    
                }
                [sectionArr addObject:@(i)];
                [itemArr addObject:@(j)];
            }
        }
    }
    
    if (arrSelect.count == self.dataArr.count) {
        if ([self.delegate respondsToSelector:@selector(transferCollectionClickWithSection:itemIndex:goodsCounts:)]) {
            [self.delegate transferCollectionClickWithSection:sectionArr itemIndex:itemArr goodsCounts:[self.textFiledCount.text integerValue]];
        }
        [self hidePickView];
    }else{
        alert(@"请将信息填写完整");
    }
  
}


#pragma mark private methods
- (void)showPickView{
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.frame = CGRectMake(0, kScreenHeight - BackViewHeight, BackViewWitdh, BackViewHeight);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidePickView{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.bgView.frame = CGRectMake(0, kScreenHeight, BackViewWitdh, BackViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickView];
    }
}

@end

