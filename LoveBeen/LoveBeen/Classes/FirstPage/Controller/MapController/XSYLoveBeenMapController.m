//
//  XSYLoveBeenMapController.m
//  LoveBeen
//
//  Created by xin on 2017/2/20.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenMapController.h"
#import <Masonry.h>
#import <SVProgressHUD.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件



@interface XSYLoveBeenMapController ()<BMKMapViewDelegate, BMKGeoCodeSearchDelegate, BMKLocationServiceDelegate>
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKGeoCodeSearch *searcher;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, assign) BOOL isNotFirstInit;
@property (nonatomic, strong) UITextField *addressTF;

@end

@implementation XSYLoveBeenMapController

- (void)viewWillAppear:(BOOL)animated
{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.locService.delegate = self;
    [self.view addSubview:self.addressTF];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    // 不用时，置nil
    self.locService.delegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - mapView delegate -
// 然后在mapView的一个代理方法里面打开定位功能
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    [self.locService startUserLocationService];
    //启动定位服务
    self.mapView.showsUserLocation = NO;
    //先关闭显示的定位图层
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;
    //设置定位的状态
    self.mapView.showsUserLocation = YES;
    //显示定位图层
}

#pragma mark - location delegate -
/** 用户位置更新后，会调用此函数 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [self.mapView updateLocationData:userLocation];
    
    //如果不是第一次初始化视图, 那么定位点置中
    if (self.isNotFirstInit == NO)
    {
        self.mapView.centerCoordinate = self.locService.userLocation.location.coordinate;
        self.isNotFirstInit = YES;
    }
    [self beginReverseGeoCodeSearch];

}

- (void)beginReverseGeoCodeSearch
{
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = self.mapView.centerCoordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [self.searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
        
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}
#pragma mark - BMKGeoCodeSearchDelegate
/** 接收反向地理编码结果 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //检索结果正常返回
    if (error == BMK_SEARCH_NO_ERROR)
    {
        //这里处理数据
        NSString *addressStr = [NSString stringWithFormat:@"%@%@%@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district];
        self.addressTF.text = addressStr;
       
        if (_mapBlock) {
            _mapBlock(addressStr);
        }
        
    } else {
        self.addressTF.text = @"抱歉未找到结果";
        NSLog(@"抱歉，未找到结果"); 
    }
}
- (void)didFailToLocateUserWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"无法定位"];
}
#pragma mark - lazy -
//初始化地图
- (BMKMapView *)mapView
{
    if (_mapView == nil) {
        _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
        [_mapView setZoomLevel:16];
        [self.view addSubview:_mapView];
    }
    return _mapView;
}
//地理编码(通过经纬度获取详细地址/通过地址获取经纬度)
- (BMKGeoCodeSearch *)searcher
{
    if (_searcher == nil)
    {
        _searcher =[[BMKGeoCodeSearch alloc]init];
        _searcher.delegate = self;
    }
    return _searcher;
}
//定位功能
- (BMKLocationService *)locService
{
    if (_locService == nil)
    {
        //初始化BMKLocationService
        _locService = [[BMKLocationService alloc]init];
        //设定定位精度
        _locService.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locService;
}

- (UITextField *)addressTF{
    if (_addressTF == nil) {
        _addressTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        _addressTF.text = @"正在自动定位中......";
        _addressTF.layer.borderWidth = 2;
        _addressTF.layer.borderColor = mainColor.CGColor;
        _addressTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _addressTF;
}

- (void)dealloc
{
    if (self.mapView)
    {
        self.mapView = nil;
    }
}
@end
