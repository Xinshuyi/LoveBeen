//
//  XSYLoveBeenQRControllerViewController.m
//  LoveBeen
//
//  Created by xin on 2017/2/21.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenQRControllerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>
#import "sys/utsname.h"

@interface XSYLoveBeenQRControllerViewController ()<AVCaptureMetadataOutputObjectsDelegate
>
@property (strong, nonatomic) AVCaptureSession  *session;

@property (strong, nonatomic) UIImageView *areaImageView;
@property (strong, nonatomic) UIImageView *lineImageView;
@end

@implementation XSYLoveBeenQRControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.areaImageView];
    [self.view addSubview:self.lineImageView];
    [self setSubviewFrame];
    [self startAnimation];
    BOOL isAvailable = [self cameraIsAvailable];
    if (isAvailable) {
        [self setupQRSetting];
    }else{
        [self alertViewOfUsingMobile];
    }
}

- (void)alertViewOfUsingMobile{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请用真机" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加确定action
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        // 退回到前一页
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:sureAction];
    // 展现提示框
    [self presentViewController:alertController animated:YES completion:nil];
}

// 判断相机是否可用
-(BOOL)cameraIsAvailable
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if([deviceString isEqualToString:@"x86_64"]){
        return false;
    }
    return true;
}
- (void)setupQRSetting{
    // 1. 创建输入
    AVCaptureDevice *cameraDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureInput *input = [AVCaptureDeviceInput deviceInputWithDevice:cameraDevice error:nil];
    // 2. 创建输出
    AVCaptureMetadataOutput *output = [AVCaptureMetadataOutput new];
    // 2.1 设置代理，实现数据获取
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 3. 创建会话
    self.session = [AVCaptureSession new];
    // 4. 关联输入和输出到会话中
    if([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    if([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
    // 2.2 设置识别类型(注意输出必须先添加到session中)
    // 二维码 AVMetadataObjectTypeQRCode
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    // 5. 设置预览
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    // 6. 启动会话
    [self.session startRunning];
}
- (void)startAnimation{
    CGPoint originPoint = self.lineImageView.layer.position;
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"position"] ;
    scaleAnim.fromValue = [NSValue valueWithCGPoint:originPoint];
    scaleAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(self.areaImageView.center.x, CGRectGetMaxY(self.areaImageView.frame) - 5)];
    scaleAnim.duration = 4;
    scaleAnim.repeatCount = INT_MAX;
    [self.lineImageView.layer addAnimation:scaleAnim forKey:nil];
}

- (void)setSubviewFrame{
    self.areaImageView.center = self.view.center;
    
    self.lineImageView.frame = CGRectMake(self.areaImageView.frame.origin.x, self.areaImageView.frame.origin.y, self.areaImageView.frame.size.width, 5);
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate -
// 处理识别后的数据
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    for (AVMetadataMachineReadableCodeObject *obj in metadataObjects) {
        NSLog(@"metadataObjects:%@",obj.stringValue);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:obj.stringValue]];
    }
}

#pragma mark - lazy -
- (UIImageView *)areaImageView{
    if (_areaImageView == nil) {
        _areaImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg"]];
        [_areaImageView sizeToFit];
    }
    return _areaImageView;
}

- (UIImageView *)lineImageView{
    if (_lineImageView == nil) {
        _lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    }
    return _lineImageView;
}
@end
