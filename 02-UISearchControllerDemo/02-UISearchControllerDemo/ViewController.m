//
//  ViewController.m
//  02-UISearchControllerDemo
//
//  Created by qingyun on 16/4/14.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "ResultTableViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *datas;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchContrller;              //搜索视图控制器
@end

@implementation ViewController

-(void)loadDatas
{
    _datas = @[@"Here's", @"to", @"the", @"crazy", @"ones.", @"The", @"misfits.", @"The", @"rebels.", @"The", @"troublemakers.", @"The", @"round", @"pegs", @"in", @"the", @"square", @"holes.", @"The", @"ones", @"who", @"see", @"things", @"differently.", @"They're", @"not", @"fond", @"of", @"rules.", @"And", @"they", @"have", @"no", @"respect", @"for", @"the", @"status", @"quo.", @"You", @"can", @"quote", @"them,", @"disagree", @"with", @"them,", @"glorify", @"or", @"vilify", @"them.", @"About", @"the", @"only", @"thing", @"you", @"can't", @"do", @"is", @"ignore", @"them.", @"Because", @"they", @"change", @"things.", @"They", @"push", @"the", @"human", @"race", @"forward.", @"And", @"while", @"some", @"may", @"see", @"them", @"as", @"the", @"crazy", @"ones,", @"we", @"see", @"genius.", @"Because", @"the", @"people", @"who", @"are", @"crazy", @"enough", @"to", @"think", @"they", @"can", @"change", @"the", @"world,", @"are", @"the", @"ones", @"who", @"do."];
}

- (UISearchController *)searchContrller {
    if (_searchContrller == nil) {
        //创建结果视图控制器
        ResultTableViewController *resultVC = [[ResultTableViewController alloc] initWithStyle:UITableViewStylePlain];
        resultVC.willFilterArray = self.datas;
        
        _searchContrller = [[UISearchController alloc] initWithSearchResultsController:resultVC];
        //更新者
        _searchContrller.searchResultsUpdater = resultVC;
        //其他的属性
        _searchContrller.dimsBackgroundDuringPresentation = YES;
        _searchContrller.hidesNavigationBarDuringPresentation = YES;
        //_searchContrller.obscuresBackgroundDuringPresentation = NO;
    }
    return _searchContrller;
}
- (IBAction)searchBarItemClick:(UIBarButtonItem *)sender {
    [self presentViewController:self.searchContrller animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDatas];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark  -UITableViewDataSource

//行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}
//行内容
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
    cell.textLabel.text = _datas[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
