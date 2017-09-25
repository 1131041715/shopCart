//
//  shopCartViewController.m
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/7/17.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "shopCartViewController.h"
#import "ShopCartHeadView.h"
#import "ShopCartCell.h"
#import "ShopCartModel.h"


#import "ShopCartDicDataModel.h"
//
//#import "WeddingShopCenterPromptlyBuyViewController.h"

@interface shopCartViewController ()<UITableViewDelegate,UITableViewDataSource,ShopCartCellDelegate,shopCartHeadViewDelegate>

{
    UILabel *_allMoneyLabel;
    UILabel *_saveMoneyLable;
    UIButton *_payButton;
    
}

@property (nonatomic,strong) UIButton *selectAllBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *footDataArr;
@property (nonatomic, strong) UIButton *bottomBtn;

@property (nonatomic, strong) ShopCartDicDataModel *model;

@property (nonatomic, copy) void (^sectionGoodsIsAllSelectStatusBlock)(BOOL status);


@end

@implementation shopCartViewController


- (NSMutableArray *)footDataArr{
    if (!_footDataArr) {
        NSMutableArray *mulArr = [NSMutableArray new];
        for (NSInteger i = 0; i < 9; i ++) {
            [mulArr addObject:@(i)];
        }
        _footDataArr = mulArr;
    }
    return _footDataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestRefreshShopCartDicData];
    
}

- (void)requestRefreshShopCartDicData{
    
    NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shopCart.plist" ofType:nil]];
    
    ShopCartDicDataModel *model = [ShopCartDicDataModel mj_objectWithKeyValues:dicData];
    
    self.model = model;
    [self setShopcatInformation:model];
    
}

#pragma mark - getData
- (void)setShopcatInformation:(ShopCartDicDataModel*)model{
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < model.data.list.count; i ++ ) {
        
        ShopCartDicDataShopArayList *shopDic = model.data.list[i];
        
        ShopCartModel *model = [[ShopCartModel alloc] init];
        model.shopName = [NSString stringWithFormat:@"%@",shopDic.shopname];
        model.selectStatus = NO;
        model.productArray = [NSMutableArray array];
        
        NSInteger allDelFlag = 0;
        
        for (NSInteger j = 0; j < shopDic.shop.count; j ++ ) {
            
            ShopCartGoodsArayList *goodsDic = shopDic.shop[j];
            
            ShopCartProductModel *productModel  = [[ShopCartProductModel alloc] init];
            productModel.productName = [NSString stringWithFormat:@"%@",goodsDic.shopname];
            productModel.selectStatus = NO;
            productModel.productPriceNow = [NSString stringWithFormat:@"￥%.2f",goodsDic.money];
            productModel.productPriceLate = [NSString stringWithFormat:@"￥%.2f",goodsDic.market];
            productModel.productCount = goodsDic.num;
            productModel.shopCartId = goodsDic.id;
            productModel.soldOut = goodsDic.del;
            
            if (!productModel.soldOut) {
                allDelFlag ++;
            }
            if (allDelFlag == shopDic.shop.count) {
                model.soldOut = YES;
            }else{
                model.soldOut = NO;
            }
            
            NSArray *attrAllKey = [goodsDic.attr allKeys];
            NSMutableArray *valueArr = [NSMutableArray new];
            for (NSInteger index = 0; index < attrAllKey.count; index ++ ) {
                NSString *str = [NSString stringWithFormat:@"%@",goodsDic.attr[attrAllKey[index]]];
                [valueArr addObject:str];
            }
            NSString *sizeStr = [NSString stringWithFormat:@"规格：%@",[valueArr componentsJoinedByString:@" "]];
            productModel.productSize = sizeStr;
            productModel.imageUrl = goodsDic.img;
            
            [model.productArray addObject:productModel];
        }
        [self.dataArray addObject:model];
    }
    
    [self setTableView];
    [self setFootView];
    [self.tableView reloadData];
    [self updateAllpriceAction];
}

- (void)updateAllpriceAction {
    CGFloat allmoney = 0;
    CGFloat savemoney = 0;
    NSInteger counts = 0;;
    for (ShopCartModel *shopModel in self.dataArray) {
        for (ShopCartProductModel *productModel in shopModel.productArray) {
            if (productModel.selectStatus) {
                CGFloat priceNow = [[productModel.productPriceNow substringFromIndex:1] floatValue];
                allmoney += priceNow * productModel.productCount;
                CGFloat priceLate = [[productModel.productPriceLate substringFromIndex:1] floatValue];
                savemoney += priceLate *productModel.productCount;
                counts ++;
            }
        }
    }
    NSString *moneys = [NSString stringWithFormat:@"¥%.2f",allmoney];
    NSString *tempString = [@"实付金额：" stringByAppendingString:moneys];
//    _allMoneyLabel.attributedText = [self changeLabelColorOriginalString:tempString changeString:moneys];
    _allMoneyLabel.text = tempString;
    
    NSString *savemoneys = [NSString stringWithFormat:@"¥%.2f",savemoney - allmoney];
    NSString *savetempString = [@"节省：" stringByAppendingString:savemoneys];
//        _allMoneyLabel.attributedText = [self changeLabelColorOriginalString:tempString changeString:moneys];
    _saveMoneyLable.text = savetempString;
    
//    [_payButton setTitle:[NSString stringWithFormat:@"去结算(%ld)",counts] forState:0];
}

- (NSMutableAttributedString *)changeLabelColorOriginalString:(NSString *)originalString changeString:(NSString *)changeString {
    NSRange changeStringRange = [originalString rangeOfString:changeString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:originalString];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:changeStringRange];
    return attributedString;
}


#pragma mark - setFootView
- (void)setFootView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenHeight - 49, kScreenWidth , 49)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor = RGB_COLOR(200, 200, 200);
    [footView addSubview:line];
    
    UIButton *selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footView addSubview:selectAllBtn];
    [selectAllBtn setImage:IMG(@"shopcat_no_select") forState:UIControlStateNormal];
    [selectAllBtn setImage:IMG(@"shopcat_select") forState:UIControlStateSelected];
    selectAllBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [selectAllBtn addTarget:self action:@selector(selectAllProductAction:) forControlEvents:UIControlEventTouchUpInside];
    [selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
        make.centerY.equalTo(footView);
    }];
    
    NSInteger allDelFlag = 0;
    for (ShopCartModel *model in self.dataArray) {
        if (model.soldOut) {
            allDelFlag ++;
        }
    }
    if (allDelFlag == self.dataArray.count) {
        
        selectAllBtn.enabled = NO;
    }
    
    self.selectAllBtn = selectAllBtn;
    
    UILabel *allselectLabel = [[UILabel alloc] init];
    [footView addSubview:allselectLabel];
    allselectLabel.text = @"全选";
    allselectLabel.font = [UIFont systemFontOfSize:16];
    [allselectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(50);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
        make.centerY.equalTo(footView);
    }];
    
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [footView addSubview:_payButton];
    _payButton.backgroundColor = [UIColor orangeColor];
    [_payButton setTitle:@"去结算" forState:0];
    [_payButton setTitleColor:[UIColor whiteColor] forState:0];
    [_payButton addTarget:self action:@selector(gotoOderPage) forControlEvents:UIControlEventTouchUpInside];
    _payButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.bottom.equalTo(footView);
        make.width.mas_equalTo(100);
    }];
    
    _allMoneyLabel = [[UILabel alloc] init];
    [footView addSubview:_allMoneyLabel];
    _allMoneyLabel.text = @"实付金额：¥0.00";
    _allMoneyLabel.font = [UIFont systemFontOfSize:12];
    _allMoneyLabel.textColor  = [UIColor redColor];
    [_allMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(allselectLabel.mas_right).offset(10);
        make.top.equalTo(footView).offset(8);
        make.height.mas_equalTo(17);
    }];
    
    _saveMoneyLable = [[UILabel alloc] init];
    [footView addSubview:_saveMoneyLable];
    _saveMoneyLable.text = @"节省：¥0.00";
    _saveMoneyLable.font = [UIFont systemFontOfSize:12];
    _saveMoneyLable.textColor  = [UIColor lightGrayColor];
    [_saveMoneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(allselectLabel.mas_right).offset(10);
        make.bottom.equalTo(footView).offset(-8);
        make.height.mas_equalTo(17);
    }];
}


- (void)selectAllProductAction:(UIButton *)button {
    if (button.selected) {
        button.selected = NO;
    }else{
        button.selected = YES;
    }
    for (ShopCartModel *shopModel in self.dataArray) {
        shopModel.selectStatus = button.selected;
        for (ShopCartProductModel *productModel in shopModel.productArray) {
            productModel.selectStatus = button.selected;
        }
    }
    [self.tableView reloadData];
    [self updateAllpriceAction];
}

- (void)gotoOderPage {
    // 结算所选择的按钮
    NSLog(@"结算~~~~~~~~~");
 
}


#pragma mark setTableView
- (void)setTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth , kScreenHeight - 49 - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 120;
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    
//    self.tableView.separatorStyle
    //修改分割线颜色
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:ShopCartCells bundle:nil] forCellReuseIdentifier:ShopCartCells];
    [self.tableView registerClass:[ShopCartHeadView class] forHeaderFooterViewReuseIdentifier:ShopCartHeadViews];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ShopCartModel *model = self.dataArray[section];
    return model.productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:ShopCartCells];
    cell.indexPath = indexPath;
    cell.delegate = self;
    
    ShopCartModel *shopModel = self.dataArray[indexPath.section];
    ShopCartProductModel *productModel = shopModel.productArray[indexPath.row];
    
    cell.model = productModel;
    
    if (productModel.soldOut) {
        
        if (productModel.selectStatus) {
            cell.selectBtn.selected = YES;
        }else{
            cell.selectBtn.selected = NO;
        }
    }else{
        [cell.selectBtn setTitle:@"失效" forState:UIControlStateNormal];
        [cell.selectBtn setImage:nil forState:UIControlStateNormal];
        [cell.selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        cell.selectBtn.enabled = NO;
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"进入详情页面~~~~~~~~~");
    
}

#pragma mark - product  edit
- (void)selectProductActionWithIndex:(NSIndexPath *)indexPath selectFlag:(BOOL)selectFlag {
    ShopCartModel *shopModel = self.dataArray[indexPath.section];
    ShopCartProductModel *productModel = shopModel.productArray[indexPath.row];
    productModel.selectStatus = selectFlag;
    
    NSInteger flag = 0;

        for (NSInteger j = 0; j < shopModel.productArray.count; j ++) {
            
            ShopCartProductModel *productModel = shopModel.productArray[j];
            
            if (productModel.selectStatus) {
                
                flag ++;
            }
            
            if (flag == shopModel.productArray.count) {
                
                NSLog(@"%zd~~~~<>><><><><><><>~~~~~",flag);
                
                shopModel.selectStatus = YES;
                
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
               
            }else{
                
                shopModel.selectStatus = NO;
                
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
    
/**判断是否全部选择，改变全选按钮*/
    NSInteger allFlag = 0;
    for (ShopCartModel *shopModel in self.dataArray) {
        if (shopModel.selectStatus) {
            allFlag ++;
        }
        
        if (allFlag == self.dataArray.count) {
            self.selectAllBtn.selected = YES;
        }else{
            self.selectAllBtn.selected = NO;
        }
    }
    
    [self updateAllpriceAction];
}

- (void)addProductCountActionWithIndex:(NSIndexPath *)indexPath {
    ShopCartModel *shopModel = self.dataArray[indexPath.section];
    ShopCartProductModel *productModel = shopModel.productArray[indexPath.row];
    
    productModel.productCount ++;

    [self.tableView reloadData];
    [self updateAllpriceAction];
}

- (void)subProductCountActionWithIndex:(NSIndexPath *)indexPath {
    
    ShopCartModel *shopModel = self.dataArray[indexPath.section];
    ShopCartProductModel *productModel = shopModel.productArray[indexPath.row];
    
    productModel.productCount --;
    
    if (productModel.productCount <= 1) {
        productModel.productCount = 1;
        
    }
    [self.tableView reloadData];
    [self updateAllpriceAction];
}

- (void)deleteProductActionWithIndex:(NSIndexPath *)indexPath {
    ShopCartModel *shopModel = self.dataArray[indexPath.section];
    if (shopModel.productArray.count > indexPath.row) {
        [shopModel.productArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        if (!shopModel.productArray.count) {
            [self.dataArray removeObjectAtIndex:indexPath.section];
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView reloadData];
        }
    }
    [self updateAllpriceAction];
    
}


#pragma mark - header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ShopCartHeadView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ShopCartHeadViews];
    head.delegate = self;
    head.section = section;
    ShopCartModel *model = self.dataArray[section];
    head.shopName.text = model.shopName;
    
    NSInteger allFlagSection = 0;
    for (ShopCartProductModel *productModel in model.productArray) {
        if (!productModel.soldOut) {
            allFlagSection ++;
        }
    }
    
    if (allFlagSection == model.productArray.count) {
        [head.selectBtn setTitle:@"失效" forState:UIControlStateNormal];
        [head.selectBtn setImage:nil forState:UIControlStateNormal];
        [head.selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        head.selectBtn.enabled = NO;
        
    }else{
        
        if (model.selectStatus) {
            head.selectBtn.selected = YES;
        }else{
            head.selectBtn.selected = NO;
        }
    }
    
    
    return head;
}

- (void)ShopCartHeadViewCurrectSectionsInView:(NSInteger)section selectStatus:(BOOL)selectStatus{
    
    ShopCartModel *model = self.dataArray[section];
    model.selectStatus = selectStatus;
    for (ShopCartProductModel *productModel in model.productArray) {
        productModel.selectStatus = selectStatus;
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    
    /**判断是否全部选择，改变全选按钮*/
    NSInteger allFlag = 0;
    for (ShopCartModel *shopModel in self.dataArray) {
        if (shopModel.selectStatus) {
            allFlag ++;
        }
        
        if (allFlag == self.dataArray.count) {
            self.selectAllBtn.selected = YES;
        }else{
            self.selectAllBtn.selected = NO;
        }
    }
    [self updateAllpriceAction];
    
    
}

- (void)ShopCartHeadViewDeleteCurrectSectionsInView:(NSInteger)section {
    
    NSLog(@"进入店铺");
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
