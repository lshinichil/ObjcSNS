//
//  EditViewController.m
//  ObjcFileApp
//
//  Created by 井元進一 on 2018/03/03.
//  Copyright © 2018年 NIFTY Corporation. All rights reserved.
//

#import "EditViewController.h"
#import "ViewController.h"
#import "NCMB/NCMB.h"


@interface EditViewController ()
- (IBAction)nextButton:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextView *titleText;
@property (weak, nonatomic) IBOutlet UITextView *messageText;



@end

@implementation EditViewController

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

- (IBAction)nextButton:(UIBarButtonItem *)sender {
    // 保存先クラスの作成
    NCMBObject *obj = [NCMBObject objectWithClassName:@"timeLine"];
    // 値を設定
//    [obj setObject:@"Hello,NCMB!" forKey:@"message"];
    [obj setObject:(@"%@",self.titleText.text) forKey:@"timeLineTitle"];
    [obj setObject:(@"%@",self.messageText.text) forKey:@"timeLineMessage"];

    
    
    // 保存を実施
    [obj saveInBackgroundWithBlock:^(NSError *error) {
        if (error){
            // 保存に失敗した場合の処理
            NSLog(@"エラーが発生しました。エラーコード：%ld", error.code);
            
            
        } else {
            // 保存に成功した場合の処理
            NSLog(@"保存に成功しました。objectId：%@", obj.objectId);
        }
    }];
    NSLog(@"ボタン押したよ");
    
    
    
 //   str = @"test"
    
    
    
     [self performSegueWithIdentifier:@"nextSegue" sender:self];
  //  performSegueWithIdentifier("screenTransition", sender: self);
}
@end
