//
//  HomeViewController.m
//  ObjcFileApp
//
//  Created by 井元進一 on 2018/03/03.
//  Copyright © 2018年 NIFTY Corporation. All rights reserved.
//

#import "HomeViewController.h"
#import "NCMB/NCMB.h"

@interface HomeViewController ()
- (IBAction)downLoad:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *homeImage;

@end

@implementation HomeViewController

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

- (IBAction)downLoad:(UIButton *)sender {
    // 取得する画像ファイル名を設定
    NCMBFile *imageFile = [NCMBFile fileWithName:@"mmm.png" data:nil];
    // 画像ファイルを取得
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (error != nil) {
            // 取得失敗時の処理
            NSLog(@"画像ファイルの取得に失敗しました：%ld",(long)error.code);
            self.statusLabel.text = [NSString stringWithFormat:@"NG エラーコード：%ld",(long)error.code];
        } else {
            // 取得成功時の処理
            NSLog(@"画像ファイルの取得に成功しました");
            self.statusLabel.text = @"OK";
            // 画像を表示する処理
            self.homeImage.image = [UIImage imageWithData:data];
        }
    } progressBlock:^(int percentDone) {
        self.statusLabel.text = [NSString stringWithFormat:@"%d %%",percentDone];
    }];
    
}
@end
