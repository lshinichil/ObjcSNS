//
//  TableViewController.m
//  ObjcFileApp
//
//  Created by 井元進一 on 2018/03/04.
//  Copyright © 2018年 NIFTY Corporation. All rights reserved.
//

#import "TableViewController.h"
#import "timeLineTableViewCell.h"

@interface TableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *TitleArray;
    NSMutableArray *imageNameArray;
}
@property (weak, nonatomic) IBOutlet UITableView *timeLineTable;
@end
@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        TitleArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    // Do any additional setup after loading the view.
}

-(void)arraySetLoad {
    imageNameArray = [NSMutableArray arrayWithArray:@[@"load.jpge",@"load.jpge",@"load.jpge",@"load.jpge"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
    //[TitleArray count];

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
    return 500;
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
