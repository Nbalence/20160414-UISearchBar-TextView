//
//  ResultTableViewController.h
//  02-UISearchControllerDemo
//
//  Created by qingyun on 16/4/14.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewController : UITableViewController <UISearchResultsUpdating>
@property (nonatomic, strong) NSArray *willFilterArray;
@end
