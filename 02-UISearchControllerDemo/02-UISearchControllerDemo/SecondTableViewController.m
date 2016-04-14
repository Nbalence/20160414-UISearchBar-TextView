//
//  SecondTableViewController.m
//  02-UISearchControllerDemo
//
//  Created by qingyun on 16/4/14.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "SecondTableViewController.h"

@interface SecondTableViewController ()<UISearchResultsUpdating>
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) NSArray *results;

@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation SecondTableViewController

-(void)loadDatas
{
    _datas = @[@"Here's", @"to", @"the", @"crazy", @"ones.", @"The", @"misfits.", @"The", @"rebels.", @"The", @"troublemakers.", @"The", @"round", @"pegs", @"in", @"the", @"square", @"holes.", @"The", @"ones", @"who", @"see", @"things", @"differently.", @"They're", @"not", @"fond", @"of", @"rules.", @"And", @"they", @"have", @"no", @"respect", @"for", @"the", @"status", @"quo.", @"You", @"can", @"quote", @"them,", @"disagree", @"with", @"them,", @"glorify", @"or", @"vilify", @"them.", @"About", @"the", @"only", @"thing", @"you", @"can't", @"do", @"is", @"ignore", @"them.", @"Because", @"they", @"change", @"things.", @"They", @"push", @"the", @"human", @"race", @"forward.", @"And", @"while", @"some", @"may", @"see", @"them", @"as", @"the", @"crazy", @"ones,", @"we", @"see", @"genius.", @"Because", @"the", @"people", @"who", @"are", @"crazy", @"enough", @"to", @"think", @"they", @"can", @"change", @"the", @"world,", @"are", @"the", @"ones", @"who", @"do."];
    
    _results = _datas;
}

-(UISearchController *)searchController{
    if (_searchController == nil) {
        //如果显示的结果在同一个视图上，那么参数传入nil
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        //设置更新者(一般来说设置成searchResultsController)
        _searchController.searchResultsUpdater = self;
    }
    return _searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDatas];
#if 0
    //把seachController的searchBar设置在导航栏上
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.navigationItem.titleView = self.searchController.searchBar;
#else
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 44);
    self.searchController.dimsBackgroundDuringPresentation = NO;
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
    
    cell.textLabel.text = _results[indexPath.row];
    return cell;
}
#pragma mark -UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text.length == 0) {//clear
        _results = _datas;
        [self.tableView reloadData];
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[CD] %@",searchController.searchBar.text];
    _results = [_datas filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
