//
//  XSYLoveBeenFirstPageWebViewController.m
//  LoveBeen
//
//  Created by xin on 2017/2/19.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenFirstPageWebViewController.h"
#import <SVProgressHUD.h>

@interface XSYLoveBeenFirstPageWebViewController ()<UIWebViewDelegate>

@end

@implementation XSYLoveBeenFirstPageWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webview.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [self.view addSubview:webview];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:self.url];//创建NSURLRequest
    [webview loadRequest:request];//加载
    
    // 设置代理
    webview.delegate = self;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"加载中"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:@"网络不佳"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // seconds秒后异步执行这里的代码...
        [SVProgressHUD dismiss];
    });
}
@end
