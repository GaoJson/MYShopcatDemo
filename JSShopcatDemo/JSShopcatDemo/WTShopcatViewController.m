//
//  WTShopcatViewController.m
//  WeiTuoApp
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import "WTShopcatViewController.h"
#import "WTShopcatCell.h"
#import "WTShopcatHeadView.h"
#import "WTShopcatModel.h"
#import "Masonry.h"
@interface WTShopcatViewController ()<UITableViewDelegate
,UITableViewDataSource,WTShopcatCellDelegate,WTShopcatHeadViewDelegate>
{
    UILabel *_allMoneyLabel;
    UIButton *_payButton;
    
}
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation WTShopcatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购物车";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
    [self setFootView];
    [self setShopcatInformation];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(exitPage)];
}

- (void)exitPage {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getData
- (void)setShopcatInformation {
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 7; i ++ ) {
       WTShopcatModel *model = [[WTShopcatModel alloc] init];
        model.shopName = [NSString stringWithFormat:@"店铺%d",(int)i];
        model.selectStatus = NO;
        model.productArray = [NSMutableArray array];
        for (NSInteger j = 0; j < 5; j ++ ) {
            WTShopcatProductModel *productModel  = [[WTShopcatProductModel alloc] init];
            productModel.productName = [NSString stringWithFormat:@"商品=%ld  商品=%ld",j ,i];
            productModel.selectStatus = NO;
            productModel.productPrice = arc4random()%100;
            productModel.productCount = arc4random()%10 + 1;
            [model.productArray addObject:productModel];
        }
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
    [self updateAllpriceAction];
}


#pragma mark - setFootView
- (void)setFootView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0,screen_height - tabbar_height , screen_width, tabbar_height)];
    [self.view addSubview:footView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 0.5)];
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
    
    UILabel *allselectLabel = [[UILabel alloc] init];
    [footView addSubview:allselectLabel];
    allselectLabel.text = @"全选";
    [allselectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(50);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
        make.centerY.equalTo(footView);
    }];
   
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [footView addSubview:_payButton];
    _payButton.backgroundColor = WT_COLOR_TABBAR;
    [_payButton setTitle:@"付款(0)" forState:0];
    [_payButton setTitleColor:[UIColor whiteColor] forState:0];
    [_payButton addTarget:self action:@selector(gotoOderPage) forControlEvents:UIControlEventTouchUpInside];
    _payButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(footView).offset(-0);
        make.height.mas_equalTo(48);
        make.top.equalTo(footView).offset(0);
        make.width.mas_equalTo(80);
    }];
    
    _allMoneyLabel = [[UILabel alloc] init];
    [footView addSubview:_allMoneyLabel];
    _allMoneyLabel.text = @"合计：¥0.00";
    _allMoneyLabel.font = [UIFont systemFontOfSize:14];
    _allMoneyLabel.textColor  = [UIColor blackColor];
    [_allMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(footView).offset(-90);
        make.centerY.equalTo(footView);
        make.height.mas_equalTo(25);
    }];
}

- (void)selectAllProductAction:(UIButton *)button {
    if (button.selected) {
        button.selected = NO;
    }else{
        button.selected = YES;
    }
    for (WTShopcatModel *shopModel in self.dataArray) {
        shopModel.selectStatus = button.selected;
        for (WTShopcatProductModel *productModel in shopModel.productArray) {
            productModel.selectStatus = button.selected;
        }
    }
    [self.tableView reloadData];
    [self updateAllpriceAction];
}

- (void)updateAllpriceAction {
    CGFloat allmoney = 0;
    NSInteger counts = 0;;
    for (WTShopcatModel *shopModel in self.dataArray) {
        for (WTShopcatProductModel *productModel in shopModel.productArray) {
            if (productModel.selectStatus) {
                allmoney += productModel.productPrice * productModel.productCount;
                counts ++;
            }
        }
    }
    NSString *moneys = [NSString stringWithFormat:@"¥%.2f",allmoney];
    NSString *tempString = [@"合计：" stringByAppendingString:moneys];
    _allMoneyLabel.attributedText = [self changeLabelColorOriginalString:tempString changeString:moneys];
    [_payButton setTitle:[NSString stringWithFormat:@"付款(%ld)",counts] forState:0];
}

- (void)gotoOderPage {
    
    
}



#pragma mark setTableView
- (void)setTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width , screen_height - tabbar_height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:WTShopcatCells bundle:nil] forCellReuseIdentifier:WTShopcatCells];
    [self.tableView registerClass:[WTShopcatHeadView class] forHeaderFooterViewReuseIdentifier:WTShopcatHeadViews];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    WTShopcatModel *model = self.dataArray[section];
    return model.productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WTShopcatCell *cell = [tableView dequeueReusableCellWithIdentifier:WTShopcatCells];
    cell.indexPath = indexPath;
    cell.delegate = self;
    
    WTShopcatModel *shopModel = self.dataArray[indexPath.section];
    WTShopcatProductModel *productModel = shopModel.productArray[indexPath.row];
    cell.title.text = productModel.productName;
    cell.price.text = [NSString stringWithFormat:@"%.2f",productModel.productPrice];
    cell.conutText.text = [NSString stringWithFormat:@"%ld",(long)productModel.productCount];
    if (productModel.selectStatus) {
        cell.selectBtn.selected = YES;
    }else{
       cell.selectBtn.selected = NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - product  edit
- (void)selectProductActionWithIndex:(NSIndexPath *)indexPath selectFlag:(BOOL)selectFlag {
    WTShopcatModel *shopModel = self.dataArray[indexPath.section];
    WTShopcatProductModel *productModel = shopModel.productArray[indexPath.row];
    productModel.selectStatus = selectFlag;
    [self updateAllpriceAction];
}

- (void)addProductCountActionWithIndex:(NSIndexPath *)indexPath {
    WTShopcatModel *shopModel = self.dataArray[indexPath.section];
    WTShopcatProductModel *productModel = shopModel.productArray[indexPath.row];
    productModel.productCount ++;
    [self.tableView reloadData];
    [self updateAllpriceAction];
}

- (void)subProductCountActionWithIndex:(NSIndexPath *)indexPath {
    WTShopcatModel *shopModel = self.dataArray[indexPath.section];
    WTShopcatProductModel *productModel = shopModel.productArray[indexPath.row];
    productModel.productCount --;
    if (productModel.productCount <= 0) {
        productModel.productCount = 1;
    }
    [self.tableView reloadData];
    [self updateAllpriceAction];
}

- (void)deleteProductActionWithIndex:(NSIndexPath *)indexPath {
    WTShopcatModel *shopModel = self.dataArray[indexPath.section];
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
    WTShopcatHeadView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:WTShopcatHeadViews];
    head.delegate = self;
    head.section = section;
    WTShopcatModel *model = self.dataArray[section];
    head.shopName.text = model.shopName;
    if (model.selectStatus) {
        head.selectBtn.selected = YES;
    }else{
       head.selectBtn.selected = NO;
    }
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (void)WTShopcatHeadViewCurrectSectionsInView:(NSInteger)section selectStatus:(BOOL)selectStatus {
    WTShopcatModel *model = self.dataArray[section];
    model.selectStatus = selectStatus;
    for (WTShopcatProductModel *productModel in model.productArray) {
        productModel.selectStatus = selectStatus;
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    [self updateAllpriceAction];
}

- (void)WTShopcatHeadViewDeleteCurrectSectionsInView:(NSInteger)section {
    if (self.dataArray.count > section) {
        [self.dataArray removeObjectAtIndex:section];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (NSMutableAttributedString *)changeLabelColorOriginalString:(NSString *)originalString changeString:(NSString *)changeString {
    NSRange changeStringRange = [originalString rangeOfString:changeString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:originalString];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:changeStringRange];
    return attributedString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
