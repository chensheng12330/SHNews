//
//  AllListTableViewController.m
//  AFNetworking iOS Example
//
//  Created by sherwin.chen on 15-6-17.
//  Copyright (c) 2015年 Gowalla. All rights reserved.
//

#import "AllListTableViewController.h"
#import "DetailItemTableViewController.h"

@interface AllListTableViewController ()
@property (readwrite, nonatomic, strong) NSArray *allList;
@end

@implementation AllListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"分类";
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"all" ofType:@"txt"] ];
    
    self.allList = [data objectFromJSONData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(__unused UITableView *)tableView
 numberOfRowsInSection:(__unused NSInteger)section
{
    return (NSInteger)[self.allList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsViewController";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *info = self.allList[(NSUInteger)indexPath.row];
    
    [cell.textLabel setText:info[@"cName"]];
    
    NSString *infoStr = [NSString stringWithFormat:@"%@ - [%lu]",info[@"cid"],(unsigned long)((NSArray*)info[@"tList"]).count];
    [cell.detailTextLabel setText:infoStr];
    
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailItemTableViewController *detailItemVC  = [[DetailItemTableViewController alloc] init];
    
    NSDictionary *info = self.allList[(NSUInteger)indexPath.row];
    
    NSArray *newsList = info[@"tList"];
    
    detailItemVC.allList   = newsList;
    detailItemVC.titleName = info[@"cName"];
    
    [self.navigationController pushViewController:detailItemVC animated:YES];
}
@end
