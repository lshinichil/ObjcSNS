//
//  ViewController.m
//  ObjcFileApp
//
//  Created by Natsumo Ikeda on 2016/05/31.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

#import "ViewController.h"

@interface ViewController ()



@property (weak, nonatomic) IBOutlet UIImageView *cameraView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.label.text = @"カメラで写真を撮りましょう！";
}

// 「写真を選ぶ」ボタン押下時の処理
- (IBAction)photoStart:(UIButton *)sender {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 写真が利用可能か確認する
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *cameraPiker = [[UIImagePickerController alloc] init];
        cameraPiker.sourceType = sourceType;
        cameraPiker.delegate = self;
        [self presentViewController:cameraPiker animated:YES completion:nil];
        
    } else {
        NSLog(@"エラーが発生しました");
        self.label.text = @"エラーが発生しました";
        
    }
}

// 「カメラを選ぶ」ボタン押下時の処理

- (IBAction)cameraStart:(UIButton *)sender {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    // カメラが利用可能か確認する
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *cameraPiker = [[UIImagePickerController alloc] init];
        cameraPiker.sourceType = sourceType;
        cameraPiker.delegate = self;
        [self presentViewController:cameraPiker animated:YES completion:nil];
        
    } else {
        NSLog(@"エラーが発生しました");
        self.label.text = @"エラーが発生しました";
        
    }
    
}

// 撮影が終了したときに呼ばれる
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *pickerImage = [info objectForKey: UIImagePickerControllerOriginalImage];
    _cameraView.contentMode = UIViewContentModeScaleAspectFit;
    _cameraView.image = pickerImage;
    self.label.text = @"撮った写真を保存しよう！";
    
    // 閉じる処理
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

// 撮影がキャンセルされた時に呼ばれる
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"キャンセルされました");
    self.label.text = @"キャンセルされました";
}

- (IBAction)saveButton:(UIBarButtonItem *)sender {
    UIImage *image = [_cameraView image];
    // 画像がnilのとき
    if (image == nil) {
        NSLog(@"画像がありません");
        self.label.text = @"画像がありません";
        
        return;
        
    }
    
    // 画像をリサイズする
    CGFloat imageW = image.size.width*0.2;
    CGFloat imageH = image.size.height*0.2;
    UIImage *resizeImage = [self resize :image:imageW:imageH];
    
    // ファイル名を決めるアラートを表示
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存します" message:@"ファイル名を指定してください" preferredStyle:UIAlertControllerStyleAlert];
    
    // UIAlertControllerにtextFieldを追加
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    
    // アラートのOK押下時の処理
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 入力したテキストをファイル名に指定
        NSString *fileName = [NSString stringWithFormat:@"%@.png", alert.textFields[0].text];
        
        // 画像をNSDataに変換
        NSData *pngData = [[NSData alloc] initWithData:UIImagePNGRepresentation(resizeImage)];
        NCMBFile *file = [NCMBFile fileWithName:fileName data:pngData];
        
        // ACLACL設定（読み書き可）
        NCMBACL *acl = [NCMBACL ACL];
        [acl setPublicReadAccess:YES];
        [acl setPublicWriteAccess:YES];
        [file setACL:acl];
        
        // ファイルストアへ画像のアップロード
        [file saveInBackgroundWithBlock:^(NSError *error) {
            if (error != nil) {
                // 保存失敗時の処理
                NSLog(@"保存に失敗しました。エラーコード：%ld", error.code);
                self.label.text =[NSString stringWithFormat:@"保存に失敗しました。エラーコード：%ld", error.code];
                
            } else {
                // 保存成功時の処理
                NSLog(@"保存に成功しました");
                self.label.text =@"保存に成功しました";
                
            }
            
        } progressBlock:^(int percentDone) {
            self.label.text = [NSString stringWithFormat:@"保存中：%d％", percentDone];
            
        }];
        
    }]];
    
    // アラートのCancel押下時の処理
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"保存がキャンセルされました");
        self.label.text =@"保存がキャンセルされました";
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

// 「mobile backendに保存」ボタン押下時の処理
- (IBAction)saveImage:(UIBarButtonItem *)sender {
    UIImage *image = [_cameraView image];
    // 画像がnilのとき
    if (image == nil) {
        NSLog(@"画像がありません");
        self.label.text = @"画像がありません";
        
        return;
        
    }
    
    // 画像をリサイズする
    CGFloat imageW = image.size.width*0.2;
    CGFloat imageH = image.size.height*0.2;
    UIImage *resizeImage = [self resize :image:imageW:imageH];
    
    // ファイル名を決めるアラートを表示
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存します" message:@"ファイル名を指定してください" preferredStyle:UIAlertControllerStyleAlert];
    
    // UIAlertControllerにtextFieldを追加
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    
    // アラートのOK押下時の処理
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 入力したテキストをファイル名に指定
        NSString *fileName = [NSString stringWithFormat:@"%@.png", alert.textFields[0].text];
        
        // 画像をNSDataに変換
        NSData *pngData = [[NSData alloc] initWithData:UIImagePNGRepresentation(resizeImage)];
        NCMBFile *file = [NCMBFile fileWithName:fileName data:pngData];
        
        // ACLACL設定（読み書き可）
        NCMBACL *acl = [NCMBACL ACL];
        [acl setPublicReadAccess:YES];
        [acl setPublicWriteAccess:YES];
        [file setACL:acl];
        
        // ファイルストアへ画像のアップロード
        [file saveInBackgroundWithBlock:^(NSError *error) {
            if (error != nil) {
                // 保存失敗時の処理
                NSLog(@"保存に失敗しました。エラーコード：%ld", error.code);
                self.label.text =[NSString stringWithFormat:@"保存に失敗しました。エラーコード：%ld", error.code];
                
            } else {
                // 保存成功時の処理
                NSLog(@"保存に成功しました");
                self.label.text =@"保存に成功しました";
                
            }
            
        } progressBlock:^(int percentDone) {
            self.label.text = [NSString stringWithFormat:@"保存中：%d％", percentDone];
            
        }];
        
    }]];
    
    // アラートのCancel押下時の処理
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"保存がキャンセルされました");
        self.label.text =@"保存がキャンセルされました";
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

// 画像をリサイズする処理
- (UIImage *)resize:(UIImage *)image :(CGFloat)width :(CGFloat)height {
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:(CGRectMake(0, 0, size.width, size.height))];
    UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizeImage;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
