//
//  historyController.m
//  testProject
//
//  Created by 欣创 on 2019/3/8.
//  Copyright © 2019年 欣创. All rights reserved.
//

#import "historyController.h"
#import "FullData.h"

@interface historyController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation historyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"gameInfo：%@", [FullData shared].gameInfo);

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 30;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FullData shared].gameInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //製作可重複利用的表格欄位Cell
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    //設定欄位的內容與類型
    UILabel *teamAlabel = (UILabel*)[cell viewWithTag:1];
    [teamAlabel setText:[[[FullData shared].gameInfo objectAtIndex:indexPath.row] objectForKey:@"TeamA"]];

    UILabel *teamBlabel = (UILabel*)[cell viewWithTag:2];
    [teamBlabel setText:[[[FullData shared].gameInfo objectAtIndex:indexPath.row] objectForKey:@"TeamB"]];

    UILabel *scoreAlabel = (UILabel*)[cell viewWithTag:3];
    [scoreAlabel setText:[[[FullData shared].gameInfo objectAtIndex:indexPath.row] objectForKey:@"scoreA"]];
    
    UILabel *scoreBlabel = (UILabel*)[cell viewWithTag:4];
    [scoreBlabel setText:[[[FullData shared].gameInfo objectAtIndex:indexPath.row] objectForKey:@"scoreB"]];
    
    return cell;
}
@end
