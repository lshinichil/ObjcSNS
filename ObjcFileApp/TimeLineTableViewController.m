//
//  TimeLineTableViewController.m
//  ObjcFileApp
//
//  Created by 井元進一 on 2018/03/04.
//  Copyright © 2018年 NIFTY Corporation. All rights reserved.
//

#import "TimeLineTableViewController.h"
#import "timeLineTableViewCell.h"

@interface TimeLineTableViewController ()<UITableViewDataSource,UITextFieldDelegate>{
    NSArray *TitleArray;
    NSMutableArray *imageNameArray;
}

@end

@implementation TimeLineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [TitleArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    timeLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeLineCell"];
    if (!cell){
        [tableView registerNib:[UINib nibWithNibName:@"timeLineTableViewCell" bundle:nil]
        forCellReuseIdentifier:@"TimeLineCell"];
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"TimeLineCell"];
    }
    cell.titleText.text = [TitleArray objectAtIndex:indexPath.row];
    [cell.photoImage setImage:[UIImage imageNamed:[NSString stringWithFormat: @"load.jpge"]]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}


@end
