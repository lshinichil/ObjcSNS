//
//  TimeLineViewController.m
//  ObjcFileApp
//
//  Created by 井元進一 on 2018/03/03.
//  Copyright © 2018年 NIFTY Corporation. All rights reserved.
//

#import "TimeLineViewController.h"
#import "NCMB/NCMB.h"

@interface TimeLineViewController ()<UITableViewDataSource,UITableViewDelegate>{
NSArray *TitleArray;
NSMutableArray *imageNameArray;
    
}


@property (weak, nonatomic) IBOutlet UILabel *timeLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLineMessage;

- (IBAction)timeLineButton:(UIButton *)sender;
@end


@implementation TimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TitleArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",nil];
    // Do any additional setup after loading the view.
}
-(void)arraySetLoad {
    imageNameArray = [NSMutableArray arrayWithArray:@[@"load.jpge",@"load.jpge",@"load.jpge",@"load.jpge"]];
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


- (IBAction)timeLineButton:(UIButton *)sender {
    
    
    
    NCMBObject *saved = [NCMBObject objectWithClassName:@"timeLine"];
    
    saved.objectId = @"yDrC1aTY2n8lVGCB";
    
    [saved fetch:nil];
    
    NSDate *date = [saved objectForKey:@"timeLineMessage"];
    NSData *data1 = [saved objectForKey:@"timeLineTitle"];
    NSLog(@"date:%@", date);
    
    self.timeLineLabel.text = [NSString stringWithFormat:@"%@",date];
    self.timeLineMessage.text = [NSString stringWithFormat:@"%@",data1];
    
    
}
@end
