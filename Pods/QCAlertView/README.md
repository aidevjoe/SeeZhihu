# QCAlertView
---

### QCAlertView 是一个提示框组件,类似系统的 AlertView、SheetView


---
Gif 演示

 ![image](https://github.com/Joe0708/QCAlertView/raw/master/Demo.gif)



## 安装
---
推荐您使用[CocoaPods](http://cocoapods.org/)进行安装, 只需添加
>pod 'QCAlertView'

并运行 pod install 即可安装最新版

或者下载项目, 将项目中的 QCAlertView 目录, 拖入到您的项目中即可

## 使用
---
    //QCMessageAlertView
    [QCMessageAlertView showAlertWithMessage:@"Hello world !"];
    
    
    
    //QCButtonsAlertView
    [QCButtonsAlertView showAlertWithContentView:self.view andMessage:@"Sure to exit?" andButtonsTitle:@[@"Yes", @"No"] alertViewblock:^(QCAlertView *view, NSInteger tag) {
        NSLog(@"%li", tag);
    }];
    
    
    
     //QCButtonsAlertView
    [QCLoadingView showLoadingView];
    
    
    

    //QCSheetView
    [QCSheetView showSheetViewWithMessage:@"确定退出登录吗?." andButtonsTitle:@[@"换个账号", @"退出"] alertViewblock:^(NSInteger tag) {
        NSLog(@"%li", tag);
    }];