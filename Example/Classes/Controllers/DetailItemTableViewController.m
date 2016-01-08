//
//  DetailItemTableViewController.m
//  AFNetworking iOS Example
//
//  Created by sherwin.chen on 15-6-17.
//  Copyright (c) 2015年 Gowalla. All rights reserved.
//

#import "DetailItemTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "GlobalTimelineViewController.h"

@interface DetailItemTableViewController ()

@end

@implementation DetailItemTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleName;
    
        return;
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
    
    [cell.textLabel setText:info[@"tname"]];
    [cell.detailTextLabel setText:info[@"alias"]];
    
    NSString *imageURL = [NSString stringWithFormat:@"http://timge7.126.net/image?w=68&h=68&quality=75&url=http%%3A%%2F%%2Fimg2.cache.netease.com%%2Fm%%2Fnewsapp%%2Ftopic_icons%%2F%@.png",info[@"img"]];
    
    NSLog(@"%@",imageURL);
    [cell.imageView setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"] isNeed:self.isNeedImage];
    
    UIButton *btn = (UIButton*)[cell viewWithTag:1024];
    if (btn==NULL) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(320-40-5, 5, 40, 40)];
        [btn setBackgroundColor:[UIColor blueColor]];
        [btn setTitle:@"添加" forState:UIControlStateNormal ];
        [btn addTarget:self action:@selector(addNewsItemForButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:btn];
    }
    
    btn.tag = indexPath.row;
    
    //cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

-(void) addNewsItemForButton:(UIButton*) sender
{
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GlobalTimelineViewController *gtVC = [[GlobalTimelineViewController alloc] init];
    
    NSDictionary *info = self.allList[(NSUInteger)indexPath.row];
    
    gtVC.newsItemInfo = info;
    
    [self.navigationController pushViewController:gtVC animated:YES];
    
    return;
}

- (CGFloat)tableView:(__unused UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

@end
