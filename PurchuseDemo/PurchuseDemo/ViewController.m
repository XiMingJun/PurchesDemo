//
//  ViewController.m
//  PurchuseDemo
//
//  Created by wangjian on 15/11/7.
//  Copyright © 2015年 com.qhfax. All rights reserved.
//

#import "ViewController.h"
#import "FirstVC.h"
#import "ChooseTableViewCell.h"
#import "DataModels.h"
#include <stdlib.h>//分配内存空间需要

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL                     *_flag;//一维数组，标记区头的展开合并
    NSInteger              **_count;//购买的商品个数，二维数组
    NSMutableArray     *_array;
    UITableView            *_tableView;
    float                         _maxColum;//二维数组列数最大值
    double                   _totalPrice;//总价格
}
@end

@implementation ViewController
- (void)dealloc{
    //释放二维数组
    for (int i = 0; i < 10; i++) {
        free(_count[i]);//先释放一级指针
        free(_count);//在释放二级指针
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _array = [[NSMutableArray alloc] init];
    
    _maxColum = 0;
    _totalPrice = 0;
    [self loadDate];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor brownColor]];
    [btn setTitle:@"jump" forState:UIControlStateNormal];
    btn.frame = CGRectMake(40, 20, 60, 40);
    [btn addTarget:self action:@selector(jumpToNextArea) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)jumpToNextArea{
    FirstVC *vc = [[FirstVC alloc] init];
    vc.countNum = _count;
    vc.dateArray = _array;
    vc.totalPrice = _totalPrice;
    [self presentViewController:vc
                       animated:YES
                     completion:^{
                         
                     }];
    
}
/**加载数据*/
- (void)loadDate{
    NSString *filePath =  [[NSBundle mainBundle] pathForResource:@"Json" ofType:@"txt"];
    NSData *jsonDate = [NSData dataWithContentsOfFile:filePath];
    NSError *error= nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonDate
                                                             options:NSJSONReadingMutableLeaves
                                                               error:&error];
    if (!error) {
        NSArray *dataArray = jsonDict[@"data"];
        for (int i = 0; i < dataArray.count; i++) {
            PurchaseModel *model = [[PurchaseModel alloc]  initWithDictionary:dataArray[i]];
            [_array addObject:model];
            _maxColum = (model.commodityLst.count  > _maxColum) ? model.commodityLst.count : _maxColum ;
        }
        [self commonInit];
    }
    else{
        NSLog(@"不是标准的Json数据");
    }
}
/**初始化数组，一维，二维*/
- (void)commonInit{

    //malloc开辟一块内存空间，用来存储BOOL型数组
    _flag = malloc(sizeof(BOOL)* _array.count);
    //memset设置BOOL数组的初始值
    memset(_flag, YES, sizeof(BOOL)*_array.count);
    
    //1.开辟内存空间
    //分配10个指向NSInteger 类型的指针，10行
    _count = (NSInteger **)malloc(sizeof(NSInteger *)*_array.count);
    for (int i = 0;i < _array.count; i++) {
        //每行分配一个指向8个NSInteger类型的指针，8列
        _count[i] = (NSInteger *)malloc(sizeof(NSInteger*)*_maxColum);
    }
    //2.初始化
    for (int i = 0; i < _array.count; i++) {
        for (int j = 0; j < _maxColum; j ++) {
            _count[i][j] = 0;
        }
    }
    //赋值方法
//    _count[2][3] = 10;
//    _count[1][2] = 9;

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                              style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
/**更新价格*/
- (void)updateTotalPrice{

    _totalPrice = 0;
    
    for (int i = 0; i < _array.count; i++) {
        PurchaseModel *model = _array[i];
        for (int j = 0; j < model.commodityLst.count; j++) {
            CommodityLst *commodModel = model.commodityLst[j];
            _totalPrice += commodModel.salePrice * _count[i][j];
            if (_count[i][j] > 0) {
//                NSLog(@"%@--%ld瓶",commodModel.name,_count[i][j]);
            }
        }
    }
//    NSLog(@"总价格----%f",_totalPrice);

}
# pragma mark---UITableView Delegate
//设置table有几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _array.count;
}
//设置每个区有几行，通过返回不同整数来实现分组的展开与合并
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_flag[section]) {
        if (_array.count > 0) {
            PurchaseModel *model = _array[section];
            return model.commodityLst.count;//分组展开
        }
        else{
            return 0;
        }
    }else{
        return 0;//分组合并
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
//设置每一行的具体内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
    }
    if (_array.count > 0) {
        PurchaseModel *model = _array[indexPath.section];
        CommodityLst *commodityModel = model.commodityLst[indexPath.row];
        cell.textLabel.text = commodityModel.name;
        cell.wineQuantity.text = [NSString stringWithFormat:@"%ld",(long)_count[indexPath.section][indexPath.row]];
        __weak     ViewController       *tempVC = self;
        cell.block = ^(int num){
//            NSLog(@"%@---%d",commodityModel.name,num);
            _count[indexPath.section][indexPath.row] = num;
            [tempVC updateTotalPrice];
        };
    }
    return cell;
}
//设置区头高度

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

//自定义sectionHeader
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //sectionHeader也可以重用
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionHeader"];
    if (!view) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"sectionHeader"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
        if (_array.count > 0) {
            PurchaseModel *model = _array[section];
            [button setTitle:model.categoryName forState:UIControlStateNormal];
        }
       // [button addTarget:self action:@selector(headerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        button.tag = 10;
    }
    //subviews返回一个数组，数组中存的是这个view的所有子view
    NSArray *array = [view subviews];
    //遍历所有子view，tag>0的一定是我们自己添加的button
    for (UIView *but in array) {
        if (but.tag>0) {
            but.tag = section+1;
        }
    }
    return view;
}
//点击区头的方法
- (void)headerButtonClick:(UIButton *)sender{
    //取反
    _flag[sender.tag - 1] = !_flag[sender.tag -1];
    //动画加载一个区
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag - 1] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
