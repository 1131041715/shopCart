//
//  ViewController.m
//  shopCart
//
//  Created by 大碗豆 on 17/9/24.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import "ViewController.h"
#import "shopCartViewController.h"
#import "WeddingShopCenterPromptlyBuyViewController.h"

#import "WeddingShopCenterCarAddGoodsSheetView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,CarAddGoodsSheetViewDelegate>

@property (nonatomic ,strong) UITableView *tabView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ViewController

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@"购物车",@"加入购物车",@"预订单"];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"购物车";
    [self.view addSubview:self.tabView];
}


- (UITableView *)tabView{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _tabView.rowHeight = UITableViewAutomaticDimension;
        _tabView.estimatedRowHeight = 50;
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.backgroundColor = [UIColor whiteColor];
        _tabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tabView.separatorColor = [UIColor grayColor];
        _tabView.showsVerticalScrollIndicator = NO;
        _tabView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tabView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    cell.backgroundColor = ANYColorRandom;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor blackColor];
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        shopCartViewController *vc = [shopCartViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 1) {
        
        [self addBtnClick];
    }
    
    if (indexPath.row == 2) {
        WeddingShopCenterPromptlyBuyViewController *vc = [WeddingShopCenterPromptlyBuyViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}

- (void)addBtnClick{
    NSArray *oneData = @[@"使用时间", @"使用公里", @"所需颜色"];
    NSArray *towData = @[@[@"4小时", @"5小时", @"7小时", @"9小时", @"12小时"], @[@"40公里", @"60公里", @"80公里", @"100公里",@"200公里"], @[@"红色", @"白色", @"蓝色", @"橙色", @"黑色", @"黄色", @"棕色"]];
    
    NSMutableDictionary *headDicData = [NSMutableDictionary new];
    [headDicData setValue:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1506246808129&di=1c860fd7e450eb0a6a113708c08b97bf&imgtype=0&src=http%3A%2F%2Fgxsyxy.com%2Fwp-content%2Fuploads%2F2012%2F07%2FP1920253.jpg" forKey:@"headImageUrl"];
    [headDicData setValue:@"商品名称" forKey:@"headTitle"];
    [headDicData setValue:@"123" forKey:@"headMoney"];
    [headDicData setValue:@"200" forKey:@"shopNum"];
    
    WeddingShopCenterCarAddGoodsSheetView *sheetView = [[WeddingShopCenterCarAddGoodsSheetView alloc] initWithTitles:oneData items:towData headViewData:headDicData widthType:(WidthFixed) leftBtnType:cancle];
    
    sheetView.delegate = self;
    
    [sheetView showPickView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:sheetView];
    
}

- (void)transferCollectionClickWithSection:(NSArray*)sectionArr itemIndex:(NSArray*)itemArr goodsCounts:(NSInteger)count{
    
    
    NSLog(@"%@~~~%@~~~~%zd",sectionArr,itemArr,count);
    
//    for (NSInteger i = 0; i < sectionArr.count; i ++) {
//        NSString  *section = [NSString stringWithFormat:@"%@",sectionArr[i]];
//        NSString *item = [NSString stringWithFormat:@"%@",itemArr[i]];
//        
//        NSInteger sec = [section integerValue];
//        NSInteger ite = [item integerValue];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
