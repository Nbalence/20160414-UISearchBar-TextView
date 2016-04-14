//
//  ViewController.m
//  01-UISearchBarDemo
//
//  Created by qingyun on 16/4/14.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic, strong) NSDictionary *dict;                               //所有的数据集合
@property (nonatomic, strong) NSArray *keys;                                    //所有的键集合

@property (nonatomic, strong) NSMutableArray *results;                          //搜索结果集合
@property (nonatomic)         BOOL isSearching;                                 //搜索状态

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchBar *searchBar;                           //搜索框
@end

@implementation ViewController
static NSString *identifier = @"cell";
//加载数据
- (void)loadDictionaryFromFile {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    _keys = [_dict.allKeys sortedArrayUsingSelector:@selector(compare:)];
}

-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        //设置数据源和代理
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //注册单元格
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    }
    return _tableView;
}

- (UISearchBar *) searchBar {
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
        //设置代理
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据
    [self loadDictionaryFromFile];
    
    //添加tableView
    [self.view addSubview:self.tableView];
    
    self.navigationItem.titleView = self.searchBar;
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -UITabelViewSource
//组数
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return _isSearching ? 1 : _keys.count;
}
//行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isSearching) {
        return _results.count;
    }else{
        NSString *key = _keys[section];
        NSArray *array = _dict[key];
        return array.count;
    }
    
}

//行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (_isSearching) {
        cell.textLabel.text = _results[indexPath.row];
    }else{
        NSString *key = _keys[indexPath.section];
        NSArray *array = _dict[key];
        cell.textLabel.text = array[indexPath.row];
    }
    return cell;
}

//设置section的头标题
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return  _isSearching ? nil : _keys[section];
}

//索引
- (NSArray <NSString *> *) sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _isSearching ? nil : _keys;
}

#pragma mark  - UISearchBarDelegate
//开始编辑
- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
   //显示取消按钮
    searchBar.showsCancelButton = YES;
}

//点击取消按钮
- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    //1、隐藏取消按钮
    searchBar.showsCancelButton = NO;
    //2、取消searchBar的第一响应
    [searchBar resignFirstResponder];
    //3、清除文本
    searchBar.text = nil;
    //4、更改搜索状态
    _isSearching = NO;
    //5、刷新界面
    [self.tableView reloadData];
}
//点击键盘上的搜索按钮的时候调用
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //隐藏键盘
    [searchBar resignFirstResponder];
    //隐藏取消按钮
    searchBar.showsCancelButton = NO;
}
//当searchBar文本已经改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //当searchBar的文本被清空 时候
    if (searchBar.text.length == 0) {//clear
        _isSearching = NO;
        [self.tableView reloadData];
        return;
    }

    //1、更改搜索状态
    _isSearching = YES;
    //2、根据关键字检索数据
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[CD] %@", searchText];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSString *key in _keys) {
        NSArray *array = _dict[key];
        NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
        [mutableArray addObjectsFromArray:filteredArray];
    }
    _results = mutableArray;
    //3、刷新表视图
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
