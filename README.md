# 【iOS Objective-C】写真をクラウドに保存しよう！
![画像1](/readme-img/001.png)

## 概要
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の『ファイルストア機能』を利用して、「撮った写真をクラウドに保存する」内容を実装したサンプルプロジェクトです
* 簡単な操作ですぐに [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の機能を体験いただけます★☆

## ニフティクラウドmobile backendって何？？
スマートフォンアプリのバックエンド機能（プッシュ通知・データストア・会員管理・ファイルストア・SNS連携・位置情報検索・スクリプト）が**開発不要**、しかも基本**無料**(注1)で使えるクラウドサービス！

注1：詳しくは[こちら](http://mb.cloud.nifty.com/price.htm)をご覧ください

![画像2](/readme-img/002.png)

## 動作環境
* Mac OS X 10.10(Yosemite)
* Xcode ver. 7.2.1
* iPhone6 ver. 8.2
 * このサンプルアプリは、端末のカメラを使用するため、実機ビルドが必要です

※上記内容で動作確認をしています。


## 手順
### 1. [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の会員登録とログイン→アプリ作成

* 上記リンクから会員登録（無料）をします。登録ができたらログインをすると下図のように「アプリの新規作成」画面が出るのでアプリを作成します

![画像3](/readme-img/003.png)

* アプリ作成されると下図のような画面になります
* この２種類のAPIキー（アプリケーションキーとクライアントキー）はXcodeで作成するiOSアプリに[ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)を紐付けるために使用します

![画像4](/readme-img/004.png)

* 動作確認後に写真（画像）が保存される場所も確認しておきましょう

![画像5](/readme-img/005.png)

#### 2. GitHubからサンプルプロジェクトのダウンロード
* 下記リンクをクリックしてプロジェクトをダウンロードをMacにダウンロードします
 * __[ObjcFileApp](https://github.com/natsumo/ObjcFileApp/archive/master.zip)__

### 3. Xcodeでアプリを起動
* ダウンロードしたフォルダを開き、「ObjcFileApp.xcworkspace」をダブルクリックしてXcode開きます(白い方です)

![画像09](/readme-img/009.png)

![画像6](/readme-img/006.png)

* 「ObjcFileApp.xcodeproj」（青い方）ではないので注意してください！
![画像08](/readme-img/008.png)
### 4. APIキーの設定

* `AppDelegate.m`を編集します
* 先程[ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のダッシュボード上で確認したAPIキーを貼り付けます

![画像07](/readme-img/007.png)

* それぞれ`YOUR_NCMB_APPLICATION_KEY`と`YOUR_NCMB_CLIENT_KEY`の部分を書き換えます
 * このとき、ダブルクォーテーション（`"`）を消さないように注意してください！
* 書き換え終わったら`command + s`キーで保存をします

### 5. 動作確認
* lightningケーブルでiPhoneをMacにつなぎます
 * 実機ビルドが初めての場合は[こちら](http://qiita.com/natsumo/items/3f1dd0e7f5471bd4b7d9)をご覧いただき、実機ビルドの準備をお願いします
* Xcode画面で左上で、接続したiPhoneを選び、実行ボタン（さんかくの再生マーク）をクリックします

![画像1](/readme-img/001.png)

* アプリが起動したら、①「カメラ」ボタンをタップして、写真を撮影します
* 次に、②「mobile backendに保存」ボタンをタップします

![画像13](/readme-img/013.png)

* 写真に名前を付けます
* 「OK」をタップすると写真がクラウドに保存されます
 * 保存に失敗した場合は画面にエラーコードが表示されます
 * 万が一エラーが発生した場合は、[こちら](http://mb.cloud.nifty.com/doc/current/rest/common/error.html)よりエラー内容を確認いただけます

-----

* 保存に成功したら、[ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のダッシュボードから「ファイルストア」を確認してみましょう！

![画像12](/readme-img/012.png)

* 簡単に写真がクラウドに保存できました☆★

## 解説
サンプルプロジェクトに実装済みの内容のご紹介

#### SDKのインポートと初期設定
* ニフティクラウドmobile backend の[ドキュメント（クイックスタート）](http://mb.cloud.nifty.com/doc/current/introduction/quickstart_ios.html)をご活用ください
 * このDEMOアプリは「CocoaPods」を利用する方法でSDKをインポートしています

#### ロジック
 * `Main.storyboard`でデザインを作成し、`ViewController.m`にロジックを書いています
 * 写真をクラウドに保存する処理は以下のように記述されます

```Objc
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

// 「カメラ」ボタン押下時の処理
- (IBAction)cameraStart:(UIBarButtonItem *)sender {
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
    self.label.text = @"撮った写真をクラウドに保存しよう！";

    // 閉じる処理
    [picker dismissViewControllerAnimated:YES completion:nil];

}

// 撮影がキャンセルされた時に呼ばれる
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"キャンセルされました");
    self.label.text = @"キャンセルされました";
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
```

* 【注意】[ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のBasicプラン（無料）では、1度にアップロードできるファイルの上限が５MBとなっています。iPhoneで撮影した写真はその制限を超えてしまうため、圧縮して保存を行っています。（有償プランの場合上限は異なります。詳しくは[こちら](http://mb.cloud.nifty.com/price.htm)）


## 参考
* 同じ内容の【Swift】版もご用意しています
 * https://github.com/natsumo/SwiftFileApp
* ニフティクラウドmobile backend の[ドキュメント（ファイルストア）](http://mb.cloud.nifty.com/doc/current/filestore/basic_usage_ios.html)をSwift版に書き換えたドキュメントをご用意していますので、ご活用ください
 * [Swiftでファイルをサーバーに保存しよう！](http://qiita.com/natsumo/items/974247b3b27ec0880dc6)
